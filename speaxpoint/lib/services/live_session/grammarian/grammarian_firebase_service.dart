import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/models/grammarian_note.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/live_session/grammarian/i_grammarian_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';

class GrammarianFirebaseService extends IGrammarianService {
  final CollectionReference _onlineSessionCapturedDataC =
      FirebaseFirestore.instance.collection('OnlineSessionCapturedData');

  @override
  Future<Result<Unit, Failure>> addGrammaticalNote(
      {required GrammarianNote grammarianNote,
      required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async {
    try {
      QuerySnapshot onlineSessionCapturedDataQS;
      if (currentSpeakerisAppGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode",
                isEqualTo: currentSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: currentSpeakerToastmasterId)
            .get();
      }

      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference grammarianCapturedDataC =
            onlineSessionCapturedDataQS.docs.first.reference
                .collection("GrammarianCapturedData");
        await grammarianCapturedDataC.add(
          grammarianNote.toJson(),
        );
      } else {
        return const Error(
          Failure(
              code: "No-Speaker-Found",
              location: "GrammarianFirebaseService.addGrammaticalNote()",
              message: "Could not found a speaker speech record"),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "GrammarianFirebaseService.addGrammaticalNote()",
            message: e.message ??
                "Database Error While adding speaker grammatical notes data"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "GrammarianFirebaseService.addGrammaticalNote()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> deleteGrammaticalNote(
      {required String noteId,
      required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async {
    try {
      QuerySnapshot onlineSessionCapturedDataQS;
      if (currentSpeakerisAppGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode",
                isEqualTo: currentSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: currentSpeakerToastmasterId)
            .get();
      }

      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference grammarianCapturedDatac =
            onlineSessionCapturedDataQS.docs.first.reference
                .collection("GrammarianCapturedData");
        QuerySnapshot grammarianCapturedDataQS = await grammarianCapturedDatac
            .where("noteId", isEqualTo: noteId)
            .get();

        if (grammarianCapturedDataQS.docs.isNotEmpty) {
          await grammarianCapturedDataQS.docs.first.reference.delete();
        } else {
          return Error(
            Failure(
                code: "No-Grammatical-Note-Found",
                location: "GrammarianFirebaseService.deleteGrammaticalNote()",
                message:
                    "Could not found the grammatical note with NoteId : $noteId"),
          );
        }
      } else {
        return const Error(
          Failure(
              code: "No-Speaker-Found",
              location: "GrammarianFirebaseService.deleteGrammaticalNote()",
              message: "Could not found a speaker speech record"),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "GrammarianFirebaseService.deleteGrammaticalNote()",
            message: e.message ??
                "Database Error While deleting speaker grammatical notes data"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "GrammarianFirebaseService.deleteGrammaticalNote()",
            message: e.toString()),
      );
    }
  }

  @override
  Stream<List<GrammarianNote>> getGrammaticalNotes(
      {required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async* {
    Stream<List<GrammarianNote>> grammarianNotes = Stream.empty();

    try {
      QuerySnapshot onlineSessionCapturedDataQS;
      if (currentSpeakerisAppGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode",
                isEqualTo: currentSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: currentSpeakerToastmasterId)
            .get();
      }
      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference grammarianCapturedDataC =
            onlineSessionCapturedDataQS.docs.first.reference
                .collection("GrammarianCapturedData");
        // Create a stream transformer to convert the QuerySnapshot to Map<String, int>
        grammarianNotes = grammarianCapturedDataC
            .where('typeOfGrammarianNote',
                isEqualTo: GrammarianNoteType.GrammaticalNote.name)
            .snapshots()
            .map(
              (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
                (e) {
                  return GrammarianNote.fromJson(
                    e.data() as Map<String, dynamic>,
                  );
                },
              ).toList(),
            );
      }

      yield* grammarianNotes;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* grammarianNotes;
    } catch (e) {
      log(e.toString());
      yield* grammarianNotes;
    }
  }

  @override
  Future<Result<int, Failure>> getWOTDUsagesCount(
      {required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async {
    int WOTDcount = 0;
    try {
      QuerySnapshot onlineSessionCapturedDataQS;
      if (currentSpeakerisAppGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode",
                isEqualTo: currentSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: currentSpeakerToastmasterId)
            .get();
      }

      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference grammarianCapturedDatac =
            onlineSessionCapturedDataQS.docs.first.reference
                .collection("GrammarianCapturedData");
        QuerySnapshot wotdDataQS = await grammarianCapturedDatac
            .where('typeOfGrammarianNote',
                isEqualTo: GrammarianNoteType.WOTD.name)
            .get();
        WOTDcount = wotdDataQS.docs.length;
      } else {
        return const Error(
          Failure(
              code: "No-Speaker-Found",
              location: "GrammarianFirebaseService.getWOTDUsagesCount()",
              message: "Could not found a speaker speech record"),
        );
      }
      return Success(WOTDcount);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "GrammarianFirebaseService.getWOTDUsagesCount()",
            message: e.message ??
                "Database Error While getting speaker WOTD usage count data"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "GrammarianFirebaseService.getWOTDUsagesCount()",
            message: e.toString()),
      );
    }
  }

  @override
  Stream<int> getWOTDUsagesLiveDataCount(
      {required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async* {
    Stream<int> wotdUsagesCount = Stream.empty();
    try {
      QuerySnapshot onlineSessionCapturedDataQS;
      if (currentSpeakerisAppGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode",
                isEqualTo: currentSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: currentSpeakerToastmasterId)
            .get();
      }
      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference grammarianCapturedDataC =
            onlineSessionCapturedDataQS.docs.first.reference
                .collection("GrammarianCapturedData");
        // Create a stream transformer to convert the QuerySnapshot to Map<String, int>
        wotdUsagesCount = grammarianCapturedDataC
            .where('typeOfGrammarianNote',
                isEqualTo: GrammarianNoteType.WOTD.name)
            .snapshots()
            .map(
          (QuerySnapshot snapshot) {
            return snapshot.size;
          },
        );
      }

      yield* wotdUsagesCount;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* wotdUsagesCount;
    } catch (e) {
      log(e.toString());
      yield* wotdUsagesCount;
    }
  }

  @override
  Future<Result<Unit, Failure>> decreaseWOTDCounter(
      {required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async {
    try {
      QuerySnapshot onlineSessionCapturedDataQS;
      if (currentSpeakerisAppGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode",
                isEqualTo: currentSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: currentSpeakerToastmasterId)
            .get();
      }

      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference grammarianCapturedDataC =
            onlineSessionCapturedDataQS.docs.first.reference
                .collection("GrammarianCapturedData");
        QuerySnapshot grammarianCapturedDataQS = await grammarianCapturedDataC
            .where('typeOfGrammarianNote',
                isEqualTo: GrammarianNoteType.WOTD.name)
            .orderBy('capturingTime', descending: true)
            .limit(1)
            .get();
        if (grammarianCapturedDataQS.docs.isNotEmpty) {
          await grammarianCapturedDataQS.docs.first.reference.delete();
        }
        //we can return an error when there is no docuements to delete, or do nothing
        // else {
        //   return const Error(
        //     Failure(
        //         code: "No-WOTD-Recotd-Found",
        //         location: "GrammarianFirebaseService.decreaseWOTDCounter()",
        //         message:
        //             "Could not find the latest WOTD usage captured data for type"),
        //   );
        // }
      } else {
        return const Error(
          Failure(
              code: "No-Speaker-Found",
              location: "GrammarianFirebaseService.decreaseWOTDCounter()",
              message: "Could not found a speaker speech record"),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "GrammarianFirebaseService.decreaseWOTDCounter()",
            message:
                e.message ?? "Database Error While deleting latest WOTD data"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "GrammarianFirebaseService.decreaseWOTDCounter()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> increaseWOTDCounter(
      {required GrammarianNote grammarianNote,
      required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async {
    try {
      QuerySnapshot onlineSessionCapturedDataQS;
      if (currentSpeakerisAppGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode",
                isEqualTo: currentSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: currentSpeakerToastmasterId)
            .get();
      }

      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference grammarianCapturedDataC =
            onlineSessionCapturedDataQS.docs.first.reference
                .collection("GrammarianCapturedData");
        await grammarianCapturedDataC.add({
          'capturingTime': grammarianNote.noteCapturedTime,
          'typeOfGrammarianNote': grammarianNote.typeOfGrammarianNote,
        });
      } else {
        return const Error(
          Failure(
              code: "No-Speaker-Found",
              location: "GrammarianFirebaseService.increaseWOTDCounter()",
              message: "Could not found a speaker speech record"),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "GrammarianFirebaseService.increaseWOTDCounter()",
            message: e.message ?? "Database Error While adding new WOTD data"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "GrammarianFirebaseService.increaseWOTDCounter()",
            message: e.toString()),
      );
    }
  }

  @override
  Stream<int> getTotalNumberOfGrammaticalNotes(
      {required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async* {
    Stream<int> grammaticalNoteCounter = Stream.empty();
    try {
      QuerySnapshot onlineSessionCapturedDataQS;
      if (currentSpeakerisAppGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode",
                isEqualTo: currentSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: currentSpeakerToastmasterId)
            .get();
      }
      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference grammarianCapturedDataC =
            onlineSessionCapturedDataQS.docs.first.reference
                .collection("GrammarianCapturedData");
        // Create a stream transformer to convert the QuerySnapshot to Map<String, int>
        grammaticalNoteCounter = grammarianCapturedDataC
            .where('typeOfGrammarianNote',
                isEqualTo: GrammarianNoteType.GrammaticalNote.name)
            .snapshots()
            .map(
          (QuerySnapshot snapshot) {
            return snapshot.size;
          },
        );
      }

      yield* grammaticalNoteCounter;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* grammaticalNoteCounter;
    } catch (e) {
      log(e.toString());
      yield* grammaticalNoteCounter;
    }
  }
}
