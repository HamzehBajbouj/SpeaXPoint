class AllocatedRolePlayer {
  int? allocatedRolePlayerUniqueId;
  String? toastmasterUsername;
  String? toastmasterId;
  String? rolePlayerName;
  String? roleName;
  //the roleOrderPlace is meant to differenitate between if he is first speaks , or second speaker..etc
  int? rolePlayerOrderPlace;
  String? invitationCode;
  String? allocatedRolePlayerType;

  // we can add the club name in the future , which will be obtained automatically
  // String? clubName;

  AllocatedRolePlayer(
      {this.allocatedRolePlayerUniqueId,
      this.invitationCode,
      this.roleName,
      this.rolePlayerOrderPlace,
      this.rolePlayerName,
      this.toastmasterId,
      this.toastmasterUsername,
      this.allocatedRolePlayerType});

  AllocatedRolePlayer.fromJson(Map<String, dynamic> allocatedRolePlayerJson)
      : this(
          allocatedRolePlayerUniqueId:
              allocatedRolePlayerJson['allocatedRolePlayerUniqueId'],
          toastmasterUsername: allocatedRolePlayerJson['toastmasterUsername'],
          invitationCode: allocatedRolePlayerJson['invitationCode'],
          roleName: allocatedRolePlayerJson['roleName'],
          rolePlayerOrderPlace: allocatedRolePlayerJson['rolePlayerOrderPlace'],
          rolePlayerName: allocatedRolePlayerJson['rolePlayerName'],
          toastmasterId: allocatedRolePlayerJson['toastmasterId'],
          allocatedRolePlayerType:
              allocatedRolePlayerJson['allocatedRolePlayerType'],
        );

  Map<String, dynamic> toJson() => {
        'allocatedRolePlayerUniqueId': allocatedRolePlayerUniqueId,
        'toastmasterUsername': toastmasterUsername,
        'invitationCode': invitationCode,
        'roleName': roleName,
        'rolePlayerOrderPlace': rolePlayerOrderPlace,
        'rolePlayerName': rolePlayerName,
        'toastmasterId': toastmasterId,
        'allocatedRolePlayerType': allocatedRolePlayerType
      };
}
