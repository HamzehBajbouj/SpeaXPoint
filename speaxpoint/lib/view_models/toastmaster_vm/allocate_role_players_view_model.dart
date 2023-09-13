import 'dart:developer';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/app/service_locator.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:speaxpoint/models/meeting_agenda.dart';
import 'package:speaxpoint/models/slot_applicant.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/models/volunteer_slot.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/services/meeting_arrangement/allocate_role_players/i_allocate_role_players_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/ask_for_volunteers/i_ask_for_volunteers_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_agenda/i_manage_meeting_agenda_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';
import 'package:uuid/uuid.dart';

class AllocateRolePlayersViewModel extends BaseViewModel {
  final IAllocateRolePlayersService _allocateRolePlayersService;
  final IManageMeetingAgendaService _manageMeetingAgendaService;
  final IAskForVolunteersService _askForVolunteersService;

  Result<Unit, Failure>? _updateRoleStatus;
  Result<Unit, Failure>? get updateRoleStatus => _updateRoleStatus;

  Result<Unit, Failure>? _updateGuestRoleStatus;
  Result<Unit, Failure>? get updateGuestRoleStatus => _updateGuestRoleStatus;

  Result<Toastmaster, Failure>? _searchToastmasterUsername;
  Result<Toastmaster, Failure>? get searchToastmasterUsername =>
      _searchToastmasterUsername;

  List<MeetingAgenda> _agendaWithNoRolePlayersList = [];
  List<MeetingAgenda> get agendaWithNoRolePlayersList =>
      _agendaWithNoRolePlayersList;
  List<VolunteerSlot> _listOfAnnouncedVolunteers = [];

  List<Toastmaster> _volunteerSlotsApplicant = [];
  List<Toastmaster> get volunteerSlotsApplicant => _volunteerSlotsApplicant;

  //we make it true to hide the warning message in the begining
  bool toastmasterUsernameIsfound = true;

  AllocateRolePlayersViewModel(this._allocateRolePlayersService,
      this._manageMeetingAgendaService, this._askForVolunteersService);

  Future<void> deleteRolePlayerCard(
      String chapterMeetingId, int allocatedRolePlayerUniqueId) async {
    setLoading(loading: true);
    await _allocateRolePlayersService.deleteAllocatedRolePlayer(
        chapterMeetingId, allocatedRolePlayerUniqueId);
    validateAllocationOfAllRoles(chapterMeetingId);
    setLoading(loading: false);
  }

  Future<List<Toastmaster>> getClubMemberList(String clubId) async {
    List<Toastmaster> listOfClubMember = [];
    await _allocateRolePlayersService.getAllClubMembersList(clubId).then(
          (value) => value.when(
            (success) => value.whenSuccess(
              (success) {
                listOfClubMember = success;
              },
            ),
            (error) {
              log("${error.code} ${error.message}");
            },
          ),
        );
    return listOfClubMember;
  }

  Future<Result<bool, Failure>> validateRoleAvailability(
    String chapterMeetingId,
    String roleName,
    int memberRolePlace,
  ) async {
    return await _allocateRolePlayersService.validateIfRoleIsTaken(
      chapterMeetingId,
      roleName,
      super.getCorrectRoleOrderPlace(
          roleOrder: memberRolePlace, roleName: roleName),
    );
  }

// this method is similar to allocateGuestRolePlayer , we can refactor them into one method
//by adding a bool check variable
  Future<Result<Unit, Failure>> allocateNewPlayerFromClub(
      String chapterMeetingId,
      Toastmaster toastmaster,
      String roleName,
      int memberRolePlace,
      String allocatedRolePlayerType) async {
    super.setLoading(loading: true);
    var temp = await _allocateRolePlayersService.allocateNewRolePlayer(
      chapterMeetingId,
      AllocatedRolePlayer(
        roleName: roleName,
        roleOrderPlace: super.getCorrectRoleOrderPlace(
            roleName: roleName, roleOrder: memberRolePlace),
        rolePlayerName: toastmaster.toastmasterName,
        toastmasterId: toastmaster.toastmasterId,
        allocatedRolePlayerType: allocatedRolePlayerType,
        toastmasterUsername: toastmaster.toastmasterUsername,
      ),
      true,
    );
    await validateAllocationOfAllRoles(chapterMeetingId);
    super.setLoading(loading: false);
    return temp;
  }

