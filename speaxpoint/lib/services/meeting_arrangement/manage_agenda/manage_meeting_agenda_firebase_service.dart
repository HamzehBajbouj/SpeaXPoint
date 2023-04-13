import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/models/meeting_agenda.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/meeting_arrangement_common_firebase_services.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_agenda/i_manage_meeting_agenda_service.dart';

class ManageMeetingAgendaFirebaseSerivce
    extends MeetingArrangementCommonFirebaseServices
    implements IManageMeetingAgendaService {
  final CollectionReference _chapterMeetingsCollection =
      FirebaseFirestore.instance.collection('ChapterMeetings');

  @override
  Future<Result<Unit, Failure>> createEmptyAgendaCard(
      String chapterMeetingId, int agendaCardOrder) async {
    //chapterMeetingId is passed from the card to the bottomsheet..etc
    try {
      QuerySnapshot querySnapshot = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        CollectionReference meetingAgenda =
            querySnapshot.docs.first.reference.collection("MeetingAgenda");
        await meetingAgenda.doc(agendaCardOrder.toString()).set(
          {
            'agendaCardOrder': agendaCardOrder,
          },
        );
      } else {
        return Error(
          Failure(
              code: "No-Chapter-Meeting-Is-Found",
              location:
                  "ManageMeetingAgendaFirebaseSerivce.createEmptyAgendaCard()",
              message:
                  "there are no matching record for chapter meeting with ID ${chapterMeetingId}"),
        );
      }

      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "ManageMeetingAgendaFirebaseSerivce.createEmptyAgendaCard()",
            message: e.message ??
                "Database Error While creating a new meeting agneda"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "ManageMeetingAgendaFirebaseSerivce.createEmptyAgendaCard()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> generateListOfEmptyAgendaCards(
      String chapterMeetingId, int numberOfCards) async {
    try {
      QuerySnapshot querySnapshot = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        WriteBatch batch = FirebaseFirestore.instance.batch();
        CollectionReference meetingAgenda =
            querySnapshot.docs.first.reference.collection("MeetingAgenda");

        for (int i = 0; i < numberOfCards; i++) {
          batch.set(
            meetingAgenda.doc(i.toString()),
            {
              'agendaCardOrder': i,
            },
          );
        }
        await batch.commit();
      } else {
        return Error(
          Failure(
              code: "No-Chapter-Meeting-Is-Found",
              location:
                  "ManageMeetingAgendaFirebaseSerivce.generateListOfEmptyAgendaCards()",
              message:
                  "there are no matching record for chapter meeting with ID ${chapterMeetingId}"),
        );
      }

      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "ManageMeetingAgendaFirebaseSerivce.generateListOfEmptyAgendaCards()",
            message:
                e.message ?? "Database Error While generating meeting agneda"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "ManageMeetingAgendaFirebaseSerivce.generateListOfEmptyAgendaCards()",
            message: e.toString()),
      );
    }
  }

  //this streams depends hevaily on the another stream , which is AllocatedRolePlayers
  //the resoan behined using streams

  @override
  Stream<List<MeetingAgneda>> getAllMeetingAgenda(
      String chapterMeetingId) async* {
    Stream<List<MeetingAgneda>> meetingAgendaList = const Stream.empty();

    try {
      Stream<List<AllocatedRolePlayer>> allocatedRolePlayer =
          super.getAllAllocatedRolePlayers(chapterMeetingId);

      QuerySnapshot _chapterMeeting = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();

      CollectionReference meetingAgenda =
          _chapterMeeting.docs.first.reference.collection("MeetingAgenda");

      meetingAgendaList = meetingAgenda.snapshots().map(
            (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
              (e) {
                return MeetingAgneda.fromJson(e.data() as Map<String, dynamic>);
              },
            ).toList(),
          );
      Stream<List<MeetingAgneda>> agendaWithAllocatedRolePlayers =
          Rx.combineLatest2<List<MeetingAgneda>, List<AllocatedRolePlayer>,
              List<MeetingAgneda>>(
        meetingAgendaList,
        allocatedRolePlayer,
        (agendas, allocatedRolePlayers) {
          for (var agenda in agendas) {
            var rolePlayers = allocatedRolePlayers
                .where(
                  (rolePlayer) =>
                      rolePlayer.roleName == agenda.roleName &&
                      rolePlayer.roleOrderPlace == agenda.roleOrderPlace,
                )
                .toList();

            agenda.allocatedRolePlayerDetails =
                rolePlayers.isNotEmpty ? rolePlayers[0] : null;
          }
          return agendas;
        },
      );

      yield* agendaWithAllocatedRolePlayers;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* meetingAgendaList;
    } catch (e) {
      log(e.toString());
      yield* meetingAgendaList;
    }
  }

  @override
  Future<Result<Unit, Failure>> deleteAgendaCard(
      String chapterMeetingId, int agendaCardNumber) async {
    try {
      QuerySnapshot querySnapshot = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        CollectionReference meetingAgenda =
            querySnapshot.docs.first.reference.collection("MeetingAgenda");
        DocumentReference agendaDocRef = await meetingAgenda
            .where("agendaCardOrder", isEqualTo: agendaCardNumber)
            .get()
            .then((querySnapshot) => querySnapshot.docs.first.reference);

        await agendaDocRef.delete();
      } else {
        return Error(
          Failure(
              code: "No-Chapter-Meeting-Is-Found",
              location:
                  "ManageMeetingAgendaFirebaseSerivce.createEmptyAgendaCard()",
              message:
                  "there are no matching record for chapter meeting with ID ${chapterMeetingId}"),
        );
      }

      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "ManageMeetingAgendaFirebaseSerivce.deleteAgendaCard()",
            message:
                e.message ?? "Database Error While delete the agenda card"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "ManageMeetingAgendaFirebaseSerivce.deleteAgendaCard()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> updateAgendaTime(String chapterMeetingId,
      String timeSequence, int agendaCardNumber) async {
    try {
      super.getMeetingAgendaCollectionRef(chapterMeetingId).then(
        (meetingAgendaCR) async {
          QuerySnapshot agendaQuerySnapshot = await meetingAgendaCR
              .where("agendaCardOrder", isEqualTo: agendaCardNumber)
              .get();
          if (agendaQuerySnapshot.docs.isNotEmpty) {
            await agendaQuerySnapshot.docs.first.reference.update(
              {
                'timeSequence': timeSequence,
              },
            );
          } else {
            return Error(
              Failure(
                  code: "No-Agenda-Card",
                  location:
                      "ManageMeetingAgendaFirebaseSerivce.updateAgendaTime()",
                  message:
                      "No agenda record found for agenda card $agendaCardNumber"),
            );
          }
        },
      );

      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "ManageMeetingAgendaFirebaseSerivce.updateAgendaTime()",
            message: e.message ?? "Database Error While updating agenda time"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "ManageMeetingAgendaFirebaseSerivce.updateAgendaTime()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> updateAgendaCardDetails(
      String chapterMeetingId, MeetingAgneda agnedaCard) async {
    try {
      super.getMeetingAgendaCollectionRef(chapterMeetingId).then(
        (meetingAgendaCR) async {
          QuerySnapshot agendaQuerySnapshot = await meetingAgendaCR
              .where("agendaCardOrder", isEqualTo: agnedaCard.agendaCardOrder)
              .get();
          if (agendaQuerySnapshot.docs.isNotEmpty) {
            await agendaQuerySnapshot.docs.first.reference.update(
              {
                'roleOrderPlace': agnedaCard.roleOrderPlace,
                'roleName': agnedaCard.roleName,
                'agendaTitle': agnedaCard.agendaTitle
              },
            );
          } else {
            return Error(
              Failure(
                  code: "No-Agenda-Card",
                  location:
                      "ManageMeetingAgendaFirebaseSerivce.updateAgendaCardDetails()",
                  message:
                      "No agenda record found for agenda card ${agnedaCard.agendaCardOrder}"),
            );
          }
        },
      );
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "ManageMeetingAgendaFirebaseSerivce.updateAgendaCardDetails()",
            message:
                e.message ?? "Database Error While updating agenda details"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "ManageMeetingAgendaFirebaseSerivce.updateAgendaCardDetails()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<List<MeetingAgneda>, Failure>>
      getListOfAllAgendaWithNoAllocatedRolePlayers(
          String chapterMeetingId) async {
    List<MeetingAgneda> meetingAgenda = [];
    List<AllocatedRolePlayer> allocatedRolePlayerList = [];
    try {
      await super.getAllAllocatedRolePlayersList(chapterMeetingId).then(
        (result) {
          result.when(
            (success) {
              allocatedRolePlayerList = success;
            },
            (error) {
              allocatedRolePlayerList = [];
            },
          );
        },
      );
      await super.getMeetingAgendaCollectionRef(chapterMeetingId).then(
        (coolectionRef) async {
          QuerySnapshot agendaQS = await coolectionRef.get();
          if (agendaQS.docs.isNotEmpty) {
            meetingAgenda = agendaQS.docs
                .map((e) =>
                    MeetingAgneda.fromJson(e.data() as Map<String, dynamic>))
                .toList();
          }
          // this will search for the matching role players and assgin them to
          //agenda.allocatedRolePlayerDetails, if not it returns null,
          for (var agenda in meetingAgenda) {
            var rolePlayers = allocatedRolePlayerList
                .where(
                  (rolePlayer) =>
                      rolePlayer.roleName == agenda.roleName &&
                      rolePlayer.roleOrderPlace == agenda.roleOrderPlace,
                )
                .toList();

            agenda.allocatedRolePlayerDetails =
                rolePlayers.isNotEmpty ? rolePlayers[0] : null;
          }

          // after we matched everything we want only the value of array where allocatedRolePlayerDetails
          //is empty
          meetingAgenda = meetingAgenda
              .where((element) =>
                  element.allocatedRolePlayerDetails == null &&
                  element.roleName != null &&
                  element.roleOrderPlace != null)
              .toList();
        },
      );
      return Success(meetingAgenda);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "ManageMeetingAgendaFirebaseSerivce.getListOfAllAgendaWithNoAllocatedRolePlayers()",
            message:
                e.message ?? "Database Error While getting meeting agenda"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "ManageMeetingAgendaFirebaseSerivce.getListOfAllAgendaWithNoAllocatedRolePlayers()",
            message: e.toString()),
      );
    }
  }
}
