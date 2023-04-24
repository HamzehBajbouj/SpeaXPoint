import 'package:basic_utils/basic_utils.dart';
import 'package:speaxpoint/models/annoucement/announcement.dart';

class VolunteerAnnouncement extends Announcement {
  String? annoucementTitle;
  String? annoucementDescription;

  VolunteerAnnouncement(
      {this.annoucementDescription,
      this.annoucementTitle,
      required super.annoucementDate,
      required super.annoucementStatus,
      super.annoucementType,
      required super.chapterMeetingId,
      required super.clubId});

  VolunteerAnnouncement.fromJson(Map<String, dynamic> volunteerAnnoucementJson)
      : this(
          annoucementDate: volunteerAnnoucementJson['annoucementDate'],
          annoucementDescription:
              volunteerAnnoucementJson['annoucementDescription'],
          annoucementStatus: volunteerAnnoucementJson['annoucementStatus'],
          annoucementTitle: volunteerAnnoucementJson['annoucementTitle'],
          annoucementType: volunteerAnnoucementJson['annoucementType'],
          chapterMeetingId: volunteerAnnoucementJson['chapterMeetingId'],
          clubId: volunteerAnnoucementJson['clubId'],
        );

  Map<String, dynamic> toJson() => {
        'annoucementDescription': annoucementDescription,
        'annoucementTitle': annoucementTitle,
        'annoucementDate': super.annoucementDate,
        'annoucementStatus': super.annoucementStatus,
        'annoucementType': super.annoucementType,
        'chapterMeetingId': super.chapterMeetingId,
        'clubId': super.clubId,
      };
}
