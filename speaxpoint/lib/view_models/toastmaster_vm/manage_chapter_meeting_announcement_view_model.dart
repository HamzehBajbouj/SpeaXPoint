import 'dart:io';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/annoucement/chapter_meeting_announcement.dart';
import 'package:speaxpoint/models/annoucement/volunteer_annoucement.dart';
import 'package:speaxpoint/models/meeting_agenda.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_agenda/i_manage_meeting_agenda_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_announcements/i_manage_chapter_meeting_announcements_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class ManageChapterMeetingAnnouncementViewModel extends BaseViewModel {
  final IManageChapterMeeingAnnouncementsService
      _manageChapterMeeingAnnouncementsService;
  final IManageMeetingAgendaService _manageMeetingAgendaService;

  ChapterMeetingAnnouncement? _chapterMeetingAnnouncement;
  ChapterMeetingAnnouncement? get chapterMeetingAnnouncement =>
      _chapterMeetingAnnouncement;

  VolunteerAnnouncement? _volunteerAnnouncement;
  VolunteerAnnouncement? get volunteerAnnouncement => _volunteerAnnouncement;

  List<MeetingAgenda> _agendaWithPlayersList = [];
  List<MeetingAgenda> get agendaWithPlayersList => _agendaWithPlayersList;

  String _meetingAgendaWarningMessage = "";
  String get meetingAgendaWarningMessage => _meetingAgendaWarningMessage;

  //if  meeting agenda or not has been created before or not,
  //and whether all roles are allocated.
  //true => GO , false => No Go
  bool _meetingAgendaStatus = true;
  bool get meetingAgendaStatus => _meetingAgendaStatus;
  set meetingAgendaStatus(bool value) {
    _meetingAgendaStatus = value;
  }

  Result<Unit, Failure>? _deleteStatus;
  Result<Unit, Failure>? get deleteStatus => _deleteStatus;

  bool allowToAnnounceChpater = false;

  ManageChapterMeetingAnnouncementViewModel(
      this._manageChapterMeeingAnnouncementsService,
      this._manageMeetingAgendaService);

  //This method will load all the available announcements
  Stream<List<Map<String, dynamic>>> loadAllAnnouncements(
      {required String chapterMeetingId}) {
    return _manageChapterMeeingAnnouncementsService
        .getChapterMeetingAnnouncement(chapterMeetingId: chapterMeetingId);
  }

  void setAnnouncementObject(List<Map<String, dynamic>> announcements) {
    //find the element that has VolunteersAnnouncement
    Map<String, dynamic> value1 = announcements.firstWhere(
        (element) =>
            element.containsValue(AnnouncementType.VolunteersAnnouncement.name),
        orElse: () => {});
    if (value1.isNotEmpty) {
      _volunteerAnnouncement = VolunteerAnnouncement.fromJson(value1);
    } else {
      _volunteerAnnouncement = null;
    }

    Map<String, dynamic> value2 = announcements.firstWhere(
        (element) => element
            .containsValue(AnnouncementType.ChapterMeetingAnnouncement.name),
        orElse: () => {});
    if (value2.isNotEmpty) {
      _chapterMeetingAnnouncement = ChapterMeetingAnnouncement.fromJson(value2);
    } else {
      _chapterMeetingAnnouncement = null;
    }
    setLoading();
  }

// this method will check whether we can create an announcement for the chapter meeting or not.
//if you have an existing announcement you can not either to update nor to add new one
//you to delete the existing one, so you create a new announcement
  bool canAnnounce() {
    if (_chapterMeetingAnnouncement == null) {
      allowToAnnounceChpater = true;
    } else {
      allowToAnnounceChpater = false;
    }
    return allowToAnnounceChpater;
  }

  Future<void> deleteAnExistingAnnouncement(
      {required String chapterMeetingId,
      required String announcementType}) async {
    _deleteStatus = await _manageChapterMeeingAnnouncementsService
        .deletePublishedAnnouncement(
            chapterMeetingId: chapterMeetingId,
            announcementType: announcementType)
        .then(
      (value) {
        value.whenSuccess(
          (success) {
            if (announcementType ==
                AnnouncementType.VolunteersAnnouncement.name) {
              _volunteerAnnouncement = null;
            } else if (announcementType ==
                AnnouncementType.ChapterMeetingAnnouncement.name) {
              _chapterMeetingAnnouncement = null;
            }
          },
        );
      },
    );

    setLoading();
  }

