import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';
import 'package:speaxpoint/models/evaluation_notes/temp_evaluation_note.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/live_session/speech_evaluation/i_speech_evaluation_service.dart';

class SpeechEvaluationFirebaseService extends ISpeechEvaluationService {

  // final CollectionReference _onlineSessionCapturedDataC =
  //     FirebaseFirestore.instance.collection('OnlineSessionCapturedData');

  final CollectionReference _tempSpeechEvaluationDataStorageC =
      FirebaseFirestore.instance.collection('TempSpeechEvaluationDataStorage');

  @override
  Future<Result<Unit, Failure>> addSpeechEvaluationNote(
      {required TempSpeechEvaluationNote evaluationNote}) async {
    try {
      await _tempSpeechEvaluationDataStorageC.add(evaluationNote.toJson());

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
  Future<Result<Unit, Failure>> deleteSpeechEvaluationNoteAppUser(
      {required String chapterMeetingId,
      required String takenByToastmasterId,
      required String noteId}) async {
    try {
      QuerySnapshot onlineSessionCapturedDataQS =
          await _tempSpeechEvaluationDataStorageC
              .where("chapterMeetingId", isEqualTo: chapterMeetingId)
              .where("takenByToastmasterId", isEqualTo: takenByToastmasterId)
              .where("noteId", isEqualTo: noteId)
              .get();
      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        await onlineSessionCapturedDataQS.docs.first.reference.delete();
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
  Future<Result<Unit, Failure>> deleteSpeechEvaluationNoteGuestUser(
      {required String takenByGuestInvitationCode,
      required String chapterMeetingInvitationCode,
      required String noteId}) async {
    try {
      QuerySnapshot onlineSessionCapturedDataQS =
          await _tempSpeechEvaluationDataStorageC
              .where("chapterMeetingInvitationCode",
                  isEqualTo: chapterMeetingInvitationCode)
              .where("takenByGuestInvitationCode",
                  isEqualTo: takenByGuestInvitationCode)
              .where("noteId", isEqualTo: noteId)
              .get();
      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        await onlineSessionCapturedDataQS.docs.first.reference.delete();
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

//there is no any user for this method
  @override
  Stream<List<TempSpeechEvaluationNote>>
      getSpeechEvaluationNotesForSpecificSpeakerAppUser(
          {required String chapterMeetingId,
          required String takenByToastmasterId,
          required OnlineSessionCapturedData selectedSpeaker}) async* {
    Stream<List<TempSpeechEvaluationNote>> speecheEvaluationNotesData =
        Stream.empty();
    QuerySnapshot evaluationNotesQS;
    try {
      if (selectedSpeaker.isAnAppGuest!) {
        evaluationNotesQS = await _tempSpeechEvaluationDataStorageC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("takenByToastmasterId", isEqualTo: takenByToastmasterId)
            .where("evaluatedSpeakerGuestInvitationCode",
                isEqualTo: selectedSpeaker.guestInvitationCode)
            .get();
      } else {
        evaluationNotesQS = await _tempSpeechEvaluationDataStorageC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("takenByToastmasterId", isEqualTo: takenByToastmasterId)
            .where("evaluatedSpeakerToastmasteId",
                isEqualTo: selectedSpeaker.toastmasterId)
            .get();
      }

      speecheEvaluationNotesData = evaluationNotesQS.docs.first.reference
          .collection("EvaluationNotes")
          .snapshots()
          .map(
            (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
              (e) {
                return TempSpeechEvaluationNote.fromJson(
                  e.data() as Map<String, dynamic>,
                );
              },
            ).toList(),
          );

      yield* speecheEvaluationNotesData;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* speecheEvaluationNotesData;
    } catch (e) {
      log(e.toString());
      yield* speecheEvaluationNotesData;
    }
  }

  @override
  Stream<List<TempSpeechEvaluationNote>> getSpeechEvaluationNotesGuestUser(
      {required String chapterMeetingInvitationCode,
      required String takenByGuestInvitationCode,
      required OnlineSessionCapturedData selectedSpeaker}) async* {
    Stream<List<TempSpeechEvaluationNote>> speecheEvaluationNotesData =
        Stream.empty();
    QuerySnapshot evaluationNotesQS;
    try {
      if (selectedSpeaker.isAnAppGuest!) {
        evaluationNotesQS = await _tempSpeechEvaluationDataStorageC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("takenByGuestInvitationCode",
                isEqualTo: takenByGuestInvitationCode)
            .where("evaluatedSpeakerGuestInvitationCode",
                isEqualTo: selectedSpeaker.guestInvitationCode)
            .get();
      } else {
        evaluationNotesQS = await _tempSpeechEvaluationDataStorageC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("takenByGuestInvitationCode",
                isEqualTo: takenByGuestInvitationCode)
            .where("evaluatedSpeakerToastmasteId",
                isEqualTo: selectedSpeaker.toastmasterId)
            .get();
      }

      speecheEvaluationNotesData = evaluationNotesQS.docs.first.reference
          .collection("EvaluationNotes")
          .snapshots()
          .map(
            (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
              (e) {
                return TempSpeechEvaluationNote.fromJson(
                  e.data() as Map<String, dynamic>,
                );
              },
            ).toList(),
          );

      yield* speecheEvaluationNotesData;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* speecheEvaluationNotesData;
    } catch (e) {
      log(e.toString());
      yield* speecheEvaluationNotesData;
    }
  }

  @override
  Stream<List<TempSpeechEvaluationNote>> getTakenSpeechNotesByAppGuest(
      {required String chapterMeetingInvitationCode,
      required String takenByGuestInvitationCode,
      required bool evaluatedSpeakerIsAppGuest,
      required String? evaluatedSpeakerToastmasteId,
      required String? evaluatedSpeakerGuestInvitationCode}) async* {
    Stream<List<TempSpeechEvaluationNote>> evaluationNotes = Stream.empty();
    try {
      if (evaluatedSpeakerIsAppGuest) {
        evaluationNotes = _tempSpeechEvaluationDataStorageC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("takenByGuestInvitationCode",
                isEqualTo: takenByGuestInvitationCode)
            .where("evaluatedSpeakerGuestInvitationCode",
                isEqualTo: evaluatedSpeakerGuestInvitationCode)
            .snapshots()
            .map(
              (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
                (e) {
                  return TempSpeechEvaluationNote.fromJson(
                    e.data() as Map<String, dynamic>,
                  );
                },
              ).toList(),
            );
      } else {
        evaluationNotes = _tempSpeechEvaluationDataStorageC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("takenByGuestInvitationCode",
                isEqualTo: takenByGuestInvitationCode)
            .where("evaluatedSpeakerToastmasteId",
                isEqualTo: evaluatedSpeakerToastmasteId)
            .snapshots()
            .map(
              (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
                (e) {
                  return TempSpeechEvaluationNote.fromJson(
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
  Stream<List<TempSpeechEvaluationNote>> getTakenSpeechNotesByAppUser(
      {required String chapterMeetingId,
      required String takenByToastmasterId,
      required bool evaluatedSpeakerIsAppGuest,
      required String? evaluatedSpeakerToastmasteId,
      required String? evaluatedSpeakerGuestInvitationCode}) async* {
    Stream<List<TempSpeechEvaluationNote>> evaluationNotes = Stream.empty();
    try {
      if (evaluatedSpeakerIsAppGuest) {
        evaluationNotes = _tempSpeechEvaluationDataStorageC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("takenByToastmasterId", isEqualTo: takenByToastmasterId)
            .where("evaluatedSpeakerGuestInvitationCode",
                isEqualTo: evaluatedSpeakerGuestInvitationCode)
            .snapshots()
            .map(
              (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
                (e) {
                  return TempSpeechEvaluationNote.fromJson(
                    e.data() as Map<String, dynamic>,
                  );
                },
              ).toList(),
            );
      } else {
        evaluationNotes = _tempSpeechEvaluationDataStorageC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("takenByToastmasterId", isEqualTo: takenByToastmasterId)
            .where("evaluatedSpeakerToastmasteId",
                isEqualTo: evaluatedSpeakerToastmasteId)
            .snapshots()
            .map(
              (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
                (e) {
                  return TempSpeechEvaluationNote.fromJson(
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
