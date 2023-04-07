import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/models/meeting_agenda.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/meeting_arrangement/allocate_role_players/allocate_role_player_firebase_service.dart';
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

      yield* meetingAgendaList;
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
  Future<Result<Unit, Failure>> updateAgendaTime(
      String chapterMeetingId, int agendaCardNumber) {
    // TODO: implement updateAgendaTime
    throw UnimplementedError();
  }
}
