class SlotApplicant {
  String? toastmasterId;
  String? applicationDate;
  String? acceptanceDate;
  String? applicantStatus;

  SlotApplicant({
    this.toastmasterId,
    this.applicationDate,
    this.acceptanceDate,
    this.applicantStatus,
  });

  SlotApplicant.fromJson(Map<String, dynamic> SlotApplicantJson)
      : this(
          toastmasterId: SlotApplicantJson['toastmasterId'],
          applicationDate: SlotApplicantJson['applicationDate'],
          acceptanceDate: SlotApplicantJson['acceptanceDate'],
          applicantStatus: SlotApplicantJson['applicantStatus'],
        );

  Map<String, dynamic> toJson() => {
        'toastmasterId': toastmasterId,
        'applicationDate': applicationDate,
        'acceptanceDate': acceptanceDate,
        'applicantStatus': applicantStatus,
      };
}
