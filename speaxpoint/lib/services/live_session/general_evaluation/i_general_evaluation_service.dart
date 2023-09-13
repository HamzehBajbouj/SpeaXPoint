import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/evaluation_notes/evaluation_note.dart';
import 'package:speaxpoint/services/failure.dart';

abstract class IGeneralEvaluationService {
   Future<Result<Unit, Failure>> addGeneralEvaluationNoteAppUser({
    required String chapterMeetingId,
    required String toastmasterId,
    required EvaluationNote evaluationNote,
  });

  Future<Result<Unit, Failure>> deleteGeneralEvaluationNoteAppUser({
    required String chapterMeetingId,
    required String toastmasterId,
    required String noteId,
  });

  Stream<List<EvaluationNote>> getGeneralEvaluationNoteAppUser({
    required String chapterMeetingId,
    required String toastmasterId,
  });

  Future<Result<Unit, Failure>> addGeneralEvaluationNoteGuestUser({
    required String guestInvitationCode,
    required String chapterMeetingInvitationCode,
    required EvaluationNote evaluationNote,
  });
  Future<Result<Unit, Failure>> deleteGeneralEvaluationNoteGuestUser({
    required String guestInvitationCode,
    required String chapterMeetingInvitationCode,
    required String noteId,
  });

  Stream<List<EvaluationNote>> getGeneralEvaluationNoteGuestUser({
    required String guestInvitationCode,
    required String chapterMeetingInvitationCode,
  });
}
