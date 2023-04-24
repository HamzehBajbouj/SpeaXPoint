import 'package:speaxpoint/models/annoucement/announcement.dart';

class ChapterMeetingAnnouncement extends Announcement {
  String? meetingStreamLink;
  String? meetingDescription;
  String? meetingTtile;
  String? meetingDate;
  String? contactNumber;
  String? brushureFileName;
  String? brushureLink;

  ChapterMeetingAnnouncement(
      {this.contactNumber,
      this.meetingDate,
      this.meetingDescription,
      this.meetingStreamLink,
      this.meetingTtile,
      this.brushureFileName,
      this.brushureLink,
      required super.annoucementDate,
      required super.annoucementStatus,
      required super.annoucementType});

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
        );

  Map<String, dynamic> toJson() => {
        'annoucementDate': super.annoucementDate,
        'annoucementStatus': super.annoucementStatus,
        'annoucementType': super.annoucementType,
        'meetingDate': meetingDate,
        'meetingDescription': meetingDescription,
        'meetingStreamLink': meetingStreamLink,
        'meetingTtile': meetingTtile,
        'contactNumber': contactNumber,
        'brushureLink': brushureLink,
        'brushureFileName': brushureFileName,
      };
}
