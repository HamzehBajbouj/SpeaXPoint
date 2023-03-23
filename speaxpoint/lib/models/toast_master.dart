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
        'toastmasterImage': toastmasterImage
      };
}
