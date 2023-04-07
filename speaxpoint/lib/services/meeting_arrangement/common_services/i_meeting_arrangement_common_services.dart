import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/services/Failure.dart';

abstract class IMeetingArrangementCommonServices {
  Future<Result<List<Toastmaster>, Failure>> getAllClubMembersList(
      String clubId);
}
