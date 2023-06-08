import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/models/evaluation_notes/speech_evaluation_note.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/live_session/speech_evaluation/i_speech_evaluation_service.dart';

class SpeechEvaluationFirebaseService extends ISpeechEvaluationService {
  final CollectionReference _onlineSessionCapturedDataC =
      FirebaseFirestore.instance.collection('OnlineSessionCapturedData');

  final CollectionReference _tempSpeechEvaluationDataStorageC =
      FirebaseFirestore.instance.collection('TempSpeechEvaluationDataStorage');

  @override
  Future<Result<Unit, Failure>> addSpeechEvaluationNote({
    required bool evaluatedSpeakerIsGuest,
    String? evaluatedSpeakerToastmasterId,
    String? evaluatedSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
    required SpeechEvaluationNote evaluationNote,
  }) async {
    try {
      QuerySnapshot onlineSessionCapturedDataQS;
      if (evaluatedSpeakerIsGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode",
                isEqualTo: evaluatedSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: evaluatedSpeakerToastmasterId)
            .get();
      }

      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference speechEvaluationNotesC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("SpeechEvaluationNotes");
        await speechEvaluationNotesC.add(evaluationNote.toJson());
      } else {
        return const Error(
          Failure(
              code: "No-Speaker-Found",
              location:
                  "SpeechEvaluationFirebaseService.addSpeechEvaluationNoteAppUser()",
              message: "Could not found a speaker speech record"),
        );
      }

      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "SpeechEvaluationFirebaseService.addSpeechEvaluationNoteAppUser()",
            message: e.message ??
                "Database Error While adding a speech evaluation note"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "SpeechEvaluationFirebaseService.addSpeechEvaluationNoteAppUser()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> deleteSpeechEvaluationNoteAppUser({
    required String chapterMeetingId,
    required String takenByToastmasterId,
    required String noteId,
    required bool evaluatedSpeakerIsGuest,
    String? evaluatedSpeakerToastmasterId,
    String? evaluatedSpeakerGuestInvitationCode,
  }) async {
    try {
      QuerySnapshot onlineSessionCapturedDataQS;
      onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .where("guestInvitationCode",
              isEqualTo: evaluatedSpeakerGuestInvitationCode)
          .get();
      if (evaluatedSpeakerIsGuest) {
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: evaluatedSpeakerToastmasterId)
            .get();
      }

      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference speechEvaluationNotesC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("SpeechEvaluationNotes");
        QuerySnapshot speechEvaluationNotesQS = await speechEvaluationNotesC
            .where("takenByToastmasterId", isEqualTo: takenByToastmasterId)
            .where("noteId", isEqualTo: noteId)
            .get();
        if (speechEvaluationNotesQS.docs.isNotEmpty) {
          await speechEvaluationNotesQS.docs.first.reference.delete();
        }
      } else {
        return Error(
          Failure(
            code: "No-Evaluation-Note-Found",
            location:
                "SpeechEvaluationFirebaseService.deleteSpeechEvaluationNoteAppUser()",
            message:
                "Could not found a evaluation note for chapter meeting with"
                "id : $chapterMeetingId , that is taken by toastmaster id : $takenByToastmasterId",
          ),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "SpeechEvaluationFirebaseService.deleteSpeechEvaluationNoteAppUser()",
            message: e.message ??
                "Database Error While delete a speech evaluation note"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "SpeechEvaluationFirebaseService.deleteSpeechEvaluationNoteAppUser()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> deleteSpeechEvaluationNoteGuestUser({
    required String takenByGuestInvitationCode,
    required String chapterMeetingInvitationCode,
    required String noteId,
    required bool evaluatedSpeakerIsGuest,
    String? evaluatedSpeakerToastmasterId,
    String? evaluatedSpeakerGuestInvitationCode,
  }) async {
    try {
      QuerySnapshot onlineSessionCapturedDataQS;

      if (evaluatedSpeakerIsGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode",
                isEqualTo: evaluatedSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("toastmasterId", isEqualTo: evaluatedSpeakerToastmasterId)
            .get();
      }

      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference speechEvaluationNotesC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("SpeechEvaluationNotes");
        QuerySnapshot speechEvaluationNotesQS = await speechEvaluationNotesC
            .where("takenByGuestInvitationCode",
                isEqualTo: takenByGuestInvitationCode)
            .where("noteId", isEqualTo: noteId)
            .get();
        if (speechEvaluationNotesQS.docs.isNotEmpty) {
          await speechEvaluationNotesQS.docs.first.reference.delete();
        }
      } else {
        return Error(
          Failure(
            code: "No-Evaluation-Note-Found",
            location:
                "SpeechEvaluationFirebaseService.deleteSpeechEvaluationNoteGuestUser()",
            message:
                "Could not found a evaluation note for chapter meeting with"
                "chapter invitation code : $chapterMeetingInvitationCode , "
                "that is taken by guest with invitiation code : $takenByGuestInvitationCode",
          ),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "SpeechEvaluationFirebaseService.deleteSpeechEvaluationNoteGuestUser()",
            message: e.message ??
                "Database Error While delete a speech evaluation note"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "SpeechEvaluationFirebaseService.deleteSpeechEvaluationNoteGuestUser()",
            message: e.toString()),
      );
    }
  }

