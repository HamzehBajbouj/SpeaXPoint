String getCurrentUTCTime() {
  DateTime currentTime = DateTime.now();
  DateTime targetTime = currentTime.toUtc();
  return targetTime.toString();
}

String convertUtcToCurrentTimeZone(String utcTimeString) {
  DateTime utcTime = DateTime.parse(utcTimeString);
  DateTime localTime = utcTime.toLocal();
  return localTime.toString();
}
