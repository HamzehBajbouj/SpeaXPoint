class AllocatedRolePlayer {
  int? allocatedRolePlayerUniqueId;
  String? toastmasterUsername;
  String? toastmasterId;
  String? rolePlayerName;
  String? roleName;
  //the roleOrderPlace is meant to differenitate between if he is first speaks , or second speaker..etc
  int? roleOrderPlace;
  String? guestInvitationCode;
  String? allocatedRolePlayerType;

  // we can add the club name in the future , which will be obtained automatically
  // String? clubName;

  AllocatedRolePlayer(
      {this.allocatedRolePlayerUniqueId,
      this.guestInvitationCode,
      this.roleName,
      this.roleOrderPlace,
      this.rolePlayerName,
      this.toastmasterId,
      this.toastmasterUsername,
      this.allocatedRolePlayerType});

  AllocatedRolePlayer.fromJson(Map<String, dynamic> allocatedRolePlayerJson)
      : this(
          allocatedRolePlayerUniqueId:
              allocatedRolePlayerJson['allocatedRolePlayerUniqueId'],
          toastmasterUsername: allocatedRolePlayerJson['toastmasterUsername'],
          guestInvitationCode: allocatedRolePlayerJson['guestInvitationCode'],
          roleName: allocatedRolePlayerJson['roleName'],
          roleOrderPlace: allocatedRolePlayerJson['roleOrderPlace'],
          rolePlayerName: allocatedRolePlayerJson['rolePlayerName'],
          toastmasterId: allocatedRolePlayerJson['toastmasterId'],
          allocatedRolePlayerType:
              allocatedRolePlayerJson['allocatedRolePlayerType'],
        );

  Map<String, dynamic> toJson() => {
        'allocatedRolePlayerUniqueId': allocatedRolePlayerUniqueId,
        'toastmasterUsername': toastmasterUsername,
        'guestInvitationCode': guestInvitationCode,
        'roleName': roleName,
        'roleOrderPlace': roleOrderPlace,
        'rolePlayerName': rolePlayerName,
        'toastmasterId': toastmasterId,
        'allocatedRolePlayerType': allocatedRolePlayerType
      };
}
