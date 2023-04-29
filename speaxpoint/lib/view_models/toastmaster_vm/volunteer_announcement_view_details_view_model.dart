import 'package:flutter/cupertino.dart';
import 'package:speaxpoint/models/annoucement/announcement.dart';
import 'package:speaxpoint/models/volunteer_slot.dart';
import 'package:speaxpoint/services/meeting_arrangement/ask_for_volunteers/i_ask_for_volunteers_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_announcements/i_manage_chapter_meeting_announcements_service.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class VolunteerAnnouncementViewDetailsViewModel extends BaseViewModel {
  List<VolunteerSlot> _listOfAnnouncedVolunteers = [];
  Announcement _announcement = Announcement();
  final IAskForVolunteersService _askForVolunteersService;
  final IManageChapterMeeingAnnouncementsService
      _manageChapterMeeingAnnouncementsService;

//GETTERS
  Announcement get announcement => _announcement;
  List<VolunteerSlot> get volunteersSlots => _listOfAnnouncedVolunteers;

  VolunteerAnnouncementViewDetailsViewModel(this._askForVolunteersService,
      this._manageChapterMeeingAnnouncementsService);

  Future<void> loadVolunteerAnnouncementDetails(
      {required String chpaterMeetingId}) async {
    _listOfAnnouncedVolunteers = [];
    setLoading(loading: true);
    await _askForVolunteersService
        .getVolunteersAnnouncedSlot(chapterMeetingId: chpaterMeetingId)
        .then(
      (value) {
        value.whenSuccess(
          (success) {
            _listOfAnnouncedVolunteers = List.from(success);
          },
        );
      },
    );

    await _manageChapterMeeingAnnouncementsService
        .getVolunteersAnnouncement(chapterMeetingId: chpaterMeetingId)
        .then(
      (value) {
        value.whenSuccess(
          (announcement) {
            _announcement = announcement;
          },
        );
      },
    );
    setLoading(loading: false);
  }
}
