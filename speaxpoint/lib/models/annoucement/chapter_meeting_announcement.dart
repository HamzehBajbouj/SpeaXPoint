import 'package:speaxpoint/models/annoucement/announcement.dart';

class ChapterMeetingAnnouncement extends Announcement {
  String? meetingStreamLink;
  // String? meetingDescription;
  // String? meetingTitle;
  String? meetingDate;
  String? contactNumber;
  String? brushureLink;

  ChapterMeetingAnnouncement({
    this.contactNumber,
    this.meetingDate,
    this.meetingStreamLink,
    this.brushureLink,
    super.annoucementDescription,
    super.annoucementTitle,
    super.annoucementLevel,
    super.annoucementDate,
    super.annoucementType,
    super.chapterMeetingId,
    super.clubId,
  });

  ChapterMeetingAnnouncement.fromJson(Map<String, dynamic> cmAnnoucement)
      : this(
          annoucementDate: cmAnnoucement['annoucementDate'],
          annoucementType: cmAnnoucement['annoucementType'],
          meetingDate: cmAnnoucement['meetingDate'],
          annoucementDescription: cmAnnoucement['annoucementDescription'],
          meetingStreamLink: cmAnnoucement['meetingStreamLink'],
          annoucementTitle: cmAnnoucement['annoucementTitle'],
          contactNumber: cmAnnoucement['contactNumber'],
          brushureLink: cmAnnoucement['brushureLink'],
          chapterMeetingId: cmAnnoucement['chapterMeetingId'],
          clubId: cmAnnoucement['clubId'],
          annoucementLevel: cmAnnoucement['annoucementLevel'],
        );

  @override
  Map<String, dynamic> toJson() => {
        'annoucementDate': super.annoucementDate,
        'annoucementType': super.annoucementType,
        'chapterMeetingId': super.chapterMeetingId,
        'annoucementTitle': super.annoucementTitle,
        'annoucementDescription': super.annoucementDescription,
        'clubId': super.clubId,
        'meetingDate': meetingDate,
        'meetingStreamLink': meetingStreamLink,
        'contactNumber': contactNumber,
        'brushureLink': brushureLink,
        'annoucementLevel': annoucementLevel,
      };
}
