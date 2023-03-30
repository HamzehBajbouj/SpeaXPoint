import 'package:speaxpoint/util/constants/common_enums.dart';

class Toastmaster {
  String? toastmasterId;
  String? clubId;
  String? toastmasterName;
  String? currentPath;
  String? currentProject;
  int? currentLevel;
  String? toastmasterBirthDate;
  String? gender;
  String? memberOfficalRole;
  String? toastmasterImage;
  String? appRole;

  Toastmaster({
    this.clubId,
    this.toastmasterId,
    this.toastmasterName,
    this.currentPath,
    this.currentProject,
    this.currentLevel,
    this.gender,
    this.memberOfficalRole,
    this.toastmasterBirthDate,
    this.toastmasterImage,
    this.appRole,
  });

  Toastmaster.fromJson(Map<String, dynamic> toastmasterJson)
      : this(
          toastmasterId: toastmasterJson['toastmasterId'],
          clubId: toastmasterJson['clubId'],
          toastmasterName: toastmasterJson['toastmasterName'],
          currentPath: toastmasterJson['currentPath'],
          currentProject: toastmasterJson['currentProject'],
          toastmasterBirthDate: toastmasterJson['toastmasterBirthDate'],
          currentLevel: toastmasterJson['currentLevel'] as int,
          gender: toastmasterJson['gender'],
          memberOfficalRole: toastmasterJson['memberOfficalRole'],
          toastmasterImage: toastmasterJson['toastmasterImage'],
          appRole: toastmasterJson['appRole'],
        );

  Map<String, dynamic> toJson() => {
        'toastmasterId': toastmasterId,
        'clubId': clubId,
        'toastmasterName': toastmasterName,
        'currentPath': currentPath,
        'currentProject': currentProject,
        'currentLevel': currentLevel,
        'toastmasterBirthDate': toastmasterBirthDate,
        'gender': gender,
        'memberOfficalRole': memberOfficalRole,
        'toastmasterImage': toastmasterImage,
        'appRole': AppRoles.Toastmaster.name,
      };
}
