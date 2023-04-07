class AllocatedRolePlayer {
  int? allocatedRolePlayerUniqueId;
  String? username;
  String? toastmasterId;
  String? rolePlayerName;
  String? roleName;
  //the roleOrderPlace is meant to differenitate between if he is first speaks , or second speaker..etc
  int? rolePlayerOrderPlace;
  String? invitationCode;
  String? allocatedRolePlayerUserAppType;

  // we can add the club name in the future , which will be obtained automatically
  // String? clubName;

  AllocatedRolePlayer(
      {this.allocatedRolePlayerUniqueId,
      this.invitationCode,
      this.roleName,
      this.rolePlayerOrderPlace,
      this.rolePlayerName,
      this.toastmasterId,
      this.username,
      this.allocatedRolePlayerUserAppType});

  AllocatedRolePlayer.fromJson(Map<String, dynamic> allocatedRolePlayerJson)
      : this(
          allocatedRolePlayerUniqueId:
              allocatedRolePlayerJson['allocatedRolePlayerUniqueId'],
          username: allocatedRolePlayerJson['username'],
          invitationCode: allocatedRolePlayerJson['invitationCode'],
          roleName: allocatedRolePlayerJson['roleName'],
          rolePlayerOrderPlace: allocatedRolePlayerJson['rolePlayerOrderPlace'],
          rolePlayerName: allocatedRolePlayerJson['rolePlayerName'],
          toastmasterId: allocatedRolePlayerJson['toastmasterId'],
          allocatedRolePlayerUserAppType:
              allocatedRolePlayerJson['allocatedRolePlayerUserAppType'],
        );

  Map<String, dynamic> toJson() => {
        'allocatedRolePlayerUniqueId': allocatedRolePlayerUniqueId,
        'username': username,
        'invitationCode': invitationCode,
        'roleName': roleName,
        'rolePlayerOrderPlace': rolePlayerOrderPlace,
        'rolePlayerName': rolePlayerName,
        'toastmasterId': toastmasterId,
        'allocatedRolePlayerUserAppType': allocatedRolePlayerUserAppType
      };
}
