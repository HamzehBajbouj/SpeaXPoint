//this models represents the chapter meeting online session launching data
class OnlineSession {
  String? currentSpeakerToastmasterId;
  String? currentGuestSpeakerInvitationCode;
  String? lanuchingTime;
  bool? thereIsSelectedSpeaker;
  bool? isGuest;
  int? numberOfJoinedPeople;

  OnlineSession({
    this.currentSpeakerToastmasterId,
    this.currentGuestSpeakerInvitationCode,
    this.lanuchingTime,
    this.thereIsSelectedSpeaker,
    this.isGuest,
    this.numberOfJoinedPeople,
  });

  OnlineSession.fromJson(Map<String, dynamic> onlineSessionJson)
      : this(
          currentSpeakerToastmasterId:
              onlineSessionJson['currentSpeakerToastmasterId'],
          currentGuestSpeakerInvitationCode:
              onlineSessionJson['currentGuestSpeakerInvitationCode'],
          lanuchingTime: onlineSessionJson['lanuchingTime'],
          thereIsSelectedSpeaker: onlineSessionJson['thereIsSelectedSpeaker'],
          isGuest: onlineSessionJson['isGuest'],
          numberOfJoinedPeople: onlineSessionJson['numberOfJoinedPeople'],
        );

  Map<String, dynamic> toJson() => {
        'currentSpeakerToastmasterId': currentSpeakerToastmasterId,
        'currentGuestSpeakerInvitationCode': currentGuestSpeakerInvitationCode,
        'lanuchingTime': lanuchingTime,
        'thereIsSelectedSpeaker': thereIsSelectedSpeaker,
        'isGuest': isGuest,
        'numberOfJoinedPeople': numberOfJoinedPeople,
      };
}
