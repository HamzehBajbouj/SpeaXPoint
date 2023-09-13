class OnlineSessionCapturedData {
  //here there should be as well compsition class for the captured data
  String? onlineSessionSpeakerTurn;
  String? speakerName;
  String? chapterMeetingId;
  String? chapterMeetingInvitationCode;
  String? guestInvitationCode;
  String? roleName;
  String? toastmasterId;
  bool? isAnAppGuest;
  int? roleOrderPlace;

  OnlineSessionCapturedData({
    this.onlineSessionSpeakerTurn,
    this.speakerName,
    this.chapterMeetingId,
    this.chapterMeetingInvitationCode,
    this.guestInvitationCode,
    this.isAnAppGuest,
    this.roleName,
    this.roleOrderPlace,
    this.toastmasterId,
  });

  OnlineSessionCapturedData.fromJson(
      Map<String, dynamic> onlineSessionCapturedDataJson)
      : this(
          onlineSessionSpeakerTurn:
              onlineSessionCapturedDataJson['onlineSessionSpeakerTurn'],
          speakerName: onlineSessionCapturedDataJson['speakerName'],
          chapterMeetingId: onlineSessionCapturedDataJson['chapterMeetingId'],
          chapterMeetingInvitationCode:
              onlineSessionCapturedDataJson['chapterMeetingInvitationCode'],
          guestInvitationCode:
              onlineSessionCapturedDataJson['guestInvitationCode'],
          isAnAppGuest: onlineSessionCapturedDataJson['isAnAppGuest'],
          roleName: onlineSessionCapturedDataJson['roleName'],
          roleOrderPlace: onlineSessionCapturedDataJson['roleOrderPlace'],
          toastmasterId: onlineSessionCapturedDataJson['toastmasterId'],
        );

  Map<String, dynamic> toJson() => {
        'onlineSessionSpeakerTurn': onlineSessionSpeakerTurn,
        'speakerName': speakerName,
        'chapterMeetingId': chapterMeetingId,
        'chapterMeetingInvitationCode': chapterMeetingInvitationCode,
        'guestInvitationCode': guestInvitationCode,
        'isAnAppGuest': isAnAppGuest,
        'roleName': roleName,
        'roleOrderPlace': roleOrderPlace,
        'toastmasterId': toastmasterId,
      };
}