  Future<Result<Unit, Failure>> allocateGuestRolePlayer(
      {required String chapterMeetingId,
      required String guestName,
      required String roleName,
      required int memberRolePlace,
      required String allocatedRolePlayerType}) async {
    //generate random guestInvitationCode, start from the second letter, so we don't get
    //the same code as the chapter meeting inivtation code
    super.setLoading(loading: true);
    var temp = await _allocateRolePlayersService.allocateNewRolePlayer(
      chapterMeetingId,
      AllocatedRolePlayer(
        guestInvitationCode: _generateRandomGuestId(),
        roleName: roleName,
        roleOrderPlace: super.getCorrectRoleOrderPlace(
            roleName: roleName, roleOrder: memberRolePlace),
        rolePlayerName: guestName,
        allocatedRolePlayerType: allocatedRolePlayerType,
      ),
      true,
    );
    await validateAllocationOfAllRoles(chapterMeetingId);
    super.setLoading(loading: false);

    return temp;
  }

  Future<void> updateExitngRoleDetails(
    String chapterMeetingId,
    String roleName,
    int memberRolePlace,
    Toastmaster? toastmaster,
    String allocatedRolePlayerType,
  ) async {
    super.setLoading(loading: true);

    _updateRoleStatus =
        await _allocateRolePlayersService.updateOccupiedRoleDetails(
      chapterMeetingId,
      AllocatedRolePlayer(
        roleName: roleName,
        roleOrderPlace: super.getCorrectRoleOrderPlace(
            roleName: roleName, roleOrder: memberRolePlace),
        rolePlayerName: toastmaster?.toastmasterName,
        toastmasterId: toastmaster?.toastmasterId,
        allocatedRolePlayerType: allocatedRolePlayerType,
        toastmasterUsername: toastmaster?.toastmasterUsername,
      ),
    );
    await validateAllocationOfAllRoles(chapterMeetingId);
    super.setLoading(loading: false);
  }

  Future<void> updateExitngGuestRoleDetails({
    required String chapterMeetingId,
    required String roleName,
    required int memberRolePlace,
    required String? guestName,
    required String allocatedRolePlayerType,
  }) async {
    super.setLoading(loading: true);
    _updateGuestRoleStatus =
        await _allocateRolePlayersService.updateOccupiedRoleDetails(
      chapterMeetingId,
      AllocatedRolePlayer(
        roleName: roleName,
        roleOrderPlace: super.getCorrectRoleOrderPlace(
            roleName: roleName, roleOrder: memberRolePlace),
        rolePlayerName: guestName,
        toastmasterId: null,
        allocatedRolePlayerType: allocatedRolePlayerType,
        toastmasterUsername: null,
        guestInvitationCode: _generateRandomGuestId(),
      ),
    );
    await validateAllocationOfAllRoles(chapterMeetingId);
    super.setLoading(loading: false);
  }

  Stream<List<AllocatedRolePlayer>> getAllocatedRolePlayers(
          String chapterMeetingId) =>
      _allocateRolePlayersService.getAllAllocatedRolePlayers(chapterMeetingId);

  Stream<List<VolunteerSlot>> getVolunteersSlots(String chapterMeetingId) =>
      _allocateRolePlayersService.getVolunteersSlots(chapterMeetingId);

  Future<void> searchForToastmasterUsername(
      {required String toastmasterUsername}) async {
    super.setLoading(loading: true);
    await _allocateRolePlayersService
        .searchOtherClubsMember(toastmasterUsername)
        .then(
      (value) {
        _searchToastmasterUsername = value;
        value.when(
          (success) {
            toastmasterUsernameIsfound = true;
          },
          (error) {
            toastmasterUsernameIsfound = false;
          },
        );
      },
    );
    super.setLoading(loading: false);
  }

  String _generateRandomGuestId() {
    const uuid = Uuid();
    String guestInvitationCode = uuid.v4();
    guestInvitationCode =
        guestInvitationCode.substring(1, guestInvitationCode.indexOf("-"));
    return guestInvitationCode;
  }

