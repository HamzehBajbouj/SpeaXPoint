import 'package:speaxpoint/models/annoucement/announcement.dart';

class VolunteerAnnouncement extends Announcement {
  String? annoucementTitle;
  String? annoucementDescription;

  VolunteerAnnouncement({
     this.annoucementDescription,
     this.annoucementTitle,
     super.annoucementDate,
     super.annoucementStatus,
     super.annoucementType,
  });

  VolunteerAnnouncement.fromJson(Map<String, dynamic> volunteerAnnoucementJson)
      : this(
            annoucementDate: volunteerAnnoucementJson['annoucementDate'],
            annoucementDescription:
                volunteerAnnoucementJson['annoucementDescription'],
            annoucementStatus: volunteerAnnoucementJson['annoucementStatus'],
            annoucementTitle: volunteerAnnoucementJson['annoucementTitle'],
            annoucementType: volunteerAnnoucementJson['annoucementType']);

  Map<String, dynamic> toJson() => {
        'annoucementDescription': annoucementDescription,
        'annoucementTitle': annoucementTitle,
        'annoucementDate': super.annoucementDate,
        'annoucementStatus': super.annoucementStatus,
        'annoucementType': super.annoucementType
      };
}
