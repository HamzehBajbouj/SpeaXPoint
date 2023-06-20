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
    return message =
        "${speakerName == null ?'You' :'Speaker \"$speakerName\" '}spent $speechMinutes minutes & $speechSeconds seconds, which is less than the minimum speech time, making \"$speakerName\" NOT eligible for voting.";
  }

  if (timeDifferecne <= yellow) {
    return message =
        "${speakerName == null ?'You' :'Speaker \"$speakerName\" '}spent $speechMinutes minutes & $speechSeconds seconds, which is more than the minimum speech time, making \"$speakerName\" eligible for voting.";
  }
  if (timeDifferecne <= red) {
    return message =
        "${speakerName == null ?'You' :'Speaker \"$speakerName\" '}spent $speechMinutes minutes & $speechSeconds seconds, which is less than the maximum speech time, making \"$speakerName\" eligible for voting.";
  }

  if (timeDifferecne > red) {
    return message =
        "${speakerName == null ?'You' :'Speaker \"$speakerName\" '}spent $speechMinutes minutes & $speechSeconds seconds, which is more than the maximum speech time, making \"$speakerName\" NOT eligible for voting.";
  }
  return message;
}


  String getOrdinal(int number) {
    final format = NumberFormat('en_US');
    final suffixes = [
      'th',
      'st',
      'nd',
      'rd',
      'th',
      'th',
      'th',
      'th',
      'th',
      'th'
    ];

    if (number >= 11 && number <= 13) {
      return '${format.format(number)}th';
    }

    final remainder = number % 10;

    if (remainder >= suffixes.length) {
      return '${format.format(number)}th';
    }

    return format.format(number) + suffixes[remainder];
  }
