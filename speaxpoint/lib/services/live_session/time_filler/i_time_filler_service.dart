import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/time_filler_captured_data.dart';
import 'package:speaxpoint/services/failure.dart';

abstract class ITimeFillerService {
  Future<Result<Unit, Failure>> increaseTimeFillerCounter({
    required TimeFillerCapturedData timeFillerCapturedData,
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });

  Future<Result<Unit, Failure>> decreaseTimeFillerCounter({
    required TimeFillerCapturedData timeFillerCapturedData,
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });

  Future<Result<Map<String, int>, Failure>>
      getSpeakerTimeFillerData({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });

  Stream<Map<String, int>> getSpeakerTimeFillerLiveData({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });
  
  Stream<int> getTotalNumberOfTimeFillers({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });
}
