import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/annoucement/announcement.dart';
import 'package:speaxpoint/models/slot_applicant.dart';
import 'package:speaxpoint/models/volunteer_slot.dart';
import 'package:speaxpoint/services/local_database/i_local_database_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/ask_for_volunteers/i_ask_for_volunteers_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_announcements/i_manage_chapter_meeting_announcements_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/shared_preferences_keys.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

import '../../services/failure.dart';

class VolunteerAnnouncementViewDetailsViewModel extends BaseViewModel {
  List<VolunteerSlot> _listOfAnnouncedVolunteers = [];
  Announcement _announcement = Announcement();
  final IAskForVolunteersService _askForVolunteersService;
  final IManageChapterMeeingAnnouncementsService
      _manageChapterMeeingAnnouncementsService;
  final ILocalDataBaseService _localDataBaseService;

//GETTERS
  Announcement get announcement => _announcement;
  List<VolunteerSlot> get volunteersSlots => _listOfAnnouncedVolunteers;

  VolunteerAnnouncementViewDetailsViewModel(
      this._askForVolunteersService,
      this._manageChapterMeeingAnnouncementsService,
      this._localDataBaseService);

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

  Future<Result<bool, Failure>> validateApplicantExisting({
    required int slotUnqiueId,
    required String chapterMeetingId,
  }) async {
    setLoading(loading: true);
    //get current logged user details
    Map<String, dynamic> loggedUser =
        await _localDataBaseService.loadData(SharedPrefereneceKeys.loggedUser);
    var temp = await _askForVolunteersService.checkExistingSlotApplicant(
        slotUnqiueId: slotUnqiueId,
        chapterMeetingId: chapterMeetingId,
        toastmasterId: loggedUser["toastmasterId"]);
    setLoading(loading: false);
    return temp;
  }

  Future<Result<Unit, Failure>> volunteerToRoleSlot({
    required int slotUnqiueId,
    required String chapterMeetingId,
  }) async {
    setLoading(loading: true);

    //get current logged user details
    Map<String, dynamic> loggedUser =
        await _localDataBaseService.loadData(SharedPrefereneceKeys.loggedUser);
    SlotApplicant slotApplicant = SlotApplicant(
        applicationDate: DateTime.now().toString(),
        applicantStatus: ApplicantStatus.Pending.name,
        toastmasterId: loggedUser["toastmasterId"]);
    var temp = await 
    _askForVolunteersService.addNewVolunteerSlotApplicant(
        slotUnqiueId: slotUnqiueId,
        chapterMeetingId: chapterMeetingId,
        slotApplicant: slotApplicant);
    setLoading(loading: false);
    return temp;
  }
}
