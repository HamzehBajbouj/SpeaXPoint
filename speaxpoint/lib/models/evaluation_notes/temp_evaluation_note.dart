import 'package:speaxpoint/models/evaluation_notes/speech_evaluation_note.dart';

class TempSpeechEvaluationNote extends SpeechEvaluationNote {
  String? chapterMeetingId;
  String? chapterMeetingInvitationCode;
  String? evaluatedSpeakerToastmasteId;
  String? evaluatedSpeakerGuestInvitationCode;
  TempSpeechEvaluationNote(
      {this.chapterMeetingId,
      this.chapterMeetingInvitationCode,
      this.evaluatedSpeakerToastmasteId,
      this.evaluatedSpeakerGuestInvitationCode,
      super.takenByToastmasterId,
      super.takenByGuestInvitationCode,
      super.noteContent,
      super.noteId,
      super.noteTakenTime,
      super.noteTitle});

  TempSpeechEvaluationNote.fromJson(
      Map<String, dynamic> tempSpeechEvluationNoteJson)
      : this(
          noteContent: tempSpeechEvluationNoteJson['noteContent'],
          noteId: tempSpeechEvluationNoteJson['noteId'],
          noteTitle: tempSpeechEvluationNoteJson['noteTitle'],
          noteTakenTime: tempSpeechEvluationNoteJson['noteTakenTime'],
          takenByToastmasterId:
              tempSpeechEvluationNoteJson['takenByToastmasterId'],
          takenByGuestInvitationCode:
              tempSpeechEvluationNoteJson['takenByGuestInvitationCode'],
          chapterMeetingId: tempSpeechEvluationNoteJson['chapterMeetingId'],
          chapterMeetingInvitationCode:
              tempSpeechEvluationNoteJson['chapterMeetingInvitationCode'],
          evaluatedSpeakerToastmasteId:
              tempSpeechEvluationNoteJson['evaluatedSpeakerToastmasteId'],
          evaluatedSpeakerGuestInvitationCode: tempSpeechEvluationNoteJson[
              'evaluatedSpeakerGuestInvitationCode'],
        );

  @override
  Map<String, dynamic> toJson() => {
        'noteContent': super.noteContent,
        'noteId': super.noteId,
        'noteTitle': super.noteTitle,
        'noteTakenTime': super.noteTakenTime,
        'takenByToastmasterId': super.takenByToastmasterId,
        'takenByGuestInvitationCode': super.takenByGuestInvitationCode,
        'chapterMeetingId': chapterMeetingId,
        'chapterMeetingInvitationCode': chapterMeetingInvitationCode,
        'evaluatedSpeakerToastmasteId': evaluatedSpeakerToastmasteId,
        'evaluatedSpeakerGuestInvitationCode':
            evaluatedSpeakerGuestInvitationCode,
      };
}
