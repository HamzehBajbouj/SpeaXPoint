import 'package:intl/intl.dart';
import 'package:speaxpoint/util/ui_widgets/common_manipluating_methods.dart';

String getSpeakerTimingSummary(
    {required String startingTime,
    required String endingTime,
    required int greenTime,
    required int yellow,
    required int red,
    required String? speakerName}) {
  double timeDifferecne = getDateTimeDifferenceInMinutes(
      startingDateTime: startingTime, endDateTime: endingTime);
  int speechMinutes = timeDifferecne.toInt();
  double speechSecondDouble = ((timeDifferecne - timeDifferecne.toInt()) * 60);
  int speechSeconds = speechSecondDouble.toInt();
  String message = "";
  if (timeDifferecne < greenTime) {
    if (speakerName == null) {
      message =
          "You spent $speechMinutes minutes & $speechSeconds seconds, which is less than the minimum speech time, making you NOT eligible for voting.";
    } else {
      message =
          "\"$speakerName\" spent $speechMinutes minutes & $speechSeconds seconds, which is less than the minimum speech time, making \"$speakerName\" NOT eligible for voting.";
    }
    return message;
  }

  if (timeDifferecne <= yellow) {
    if (speakerName == null) {
      message =
          "You spent $speechMinutes minutes & $speechSeconds seconds, which is more than the minimum speech time, making you eligible for voting.";
    } else {
      message =
          "\"$speakerName\" spent $speechMinutes minutes & $speechSeconds seconds, which is more than the minimum speech time, making \"$speakerName\" eligible for voting.";
    }
    return message;
  }
  if (timeDifferecne <= red) {
    if (speakerName == null) {
      message =
          "You spent $speechMinutes minutes & $speechSeconds seconds, which is less than the maximum speech time, making you eligible for voting.";
    } else {
      message =
          "\"$speakerName\" spent $speechMinutes minutes & $speechSeconds seconds, which is less than the maximum speech time, making \"$speakerName\" eligible for voting.";
    }
    return message;
  }

  if (timeDifferecne > red) {
    if (speakerName == null) {
      message =
          "You spent $speechMinutes minutes & $speechSeconds seconds, which is more than the maximum speech time, making you NOT eligible for voting.";
    } else {
      message =
          "\"$speakerName\" spent $speechMinutes minutes & $speechSeconds seconds, which is more than the maximum speech time, making \"$speakerName\" NOT eligible for voting.";
    }
    return message;
  }
  return message;
}

String getOrdinal(int number) {
  final format = NumberFormat();
  final suffixes = ['th', 'st', 'nd', 'rd', 'th', 'th', 'th', 'th', 'th', 'th'];

  if (number >= 11 && number <= 13) {
    return '${format.format(number)}th';
  }

  final remainder = number % 10;

  if (remainder >= suffixes.length) {
    return '${format.format(number)}th';
  }

  return format.format(number) + suffixes[remainder];
}
