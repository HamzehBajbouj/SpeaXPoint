import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/speech_timing.dart';
import 'package:speaxpoint/services/failure.dart';

abstract class ITimingRoleService {
  Future<Result<Unit, Failure>> startCurrentSpeakerTiming({
    required SpeechTiming speechTiming,
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });

  Future<Result<Unit, Failure>> stopCurrentSpeakerTiming({
    required SpeechTiming speechTiming,
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });

  Future<Result<SpeechTiming, Failure>> getSpeakerSpeechTimingData({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });

  Stream<SpeechTiming> getSpeakerSpeechTimingLiveData({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });
}
