class VolunteerSlot {
  String? roleName;
  int? roleOrderPlace;
  //three colors , green , orange, gray, to indicate the status of the slot.
  //Green there was an applicant and it was accepted.
  //Gray it was posted but no applicatants.
  //Orange, there are appending applicatants.
  String? slotStatus;
  int? slotUnqiueId;
  //this one is only used internally witinh the app
  //has two states announced or not
  String? isItAnnouncedBefore;

  VolunteerSlot({
    this.roleName,
    this.roleOrderPlace,
    this.slotStatus,
    this.slotUnqiueId,
    this.isItAnnouncedBefore
  });

  VolunteerSlot.fromJson(Map<String, dynamic> VolunteerSlotJson)
      : this(
          roleName: VolunteerSlotJson['roleName'],
          roleOrderPlace: VolunteerSlotJson['roleOrderPlace'],
          slotStatus: VolunteerSlotJson['slotStatus'],
          slotUnqiueId: VolunteerSlotJson['slotUnqiueId'],
        );

  Map<String, dynamic> toJson() => {
        'roleName': roleName,
        'roleOrderPlace': roleOrderPlace,
        'slotStatus': slotStatus,
        'slotUnqiueId': slotUnqiueId,
      };
}