//there is no any usages for this method
  // @override
  // Stream<List<TempSpeechEvaluationNote>>
  //     getSpeechEvaluationNotesForSpecificSpeakerAppUser({
  //   required String chapterMeetingId,
  //   required String takenByToastmasterId,
  //   required OnlineSessionCapturedData selectedSpeaker,
  //   required bool evaluatedSpeakerIsGuest,
  //   String? evaluatedSpeakerToastmasterId,
  //   String? evaluatedSpeakerGuestInvitationCode,
  // }) async* {
  //   Stream<List<TempSpeechEvaluationNote>> speecheEvaluationNotesData =
  //       Stream.empty();
  //   QuerySnapshot evaluationNotesQS;
  //   try {
  //     if (selectedSpeaker.isAnAppGuest!) {
  //       evaluationNotesQS = await _tempSpeechEvaluationDataStorageC
  //           .where("chapterMeetingId", isEqualTo: chapterMeetingId)
  //           .where("takenByToastmasterId", isEqualTo: takenByToastmasterId)
  //           .where("evaluatedSpeakerGuestInvitationCode",
  //               isEqualTo: selectedSpeaker.guestInvitationCode)
  //           .get();
  //     } else {
  //       evaluationNotesQS = await _tempSpeechEvaluationDataStorageC
  //           .where("chapterMeetingId", isEqualTo: chapterMeetingId)
  //           .where("takenByToastmasterId", isEqualTo: takenByToastmasterId)
  //           .where("evaluatedSpeakerToastmasteId",
  //               isEqualTo: selectedSpeaker.toastmasterId)
  //           .get();
  //     }

  //     speecheEvaluationNotesData = evaluationNotesQS.docs.first.reference
  //         .collection("EvaluationNotes")
  //         .snapshots()
  //         .map(
  //           (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
  //             (e) {
  //               return TempSpeechEvaluationNote.fromJson(
  //                 e.data() as Map<String, dynamic>,
  //               );
  //             },
  //           ).toList(),
  //         );

  //     yield* speecheEvaluationNotesData;
  //   } on FirebaseException catch (e) {
  //     log("${e.code} ${e.message}");
  //     yield* speecheEvaluationNotesData;
  //   } catch (e) {
  //     log(e.toString());
  //     yield* speecheEvaluationNotesData;
  //   }
  // }

  // @override
  // Stream<List<TempSpeechEvaluationNote>> getSpeechEvaluationNotesGuestUser({
  //   required String chapterMeetingInvitationCode,
  //   required String takenByGuestInvitationCode,
  //   required OnlineSessionCapturedData selectedSpeaker,
  //   required bool evaluatedSpeakerIsGuest,
  //   String? evaluatedSpeakerToastmasterId,
  //   String? evaluatedSpeakerGuestInvitationCode,
  // }) async* {
  //   Stream<List<TempSpeechEvaluationNote>> speecheEvaluationNotesData =
  //       Stream.empty();
  //   QuerySnapshot evaluationNotesQS;
  //   try {
  //     if (selectedSpeaker.isAnAppGuest!) {
  //       evaluationNotesQS = await _tempSpeechEvaluationDataStorageC
  //           .where("chapterMeetingInvitationCode",
  //               isEqualTo: chapterMeetingInvitationCode)
  //           .where("takenByGuestInvitationCode",
  //               isEqualTo: takenByGuestInvitationCode)
  //           .where("evaluatedSpeakerGuestInvitationCode",
  //               isEqualTo: selectedSpeaker.guestInvitationCode)
  //           .get();
  //     } else {
  //       evaluationNotesQS = await _tempSpeechEvaluationDataStorageC
  //           .where("chapterMeetingInvitationCode",
  //               isEqualTo: chapterMeetingInvitationCode)
  //           .where("takenByGuestInvitationCode",
  //               isEqualTo: takenByGuestInvitationCode)
  //           .where("evaluatedSpeakerToastmasteId",
  //               isEqualTo: selectedSpeaker.toastmasterId)
  //           .get();
  //     }

  //     speecheEvaluationNotesData = evaluationNotesQS.docs.first.reference
  //         .collection("EvaluationNotes")
  //         .snapshots()
  //         .map(
  //           (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
  //             (e) {
  //               return TempSpeechEvaluationNote.fromJson(
  //                 e.data() as Map<String, dynamic>,
  //               );
  //             },
  //           ).toList(),
  //         );

  //     yield* speecheEvaluationNotesData;
  //   } on FirebaseException catch (e) {
  //     log("${e.code} ${e.message}");
  //     yield* speecheEvaluationNotesData;
  //   } catch (e) {
  //     log(e.toString());
  //     yield* speecheEvaluationNotesData;
  //   }
  // }

  @override
  Stream<List<SpeechEvaluationNote>> getTakenSpeechNotesByAppGuest(
      {required String chapterMeetingInvitationCode,
      required String takenByGuestInvitationCode,
      required bool evaluatedSpeakerIsAppGuest,
      required String? evaluatedSpeakerToastmasteId,
      required String? evaluatedSpeakerGuestInvitationCode}) async* {
    Stream<List<SpeechEvaluationNote>> evaluationNotes = Stream.empty();
    try {
      QuerySnapshot onlineSessionCapturedDataQS;
      if (evaluatedSpeakerIsAppGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode",
                isEqualTo: evaluatedSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("toastmasterId", isEqualTo: evaluatedSpeakerToastmasteId)
            .get();
      }

      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference speechEvaluationNotesC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("SpeechEvaluationNotes");
        evaluationNotes = speechEvaluationNotesC
            .where("takenByGuestInvitationCode",
                isEqualTo: takenByGuestInvitationCode)
            .snapshots()
            .map(
              (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
                (e) {
                  return SpeechEvaluationNote.fromJson(
                    e.data() as Map<String, dynamic>,
                  );
                },
              ).toList(),
            );
      }

      yield* evaluationNotes;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* evaluationNotes;
    } catch (e) {
      log(e.toString());
      yield* evaluationNotes;
    }
  }

  @override
  Stream<List<SpeechEvaluationNote>> getTakenSpeechNotesByAppUser(
      {required String chapterMeetingId,
      required String takenByToastmasterId,
      required bool evaluatedSpeakerIsAppGuest,
      required String? evaluatedSpeakerToastmasteId,
      required String? evaluatedSpeakerGuestInvitationCode}) async* {
    Stream<List<SpeechEvaluationNote>> evaluationNotes = Stream.empty();
    try {
      QuerySnapshot onlineSessionCapturedDataQS;
      if (evaluatedSpeakerIsAppGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("guestInvitationCode",
                isEqualTo: evaluatedSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: evaluatedSpeakerToastmasteId)
            .get();
      }

      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference speechEvaluationNotesC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("SpeechEvaluationNotes");
        evaluationNotes = speechEvaluationNotesC
            .where("takenByToastmasterId", isEqualTo: takenByToastmasterId)
            .snapshots()
            .map(
              (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
                (e) {
                  return SpeechEvaluationNote.fromJson(
                    e.data() as Map<String, dynamic>,
                  );
                },
              ).toList(),
            );
      }

      yield* evaluationNotes;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* evaluationNotes;
    } catch (e) {
      log(e.toString());
      yield* evaluationNotes;
    }
  }
}
