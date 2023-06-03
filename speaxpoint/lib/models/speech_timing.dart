/*
  This model is used for the collected Timing data of the speakers during the session 
  by the timer role players
*/
class SpeechTiming {
  int? greenLightLimit;
  int? yellowLightLimit;
  int? redLightLimit;
  String? timeCounterStartingTime;
  String? timeCounterEndingTime;
  bool? timeCounterStarted;
  SpeechTiming(
      {this.greenLightLimit,
      this.redLightLimit,
      this.timeCounterEndingTime,
      this.timeCounterStarted,
      this.timeCounterStartingTime,
      this.yellowLightLimit});

  SpeechTiming.fromJson(Map<String, dynamic> speechTimingJson)
      : this(
          greenLightLimit: speechTimingJson['greenLightLimit'],
          yellowLightLimit: speechTimingJson['yellowLightLimit'],
          redLightLimit: speechTimingJson['redLightLimit'],
          timeCounterStartingTime: speechTimingJson['timeCounterStartingTime'],
          timeCounterEndingTime: speechTimingJson['timeCounterEndingTime'],
          timeCounterStarted: speechTimingJson['timeCounterStarted'],
        );

  Map<String, dynamic> toJson() => {
        'greenLightLimit': greenLightLimit,
        'yellowLightLimit': yellowLightLimit,
        'redLightLimit': redLightLimit,
        'timeCounterStartingTime': timeCounterStartingTime,
        'timeCounterEndingTime': timeCounterEndingTime,
        'timeCounterStarted': timeCounterStarted,
      };
}
