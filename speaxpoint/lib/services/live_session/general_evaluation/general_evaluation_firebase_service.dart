import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/models/evaluation_notes/evaluation_note.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/live_session/general_evaluation/i_general_evaluation_service.dart';

class GeneralEvaluationFirebaseService extends IGeneralEvaluationService {
  final CollectionReference _chapterMeetingGeneralEvaluationNotesC =
      FirebaseFirestore.instance
          .collection('ChapterMeetingGeneralEvaluationNotes');
  @override
  Future<Result<Unit, Failure>> addGeneralEvaluationNoteAppUser(
      {required String chapterMeetingId,
      required String toastmasterId,
      required EvaluationNote evaluationNote}) async {
    try {
      QuerySnapshot generalEvaluationNotesQS =
          await _chapterMeetingGeneralEvaluationNotesC
              .where("chapterMeetingId", isEqualTo: chapterMeetingId)
              .where("toastmasterId", isEqualTo: toastmasterId)
              .get();
      if (generalEvaluationNotesQS.docs.isNotEmpty) {
        CollectionReference evaluationNotes = generalEvaluationNotesQS
            .docs.first.reference
            .collection("EvaluationNotes");
        await evaluationNotes.add(evaluationNote.toJson());
      } else {
        return Error(
          Failure(
            code: "No-Evaluation-Note-Found",
            location:
                "GeneralEvaluationFirebaseService.addGeneralEvaluationNoteAppUser()",
            message:
                "Could not found a evaluation notes for chapter meeting with id "
                ": $chapterMeetingId , for toastmaster id : $toastmasterId",
          ),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "GeneralEvaluationFirebaseService.addGeneralEvaluationNoteAppUser()",
            message: e.message ??
                "Database Error While adding a general evaluation note"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "GeneralEvaluationFirebaseService.addGeneralEvaluationNoteAppUser()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> addGeneralEvaluationNoteGuestUser(
      {required String guestInvitationCode,
      required String chapterMeetingInvitationCode,
      required EvaluationNote evaluationNote}) async {
    try {
      QuerySnapshot generalEvaluationNotesQS =
          await _chapterMeetingGeneralEvaluationNotesC
              .where("guestInvitationCode", isEqualTo: guestInvitationCode)
              .where("chapterMeetingInvitationCode",
                  isEqualTo: chapterMeetingInvitationCode)
              .get();
      if (generalEvaluationNotesQS.docs.isNotEmpty) {
        CollectionReference evaluationNotes = generalEvaluationNotesQS
            .docs.first.reference
            .collection("EvaluationNotes");
        await evaluationNotes.add(evaluationNote.toJson());
      } else {
        return Error(
          Failure(
            code: "No-Evaluation-Note-Found",
            location:
                "GeneralEvaluationFirebaseService.addGeneralEvaluationNoteGuestUser()",
            message:
                "Could not found a evaluation notes for chapter meeting with"
                "invitation code : $chapterMeetingInvitationCode , for guest invitation code : $guestInvitationCode",
          ),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "GeneralEvaluationFirebaseService.addGeneralEvaluationNoteGuestUser()",
            message: e.message ??
                "Database Error While adding a general evaluation note"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "GeneralEvaluationFirebaseService.addGeneralEvaluationNoteGuestUser()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> deleteGeneralEvaluationNoteAppUser(
      {required String chapterMeetingId,
      required String toastmasterId,
      required String noteId}) async {
    try {
      QuerySnapshot generalEvaluationNotesQS =
          await _chapterMeetingGeneralEvaluationNotesC
              .where("chapterMeetingId", isEqualTo: chapterMeetingId)
              .where("toastmasterId", isEqualTo: toastmasterId)
              .get();
      if (generalEvaluationNotesQS.docs.isNotEmpty) {
        CollectionReference evaluationNotes = generalEvaluationNotesQS
            .docs.first.reference
            .collection("EvaluationNotes");
        QuerySnapshot evaluationNotesQS =
            await evaluationNotes.where("noteId", isEqualTo: noteId).get();
        if (evaluationNotesQS.docs.isNotEmpty) {
          await evaluationNotesQS.docs.first.reference.delete();
        } else {
          return Error(
            Failure(
                code: "No-Note-Found",
                location:
                    "GeneralEvaluationFirebaseService.deleteGeneralEvaluationNoteAppUser()",
                message: "Could not found a evaluation note with id : $noteId"),
          );
        }
      } else {
        return Error(
          Failure(
            code: "No-Evaluation-Note-Found",
            location:
                "GeneralEvaluationFirebaseService.deleteGeneralEvaluationNoteAppUser()",
            message:
                "Could not found a evaluation note for chapter meeting with"
                "id : $chapterMeetingId , for toastmaster id : $toastmasterId",
          ),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "GeneralEvaluationFirebaseService.deleteGeneralEvaluationNoteAppUser()",
            message: e.message ??
                "Database Error While delete a general evaluation note"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "GeneralEvaluationFirebaseService.deleteGeneralEvaluationNoteAppUser()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> deleteGeneralEvaluationNoteGuestUser(
      {required String guestInvitationCode,
      required String chapterMeetingInvitationCode,
      required String noteId}) async {
    try {
      QuerySnapshot generalEvaluationNotesQS =
          await _chapterMeetingGeneralEvaluationNotesC
              .where("guestInvitationCode", isEqualTo: guestInvitationCode)
              .where("chapterMeetingInvitationCode",
                  isEqualTo: chapterMeetingInvitationCode)
              .get();
      if (generalEvaluationNotesQS.docs.isNotEmpty) {
        CollectionReference evaluationNotes = generalEvaluationNotesQS
            .docs.first.reference
            .collection("EvaluationNotes");
        QuerySnapshot evaluationNotesQS =
            await evaluationNotes.where("noteId", isEqualTo: noteId).get();
        if (evaluationNotesQS.docs.isNotEmpty) {
          await evaluationNotesQS.docs.first.reference.delete();
        } else {
          return Error(
            Failure(
                code: "No-Note-Found",
                location:
                    "GeneralEvaluationFirebaseService.deleteGeneralEvaluationNoteGuestUser()",
                message: "Could not found a evaluation note with id : $noteId"),
          );
        }
      } else {
        return Error(
          Failure(
            code: "No-Evaluation-Note-Found",
            location:
                "GeneralEvaluationFirebaseService.deleteGeneralEvaluationNoteGuestUser()",
            message:
                "Could not found a evaluation note for chapter meeting with"
                "invitation code : $chapterMeetingInvitationCode , for guest invitation code : $guestInvitationCode",
          ),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "GeneralEvaluationFirebaseService.deleteGeneralEvaluationNoteGuestUser()",
            message: e.message ??
                "Database Error While delete a general evaluation note"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "GeneralEvaluationFirebaseService.deleteGeneralEvaluationNoteGuestUser()",
            message: e.toString()),
      );
    }
  }

  @override
  Stream<List<EvaluationNote>> getGeneralEvaluationNoteAppUser(
      {required String chapterMeetingId,
      required String toastmasterId}) async* {
    Stream<List<EvaluationNote>> evaluationNotesData = Stream.empty();
    try {
      QuerySnapshot evaluationNotesQS =
          await _chapterMeetingGeneralEvaluationNotesC
              .where("chapterMeetingId", isEqualTo: chapterMeetingId)
              .where("toastmasterId", isEqualTo: toastmasterId)
              .get();

      evaluationNotesData = evaluationNotesQS.docs.first.reference
          .collection("EvaluationNotes")
          .snapshots()
          .map(
            (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
              (e) {
                return EvaluationNote.fromJson(
                  e.data() as Map<String, dynamic>,
                );
              },
            ).toList(),
          );

      yield* evaluationNotesData;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* evaluationNotesData;
    } catch (e) {
      log(e.toString());
      yield* evaluationNotesData;
    }
  }

  @override
  Stream<List<EvaluationNote>> getGeneralEvaluationNoteGuestUser(
      {required String guestInvitationCode,
      required String chapterMeetingInvitationCode}) async* {
    Stream<List<EvaluationNote>> evaluationNotesData = Stream.empty();
    try {
      QuerySnapshot evaluationNotesQS =
          await _chapterMeetingGeneralEvaluationNotesC
              .where("guestInvitationCode", isEqualTo: guestInvitationCode)
              .where("chapterMeetingInvitationCode",
                  isEqualTo: chapterMeetingInvitationCode)
              .get();

      evaluationNotesData = evaluationNotesQS.docs.first.reference
          .collection("EvaluationNotes")
          .snapshots()
          .map(
            (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
              (e) {
                return EvaluationNote.fromJson(
                  e.data() as Map<String, dynamic>,
                );
              },
            ).toList(),
          );

      yield* evaluationNotesData;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* evaluationNotesData;
    } catch (e) {
      log(e.toString());
      yield* evaluationNotesData;
    }
  }
}
