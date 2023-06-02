class EvaluationNote {
  String? noteTitle;
  String? noteId;
  String? noteContent;
  String? noteTakenTime;

  EvaluationNote({
    this.noteContent,
    this.noteId,
    this.noteTitle,
    this.noteTakenTime,
  });

  EvaluationNote.fromJson(Map<String, dynamic> evluationNoteJson)
      : this(
            noteContent: evluationNoteJson['noteContent'],
            noteId: evluationNoteJson['noteId'],
            noteTitle: evluationNoteJson['noteTitle'],
            noteTakenTime: evluationNoteJson['noteTakenTime']);

  Map<String, dynamic> toJson() => {
        'noteContent': noteContent,
        'noteId': noteId,
        'noteTitle': noteTitle,
        'noteTakenTime': noteTakenTime,
      };
}
