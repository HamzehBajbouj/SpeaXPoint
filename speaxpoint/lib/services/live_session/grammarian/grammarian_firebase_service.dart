import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/models/grammarian_note.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/live_session/grammarian/i_grammarian_service.dart';

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
        CollectionReference wotdDataC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("WOTDCapturedData");
        await wotdDataC.add(
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
        CollectionReference wotdDataC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("WOTDCapturedData");
        QuerySnapshot wotdDataQS =
            await wotdDataC.where("noteId", isEqualTo: noteId).get();

        if (wotdDataQS.docs.isNotEmpty) {
          await wotdDataQS.docs.first.reference.delete();
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
  Future<Result<List<GrammarianNote>, Failure>> getGrammaticalNotes(
      {required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async {
    List<GrammarianNote> grammarianNotes = [];
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
        CollectionReference wotdDataC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("WOTDCapturedData");
        QuerySnapshot wotdDataQS = await wotdDataC.get();

        if (wotdDataQS.docs.isNotEmpty) {
          grammarianNotes = wotdDataQS.docs
              .map((doc) =>
                  GrammarianNote.fromJson(doc.data() as Map<String, dynamic>))
              .toList();
        }
      } else {
        return const Error(
          Failure(
              code: "No-Speaker-Found",
              location: "GrammarianFirebaseService.getGrammaticalNotes()",
              message: "Could not found a speaker speech record"),
        );
      }
      return Success(grammarianNotes);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "GrammarianFirebaseService.getGrammaticalNotes()",
            message: e.message ??
                "Database Error While getting speaker grammatical notes data"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "GrammarianFirebaseService.getGrammaticalNotes()",
            message: e.toString()),
      );
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
        CollectionReference wotdDataC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("WOTDCapturedData");
        QuerySnapshot wotdDataQS = await wotdDataC.get();
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
        CollectionReference wotdDataQS = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("WOTDCapturedData");
        // Create a stream transformer to convert the QuerySnapshot to Map<String, int>
        wotdUsagesCount = wotdDataQS.snapshots().map(
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
      {
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
        CollectionReference wotdDataC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("WOTDCapturedData");
        QuerySnapshot wotdDataQS = await wotdDataC
            .orderBy('capturingTime', descending: true)
            .limit(1)
            .get();
        if (wotdDataQS.docs.isNotEmpty) {
          await wotdDataQS.docs.first.reference.delete();
        } else {
          return const Error(
            Failure(
                code: "No-WOTD-Recotd-Found",
                location: "GrammarianFirebaseService.decreaseWOTDCounter()",
                message:
                    "Could not find the latest WOTD usage captured data for type"),
          );
        }
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
      {required String capturingTime,
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
        CollectionReference wotdDataC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("WOTDCapturedData");
        await wotdDataC.add({
          'capturingTime': capturingTime,
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
}
