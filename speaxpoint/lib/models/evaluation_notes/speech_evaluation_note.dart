import 'evaluation_note.dart';

class SpeechEvaluationNote extends EvaluationNote {
  String? takenByToastmasterId;
  String? takenByGuestInvitationCode;
  SpeechEvaluationNote(
      {this.takenByToastmasterId,
      this.takenByGuestInvitationCode,
      super.noteContent,
      super.noteId,
      super.noteTakenTime,
      super.noteTitle});

  SpeechEvaluationNote.fromJson(Map<String, dynamic> speechEvluationNoteJson)
      : this(
          noteContent: speechEvluationNoteJson['noteContent'],
          noteId: speechEvluationNoteJson['noteId'],
          noteTitle: speechEvluationNoteJson['noteTitle'],
          noteTakenTime: speechEvluationNoteJson['noteTakenTime'],
          takenByToastmasterId: speechEvluationNoteJson['takenByToastmasterId'],
          takenByGuestInvitationCode:
              speechEvluationNoteJson['takenByGuestInvitationCode'],
        );

  @override
  Map<String, dynamic> toJson() => {
        'noteContent': super.noteContent,
        'noteId': super.noteId,
        'noteTitle': super.noteTitle,
        'noteTakenTime': super.noteTakenTime,
        'takenByToastmasterId': takenByToastmasterId,
        'takenByGuestInvitationCode': takenByGuestInvitationCode,
      };
}
