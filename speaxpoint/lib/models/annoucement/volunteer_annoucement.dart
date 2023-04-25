import 'package:speaxpoint/models/annoucement/announcement.dart';

class VolunteerAnnouncement extends Announcement {
  String? annoucementTitle;
  String? annoucementDescription;

  VolunteerAnnouncement(
      {this.annoucementDescription,
      this.annoucementTitle,
      super.annoucementDate,
      super.annoucementType,
      super.annoucementLevel,
      super.chapterMeetingId,
      super.clubId});

  VolunteerAnnouncement.fromJson(Map<String, dynamic> volunteerAnnoucementJson)
      : this(
            annoucementDate: volunteerAnnoucementJson['annoucementDate'],
            annoucementDescription:
                volunteerAnnoucementJson['annoucementDescription'],
            annoucementTitle: volunteerAnnoucementJson['annoucementTitle'],
            annoucementType: volunteerAnnoucementJson['annoucementType'],
            chapterMeetingId: volunteerAnnoucementJson['chapterMeetingId'],
            clubId: volunteerAnnoucementJson['clubId'],
            annoucementLevel: volunteerAnnoucementJson['annoucementLevel']);

  Map<String, dynamic> toJson() => {
        'annoucementDescription': annoucementDescription,
        'annoucementTitle': annoucementTitle,
        'annoucementDate': super.annoucementDate,
        'annoucementType': super.annoucementType,
        'chapterMeetingId': super.chapterMeetingId,
        'clubId': super.clubId,
        'annoucementLevel': super.annoucementLevel,
      };
}