  //this we check and return the list of agenda card that has a role and roleOrder place
  //but does not have a crossponding entry/record in the allocatedRolePlayers Collection
  // this is need to know what are the roles in the agenda that have not been assigned/allocated yet
  //it shall be called whenever we open alloacate role players and do any kind of operation.
  //it's mainly attached to the warning message in the allocate role players screen
  //it will also check whether the unallocated role has been announced or not
  Future<void> validateAllocationOfAllRoles(String chpaterMeetingId) async {
    setLoading(loading: true);

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
    //this is will search in the _agendaWithNoRolePlayersList list to remove all the
    //role that have been announced
    _agendaWithNoRolePlayersList.removeWhere(
      (agenda) => _listOfAnnouncedVolunteers.any((slot) =>
          slot.roleName == agenda.roleName &&
          slot.roleOrderPlace == agenda.roleOrderPlace),
    );
    setLoading(loading: false);
  }

  Future<void> deleteVolunteerSlot(
      {required String chapterMeetingId,
      required int slotUnqiueId,
      required String roleName,
      required int roleOrderPlace}) async {
    await _allocateRolePlayersService
        .deleteAnnouncedVolunteerSlot(
      chapterMeetingId: chapterMeetingId,
      roleName: roleName,
      roleOderPlace: roleOrderPlace,
      volunteerSlotId: slotUnqiueId,
    )
        .then(
      (value) {
        value.whenSuccess(
          (success) async {
            await validateAllocationOfAllRoles(chapterMeetingId);
          },
        );
      },
    );
  }

  // _volunteerSlotsApplicant

  Future<List<Toastmaster>> getSlotApplicants({
    required String chapterMeetingId,
    required int slotUnqiueId,
  }) async {
    await _allocateRolePlayersService
        .getListOfAllVolunteerSlotApplicants(
            chapterMeetingId: chapterMeetingId, volunteerSlotId: slotUnqiueId)
        .then(
      (value) {
        value.whenSuccess(
          (success) {
            _volunteerSlotsApplicant = success;
          },
        );
      },
    );
    return _volunteerSlotsApplicant;
  }

  Future<void> acceptSlotApplicant(
      {required String chapterMeetingId,
      required VolunteerSlot slot,
      required Toastmaster selectedApplicant}) async {
    SlotApplicant slotApplicant = SlotApplicant(
        acceptanceDate: DateTime.now().toString(),
        applicantStatus: ApplicantStatus.Accepted.name,
        toastmasterId: selectedApplicant.toastmasterId);

    AllocatedRolePlayer newAllocatedRolePlayer = AllocatedRolePlayer(
      roleName: slot.roleName,
      roleOrderPlace: super.getCorrectRoleOrderPlace(
          roleName: slot.roleName!, roleOrder: slot.roleOrderPlace!),
      rolePlayerName: selectedApplicant.toastmasterName,
      toastmasterId: selectedApplicant.toastmasterId,
      allocatedRolePlayerType: AllocatedRolePlayerType.Volunteer.name,
      toastmasterUsername: selectedApplicant.toastmasterUsername,
    );

    await _allocateRolePlayersService
        .acceptVolunteerSlotApplicant(
            chapterMeetingId: chapterMeetingId,
            volunteerSlotId: slot.slotUnqiueId!,
            slotApplicant: slotApplicant)
        .then(
      (value) {
        value.whenSuccess((_) async {
          await _allocateRolePlayersService.allocateNewRolePlayer(
              chapterMeetingId, newAllocatedRolePlayer, false);
        });
      },
    );
  }

  Future<Toastmaster> getAcceptedVolunteerDetails({
    required String chapterMeetingId,
    required int slotUnqiueId,
  }) async {
    Toastmaster applicantDetails = Toastmaster();
    await _allocateRolePlayersService
        .getAcceptedVolunteerDetails(
            chapterMeetingId: chapterMeetingId, volunteerSlotId: slotUnqiueId)
        .then(
      (value) {
        value.whenSuccess(
          (success) {
            applicantDetails = success;
          },
        );
        value.whenError((error) {});
      },
    );
    return applicantDetails;
  }
}
