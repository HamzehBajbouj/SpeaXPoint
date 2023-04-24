import 'package:flutter/material.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/annoucement/volunteer_annoucement.dart';
import 'package:speaxpoint/models/meeting_agenda.dart';
import 'package:speaxpoint/models/volunteer_slot.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/services/meeting_arrangement/ask_for_volunteers/i_ask_for_volunteers_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_agenda/i_manage_meeting_agenda_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_announcements/i_manage_chapter_meeting_announcements_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class AskForVolunteersViewModel extends BaseViewModel {
  bool enableAnnounceNowButton = false;
  bool isTherePreviousAnnouncement = false;

  List<VolunteerSlot> _volunteersSlots = [];
  List<VolunteerSlot> get volunteersSlots => _volunteersSlots;

  List<MeetingAgenda> _agendaWithNoRolePlayersList = [];
  List<MeetingAgenda> get agendaWithNoRolePlayersList =>
      _agendaWithNoRolePlayersList;

  List<VolunteerSlot> _listOfAnnouncedVolunteers = [];

  String _announcementDescription = "";
  String get announcementDescription => _announcementDescription;

  String _announcementTitle = "";
  String get announcementTitle => _announcementTitle;

  final IAskForVolunteersService _askForVolunteersService;
  final IManageMeetingAgendaService _manageMeetingAgendaService;
  final IManageChapterMeeingAnnouncementsService
      _manageChapterMeeingAnnouncementsService;

  AskForVolunteersViewModel(
      this._askForVolunteersService,
      this._manageMeetingAgendaService,
      this._manageChapterMeeingAnnouncementsService);

  Future<void> initiateScreenElements(String chpaterMeetingId) async {
    setLoading(loading: true);
    enableAnnounceNowButton = false;
    _volunteersSlots = [];
    await _manageMeetingAgendaService
        .getListOfAllAgendaWithNoAllocatedRolePlayers(chpaterMeetingId)
        .then(
      (value) {
        value.whenSuccess(
          (success) {
            _agendaWithNoRolePlayersList = List.from(success);
          },
        );
      },
    );

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
          (success) {
            _announcementDescription = success.annoucementDescription ?? "";
            _announcementTitle = success.annoucementTitle ?? "";
            if (_announcementDescription.isNotEmpty &&
                _announcementTitle.isNotEmpty) {
              enableAnnounceNowButton = true;
            }
          },
        );
      },
    );

/*
    we need this to delete the duplicated elements in the _agendaWithNoRolePlayersList and 
    to delete the duplicated elements in the two arrays to have it in one array only
    List A , B , we want to filter A.
    List<String> A = ['apple', 'banana', 'cherry', 'apple', 'banana', 'grape'];
    List<String> B = ['lemon', 'orange', 'banana', 'pear'];
    to become :
    ['apple', 'cherry', 'grape']
    A will contain only unique elements that are not in B:
    this is to remove the elemets in A list that are already in B.
*/
    _agendaWithNoRolePlayersList.removeWhere(
      (agenda) => _listOfAnnouncedVolunteers.any((slot) =>
          slot.roleName == agenda.roleName &&
          slot.roleOrderPlace == agenda.roleOrderPlace),
    );

    _agendaWithNoRolePlayersList.forEach(
      (element) {
        volunteersSlots.add(
          VolunteerSlot(
              roleName: element.roleName!,
              roleOrderPlace: element.roleOrderPlace!,
              slotUnqiueId: -1, //because it's not existed yet
              isItAnnouncedBefore: AppVolunteerSlotStatus.UnAnnounced.name,
              slotStatus: VolunteerSlotStatus.NoApplication.name),
        );
      },
    );
    _listOfAnnouncedVolunteers.forEach(
      (element) {
        volunteersSlots.add(
          VolunteerSlot(
            roleName: element.roleName!,
            roleOrderPlace: element.roleOrderPlace!,
            slotUnqiueId: element.slotUnqiueId!,
            slotStatus: element.slotStatus,
            isItAnnouncedBefore: AppVolunteerSlotStatus.Announced.name,
          ),
        );
      },
    );
    _validatedIfThereIsVolunteersAnnouncemenet();
    setLoading(loading: false);
  }

  Future<Result<Unit, Failure>> announceNeedOfVolunteers(
      {required String chapterMeetingId,
      required String annnoucementTitle,
      required String annnoucementDescription}) async {
    setLoading(loading: true);
    VolunteerAnnouncement volunteerAnnoucement = VolunteerAnnouncement(
      annoucementDate: DateTime.now().toString(),
      annoucementType: AnnouncementType.VolunteersAnnouncement.name,
      annoucementStatus: AnnouncementStatus.Posted.name,
      annoucementDescription: annnoucementDescription,
      annoucementTitle: annnoucementTitle,
    );

    var temp = await _askForVolunteersService.announceForVolunteers(
        chapterMeetingId: chapterMeetingId,
        volunteerSlots: _volunteersSlots,
        announcement: volunteerAnnoucement);
    setLoading(loading: false);
    return temp;
  }

  void deleteSlot(int slotIndex) {
    _volunteersSlots.removeAt(slotIndex);
    setLoading();
  }

  enableButton(bool bs) {
    enableAnnounceNowButton = bs;
    setLoading();
  }

  void _validatedIfThereIsVolunteersAnnouncemenet() {
    if (_listOfAnnouncedVolunteers.isNotEmpty &&
        _announcementDescription.isNotEmpty &&
        _announcementTitle.isNotEmpty) {
      isTherePreviousAnnouncement = true;
    }
  }
}

/*
This is only an internal class that is meant to be used to display the 
data in the screen in a certain way, this shall never be used to in any other
places or purposes.
*/
class Slots {
  String roleName;
  int roleOrderPlace;
  String slotStatus; // either announced or not
  int slotUnqiueId;

  Slots({
    required this.roleName,
    required this.roleOrderPlace,
    required this.slotStatus,
    required this.slotUnqiueId,
  });
}
