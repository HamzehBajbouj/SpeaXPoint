/*
  This model is used for the collected time filler data of the speakers during the session 
  by the ah counter role players
*/
class TimeFillerCapturedData {
  String? timeOfCapturing;
  String? typeOfTimeFiller;

  TimeFillerCapturedData({
    this.timeOfCapturing,
    this.typeOfTimeFiller,
  });

  TimeFillerCapturedData.fromJson(
      Map<String, dynamic> timeFillerCapturedDataJson)
      : this(
          timeOfCapturing: timeFillerCapturedDataJson['timeOfCapturing'],
          typeOfTimeFiller: timeFillerCapturedDataJson['typeOfTimeFiller'],
        );

  Map<String, dynamic> toJson() => {
        'typeOfTimeFiller': typeOfTimeFiller,
        'timeOfCapturing': timeOfCapturing,
      };
}
