class Announcement {
  String? annoucementType;
  String? annoucementDate;
  String? chapterMeetingId;
  String? clubId;
  String? annoucementLevel;
  String? annoucementTitle;
  String? annoucementDescription;
  Announcement({
    this.annoucementDate,
    this.annoucementType,
    this.chapterMeetingId,
    this.clubId,
    this.annoucementLevel,
    this.annoucementDescription,
    this.annoucementTitle,
  });

  Announcement.fromJson(Map<String, dynamic> volunteerAnnoucementJson)
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
        'annoucementDate': annoucementDate,
        'annoucementType': annoucementType,
        'chapterMeetingId': chapterMeetingId,
        'clubId': clubId,
        'annoucementLevel': annoucementLevel,
      };
}
