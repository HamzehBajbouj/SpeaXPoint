import 'package:basic_utils/basic_utils.dart';
import 'package:speaxpoint/models/annoucement/announcement.dart';

class ChapterMeetingAnnouncement extends Announcement {
  String? meetingStreamLink;
  String? meetingDescription;
  String? meetingTitle;
  String? meetingDate;
  String? contactNumber;
  String? brushureFileName;
  String? brushureLink;

  ChapterMeetingAnnouncement({
    this.contactNumber,
    this.meetingDate,
    this.meetingDescription,
    this.meetingStreamLink,
    this.meetingTitle,
    this.brushureFileName,
    this.brushureLink,
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
          meetingDescription: cmAnnoucement['meetingDescription'],
          meetingStreamLink: cmAnnoucement['meetingStreamLink'],
          meetingTitle: cmAnnoucement['meetingTitle'],
          contactNumber: cmAnnoucement['contactNumber'],
          brushureFileName: cmAnnoucement['brushureFileName'],
          brushureLink: cmAnnoucement['brushureLink'],
          chapterMeetingId: cmAnnoucement['chapterMeetingId'],
          clubId: cmAnnoucement['clubId'],
          annoucementLevel: cmAnnoucement['annoucementLevel'],
        );

  Map<String, dynamic> toJson() => {
        'annoucementDate': super.annoucementDate,
        'annoucementType': super.annoucementType,
        'chapterMeetingId': super.chapterMeetingId,
        'clubId': super.clubId,
        'meetingDate': meetingDate,
        'meetingDescription': meetingDescription,
        'meetingStreamLink': meetingStreamLink,
        'meetingTitle': meetingTitle,
        'contactNumber': contactNumber,
        'brushureLink': brushureLink,
        'brushureFileName': brushureFileName,
        'annoucementLevel': annoucementLevel,
      };
}
