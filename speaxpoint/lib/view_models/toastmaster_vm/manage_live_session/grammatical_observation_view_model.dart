import 'package:flutter/material.dart';
import 'package:speaxpoint/models/grammarian_note.dart';
import 'package:speaxpoint/services/live_session/grammarian/i_grammarian_service.dart';
import 'package:speaxpoint/services/live_session/i_live_session_service.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/common_live_session_method_view_model.dart';
import 'package:uuid/uuid.dart';

class GrammaticalObservationViewModel
    extends CommonLiveSessionMethodsViewModel {
  final ILiveSessionService _liveSessionService;
  final IGrammarianService _grammarianService;

  GrammaticalObservationViewModel(
      this._liveSessionService, this._grammarianService)
      : super(_liveSessionService);

  Future<void> increaseWOTDCounter({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) async {
    setLoading(loading: true);
    await _grammarianService.increaseWOTDCounter(
      capturingTime: DateTime.now().toUtc().toString(),
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
    setLoading(loading: false);
  }

  Future<void> decreaseWOTDCounter({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) async {
    setLoading(loading: true);

    await _grammarianService.decreaseWOTDCounter(
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
    setLoading(loading: false);
  }

  Future<void> addGrammaticalNote({
    required String noteContent,
    String? noteTitle,
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) async {
    setLoading(loading: true);

    const uuid = Uuid();
    String randomId1 = uuid.v4();
    randomId1 = "gid${randomId1.substring(0, randomId1.indexOf("-"))}";
    // //for create the unique id, just create random Id and add the randomId1 at the end.
    String randomId2 = uuid.v4();
    randomId2 = randomId1 + randomId2.substring(0, randomId2.indexOf("-"));

    await _grammarianService.addGrammaticalNote(
      grammarianNote: GrammarianNote(
        noteCapturedTime: DateTime.now().toUtc().toString(),
        noteContent: noteContent,
        noteTitle: noteTitle,
        noteId: randomId2,
      ),
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
    setLoading(loading: false);
  }

  Future<void> deleteGrammaticalNote({
    required String noteId,
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) async {
    setLoading(loading: true);
    await _grammarianService.deleteGrammaticalNote(
      noteId: noteId,
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
    setLoading(loading: false);
  }

  Future<int> getWOTDUsagesCount({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) async {
    int WOTDcout = 0;
    setLoading(loading: true);
    await _grammarianService
        .getWOTDUsagesCount(
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    )
        .then(
      (value) {
        value.whenSuccess(
          (success) {
            WOTDcout = success;
          },
        );
      },
    );
    setLoading(loading: false);
    return WOTDcout;
  }

  Stream<int> getWOTDUsagesLiveDataCount({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) {
    return _grammarianService.getWOTDUsagesLiveDataCount(
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
  }

  Future<List<GrammarianNote>> getGrammaticalNotes({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) async {
    List<GrammarianNote> noteList = [];
    await _grammarianService
        .getGrammaticalNotes(
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    )
        .then(
      (value) {
        value.whenSuccess(
          (success) {
            noteList = success;
          },
        );
      },
    );
    return noteList;
  }
}
