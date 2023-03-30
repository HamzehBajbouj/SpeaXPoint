import 'package:speaxpoint/util/constants/common_enums.dart';

class ClubAccount {
  String clubId;
  String? usermame;
  String? clubName;
  String? profileDescription;
  String? webSiteLink;
  String? officialEmail;
  String? clubPhoneNumber;
  String? backGroundImageURL;
  String? profileImageURL;
  String? appRole = AppRoles.ClubPresident.name;

  ClubAccount({
    required this.clubId,
    this.usermame,
    this.backGroundImageURL,
    this.profileDescription,
    this.profileImageURL,
    this.clubName,
    this.clubPhoneNumber,
    this.officialEmail,
    this.webSiteLink,
    this.appRole,
  });

  ClubAccount.fromJson(Map<String, dynamic> clubAccountJson)
      : this(
          clubId: clubAccountJson['clubId'],
          usermame: clubAccountJson['usermame'],
          clubName: clubAccountJson['clubName'],
          profileDescription: clubAccountJson['profileDescription'],
          webSiteLink: clubAccountJson['webSiteLink'],
          officialEmail: clubAccountJson['officialEmail'],
          clubPhoneNumber: clubAccountJson['clubPhoneNumber'],
          backGroundImageURL: clubAccountJson['backGroundImageURL'],
          profileImageURL: clubAccountJson['profileImageURL'],
          appRole: clubAccountJson['appRole'],
        );

  Map<String, dynamic> toJson() => {
        'clubId': clubId,
        'usermame': usermame,
        'clubName': clubName,
        'profileDescription': profileDescription,
        'webSiteLink': webSiteLink,
        'officialEmail': officialEmail,
        'clubPhoneNumber': clubPhoneNumber,
        'backGroundImageURL': backGroundImageURL,
        'profileImageURL': profileImageURL,
        'appRole': appRole,
      };
}
