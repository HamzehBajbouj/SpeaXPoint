import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/grammarian_note.dart';
import 'package:speaxpoint/services/failure.dart';

abstract class IGrammarianService {
  Future<Result<Unit, Failure>> increaseWOTDCounter({
    required String capturingTime,
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });

  Future<Result<Unit, Failure>> decreaseWOTDCounter({
    required String capturingTime,
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });

  Future<Result<Unit, Failure>> addGrammaticalNote({
    required GrammarianNote grammarianNote,
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });

  Future<Result<Unit, Failure>> deleteGrammaticalNote({
    required String noteId,
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });
  Future<Result<int, Failure>> getWOTDUsagesCount({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });

  Stream<int> getWOTDUsagesLiveDataCount({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });

  Future<Result<List<GrammarianNote>, Failure>> getGrammaticalNotes({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  });
}
