/*
  This class refers for the coming sessions , it's the main modal for coming sessions
  but the naming is different.
  the toastmaster id refers to the vice president id, who created this session
*/
class ChapterMeeting {
  String? toastmasterId;
  String? clubId;
  String? chapterTitle;
  String? dateOfMeeting;
  String? invitationCode;
  ChapterMeeting({
    this.clubId,
    this.toastmasterId,
    this.chapterTitle,
    this.dateOfMeeting,
    this.invitationCode,
  });

  ChapterMeeting.fromJson(Map<String, dynamic> json)
      : this(
          toastmasterId: json['toastmasterId'],
          clubId: json['clubId'],
          chapterTitle: json['chapterTitle'],
          dateOfMeeting: json['dateOfMeeting'],
          invitationCode: json['invitationCode'],
        );

  Map<String, dynamic> toJson() => {
        'toastmasterId': toastmasterId,
        'clubId': clubId,
        'chapterTitle': chapterTitle,
        'dateOfMeeting': dateOfMeeting,
        'invitationCode': invitationCode,
      };
}