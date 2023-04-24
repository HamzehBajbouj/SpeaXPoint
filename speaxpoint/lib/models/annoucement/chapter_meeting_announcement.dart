import 'package:basic_utils/basic_utils.dart';
import 'package:speaxpoint/models/annoucement/announcement.dart';

class ChapterMeetingAnnouncement extends Announcement {
  String? meetingStreamLink;
  String? meetingDescription;
  String? meetingTtile;
  String? meetingDate;
  String? contactNumber;
  String? brushureFileName;
  String? brushureLink;

  ChapterMeetingAnnouncement({
    this.contactNumber,
    this.meetingDate,
    this.meetingDescription,
    this.meetingStreamLink,
    this.meetingTtile,
    this.brushureFileName,
    this.brushureLink,
    required super.annoucementDate,
    required super.annoucementStatus,
    required super.annoucementType,
    required super.chapterMeetingId,
    required super.clubId,
  });

  ChapterMeetingAnnouncement.fromJson(Map<String, dynamic> cmAnnoucement)
      : this(
          annoucementDate: cmAnnoucement['annoucementDate'],
          annoucementStatus: cmAnnoucement['annoucementStatus'],
          annoucementType: cmAnnoucement['annoucementType'],
          meetingDate: cmAnnoucement['meetingDate'],
          meetingDescription: cmAnnoucement['meetingDescription'],
          meetingStreamLink: cmAnnoucement['meetingStreamLink'],
          meetingTtile: cmAnnoucement['meetingTtile'],
          contactNumber: cmAnnoucement['contactNumber'],
          brushureFileName: cmAnnoucement['brushureFileName'],
          brushureLink: cmAnnoucement['brushureLink'],
          chapterMeetingId: cmAnnoucement['chapterMeetingId'],
          clubId: cmAnnoucement['clubId'],
        );

  Map<String, dynamic> toJson() => {
        'annoucementDate': super.annoucementDate,
        'annoucementStatus': super.annoucementStatus,
        'annoucementType': super.annoucementType,
        'chapterMeetingId': super.chapterMeetingId,
        'clubId': super.clubId,
        'meetingDate': meetingDate,
        'meetingDescription': meetingDescription,
        'meetingStreamLink': meetingStreamLink,
        'meetingTtile': meetingTtile,
        'contactNumber': contactNumber,
        'brushureLink': brushureLink,
        'brushureFileName': brushureFileName,
      };
}