//validate that there are existing meeting agenda,
//validate that all role are allocated
  Future<void> validateMeetingAgenda({required String chapterMeetingId}) async {
    setLoading(loading: true);

    //this varialbe is to make sure that the first request is done and then call,
    //the second one.
    bool internalStatus = false;
    await _manageMeetingAgendaService.getMeetingAgenda(chapterMeetingId).then(
      (value) {
        value.whenSuccess(
          (meetingAgenda) {
            _agendaWithPlayersList = meetingAgenda;

            if (meetingAgenda.isEmpty) {
              _meetingAgendaStatus = false;
              _meetingAgendaWarningMessage =
                  "It seems you don't have any agenda for this chapter"
                  " please make sure you have at least one agenda card.";
            } else {
              _meetingAgendaStatus = true;
              internalStatus = true;
            }
          },
        );
      },
    );

    if (internalStatus) {
      await _manageMeetingAgendaService
          .getListOfAllAgendaWithNoAllocatedRolePlayers(chapterMeetingId)
          .then(
        (value) {
          value.whenSuccess(
            (success) {
              if (success.isEmpty) {
                _meetingAgendaStatus = true;
              } else {
                _meetingAgendaStatus = false;
                _meetingAgendaWarningMessage =
                    "You can not announce the chapter while having un-allocated roles."
                    "please check you chapter meeting agenda.";
              }
            },
          );
        },
      );
    }
    //check that there are at least one meeting agenda with a role(even if it's un-allocatated)
    //and that not all the agenda are empty.
    if (_agendaWithPlayersList.isNotEmpty) {
      bool agendaAreNotEmpty = false;

      for (MeetingAgenda item in _agendaWithPlayersList) {
        if (item.roleName != null && item.roleOrderPlace != null) {
          agendaAreNotEmpty = true;
        }
      }

      if (!agendaAreNotEmpty) {
        _meetingAgendaStatus = false;
        _meetingAgendaWarningMessage =
            "Your Agenda have some empty cards, please assign some data e.g.: roles";
      }
    }
    setLoading(loading: false);
  }

  //later i have to handle the image , don't include it now

  /*
    check 
  */
  Future<Result<Unit, Failure>> announceChapterMeeting({
    required String meetingDescription,
    required String meetingTtile,
    required String meetingDate,
    required String annoucementLevel,
    required String chapterMeetingId,
    required String clubId,
    required String contactNumber,
    required String meetingStreamLink,
    required File? brochureFile,
  }) async {
    ChapterMeetingAnnouncement chapterMeetingAnnouncement =
        ChapterMeetingAnnouncement(
      annoucementDate: DateTime.now().toString(),
      annoucementStatus: AnnouncementStatus.Posted.name,
      annoucementType: AnnouncementType.ChapterMeetingAnnouncement.name,
      chapterMeetingId: chapterMeetingId,
      clubId: clubId,
      annoucementLevel: annoucementLevel,
      meetingDate: meetingDate,
      contactNumber: contactNumber.isEmpty ? null : contactNumber,
      meetingDescription: meetingDescription,
      meetingTtile: meetingTtile,
      meetingStreamLink: meetingStreamLink.isEmpty ? null : meetingStreamLink,
    );

    return await _manageChapterMeeingAnnouncementsService
        .announceChapterMeeting(
      chapterMeetingAnnouncement: chapterMeetingAnnouncement,
      brochureFile: brochureFile,
      chapterMeetingId: chapterMeetingId,
    );
  }
}
