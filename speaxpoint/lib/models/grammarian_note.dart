/*
  This model is used for the collected grammaical notes data of the speakers during the session 
  by the Grammarian role players
*/
class GrammarianNote {
  String? noteId;
  String? noteTitle;
  String? noteContent;
  String? noteCapturedTime;
  String? typeOfGrammarianNote;

  GrammarianNote({
    this.noteId,
    this.noteTitle,
    this.noteCapturedTime,
    this.noteContent,
    this.typeOfGrammarianNote,
  });

  GrammarianNote.fromJson(Map<String, dynamic> grammarianNoteJson)
      : this(
            noteId: grammarianNoteJson['noteId'],
            noteTitle: grammarianNoteJson['noteTitle'],
            noteCapturedTime: grammarianNoteJson['noteCapturedTime'],
            noteContent: grammarianNoteJson['noteContent'],
            typeOfGrammarianNote: grammarianNoteJson['typeOfGrammarianNote']);

  Map<String, dynamic> toJson() => {
        'noteId': noteId,
        'noteTitle': noteTitle,
        'noteContent': noteContent,
        'noteCapturedTime': noteCapturedTime,
        'typeOfGrammarianNote': typeOfGrammarianNote,
      };
}
