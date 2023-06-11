import 'package:speaxpoint/util/constants/common_enums.dart';

class ClubAccount {
  String? clubId;
  String? usermame;
  String? clubName;
  String? profileDescription;
  String? webSiteLink;
  String? officialEmail;
  String? clubPhoneNumber;
  String? backgroundImageURL;
  String? profileImageURL;
  String? clubLocationLink;
  String? clubOverviewTitle;
  String? clubOverviewDescription;
  String? appRole = AppRoles.ClubPresident.name;
  bool? clubProfileWasSetUp;

  ClubAccount({
    this.clubId,
    this.usermame,
    this.backgroundImageURL,
    this.profileDescription,
    this.profileImageURL,
    this.clubName,
    this.clubPhoneNumber,
    this.officialEmail,
    this.webSiteLink,
    this.appRole,
    this.clubLocationLink,
    this.clubOverviewDescription,
    this.clubOverviewTitle,
    this.clubProfileWasSetUp,
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
          backgroundImageURL: clubAccountJson['backgroundImageURL'],
          profileImageURL: clubAccountJson['profileImageURL'],
          appRole: clubAccountJson['appRole'],
          clubLocationLink: clubAccountJson['clubLocationLink'],
          clubOverviewTitle: clubAccountJson['clubOverviewTitle'],
          clubOverviewDescription: clubAccountJson['clubOverviewDescription'],
          clubProfileWasSetUp: clubAccountJson['clubProfileWasSetUp'],
        );

  Map<String, dynamic> toJson() => {
        'clubId': clubId,
        'usermame': usermame,
        'clubName': clubName,
        'profileDescription': profileDescription,
        'webSiteLink': webSiteLink,
        'officialEmail': officialEmail,
        'clubPhoneNumber': clubPhoneNumber,
        'backgroundImageURL': backgroundImageURL,
        'profileImageURL': profileImageURL,
        'appRole': appRole,
        'clubLocationLink': clubLocationLink,
        'clubOverviewTitle': clubOverviewTitle,
        'clubOverviewDescription': clubOverviewDescription,
        'clubProfileWasSetUp': clubProfileWasSetUp,
      };
}
