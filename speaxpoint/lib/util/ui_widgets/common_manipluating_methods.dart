import 'package:drop_down_list/model/selected_list_item.dart';

List<SelectedListItem> generateSelectedListItems(
    {required List<String> choices, required List<int> indexes}) {
  List<SelectedListItem> tempList = [];
  for (int i = 0; i < choices.length; i++) {
    tempList.add(SelectedListItem(
      name: choices[i],
      value: indexes[i].toString(),
    ));
  }
  return tempList;
}

String formatTime(Duration duration) {
  String hours = (duration.inHours % 24).toString().padLeft(2, '0');
  String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
  String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
  return '$hours:$minutes:$seconds';
}

DateTime findTimeDifferenceLocalNowAndReceivedUTC(
    {required String receivedUTCTime}) {
  DateTime receivedTime = DateTime.parse(receivedUTCTime).toLocal();
  DateTime currentTime = DateTime.now();
  Duration timeDifference = currentTime.difference(receivedTime);
  return currentTime.subtract(timeDifference);
}

double getDateTimeDifferenceInMinutes(
    {required String startingDateTime, required String endDateTime}) {
  DateTime start = DateTime.parse(startingDateTime).toUtc();
  DateTime end = DateTime.parse(endDateTime).toUtc();

  Duration difference = end.difference(start);
  double differenceinSeconds = difference.inSeconds.toDouble();

  return differenceinSeconds / 60;
}
