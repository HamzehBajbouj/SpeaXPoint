import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/i_meeting_arrangement_common_services.dart';

import '../failure.dart';

abstract class ISessionRedirectionService {
  Future<Result<String, Failure>> getAppGuestRoleName({
    required String chapterMeetingInvitationCode,
    required String guestInvitationCode,
  });

  Future<Result<String, Failure>> getAppUserRoleName({
    required String chapterMeetingId,
    required String toastmasterId,
  });
}
