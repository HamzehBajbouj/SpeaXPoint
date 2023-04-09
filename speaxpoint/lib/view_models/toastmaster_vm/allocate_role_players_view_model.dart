import 'dart:developer';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/services/meeting_arrangement/allocate_role_players/i_allocate_role_players_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';
import 'package:uuid/uuid.dart';

class AllocateRolePlayersViewModel extends BaseViewModel {
  final IAllocateRolePlayersService _allocateRolePlayersService;

  Result<Unit, Failure>? _updateRoleStatus;
  Result<Unit, Failure>? get updateRoleStatus => _updateRoleStatus;

  Result<Unit, Failure>? _updateGuestRoleStatus;
  Result<Unit, Failure>? get updateGuestRoleStatus => _updateGuestRoleStatus;

  Result<Toastmaster, Failure>? _searchToastmasterUsername;
  Result<Toastmaster, Failure>? get searchToastmasterUsername =>
      _searchToastmasterUsername;

  //we make it true to hide the warning message in the begining
  bool toastmasterUsernameIsfound = true;

  AllocateRolePlayersViewModel(this._allocateRolePlayersService);

  Future<void> deleteRolePlayerCard(
      String chapterMeetingId, int allocatedRolePlayerUniqueId) async {
    setLoading(true);
    await _allocateRolePlayersService.deleteAllocatedRolePlayer(
        chapterMeetingId, allocatedRolePlayerUniqueId);
    setLoading(false);
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
    print("dsdsdsfsd 22222");
    return await _allocateRolePlayersService.validateIfRoleIsTaken(
        chapterMeetingId, roleName, memberRolePlace);
  }

  Future<Result<Unit, Failure>> allocateNewPlayerFromClub(
      String chapterMeetingId,
      Toastmaster toastmaster,
      String roleName,
      int memberRolePlace,
      String allocatedRolePlayerType) async {
    return await _allocateRolePlayersService.allocateNewRolePlayer(
      chapterMeetingId,
      AllocatedRolePlayer(
        roleName: roleName,
        roleOrderPlace: memberRolePlace,
        rolePlayerName: toastmaster.toastmasterName,
        toastmasterId: toastmaster.toastmasterId,
        allocatedRolePlayerType: allocatedRolePlayerType,
        toastmasterUsername: toastmaster.toastmasterUsername,
      ),
    );
  }

  Future<Result<Unit, Failure>> allocateGuestRolePlayer(
      {required String chapterMeetingId,
      required String guestName,
      required String roleName,
      required int memberRolePlace,
      required String allocatedRolePlayerType}) async {
    //generate random guestInvitationCode, start from the second letter, so we don't get
    //the same code as the chapter meeting inivtation code

    return await _allocateRolePlayersService.allocateNewRolePlayer(
      chapterMeetingId,
      AllocatedRolePlayer(
        guestInvitationCode: _generateRandomGuestId(),
        roleName: roleName,
        roleOrderPlace: memberRolePlace,
        rolePlayerName: guestName,
        allocatedRolePlayerType: allocatedRolePlayerType,
      ),
    );
  }

  Future<void> updateExitngRoleDetails(
    String chapterMeetingId,
    String roleName,
    int memberRolePlace,
    Toastmaster? toastmaster,
    String allocatedRolePlayerType,
  ) async {
    super.setLoading(true);
    _updateRoleStatus =
        await _allocateRolePlayersService.updateOccupiedRoleDetails(
      chapterMeetingId,
      AllocatedRolePlayer(
        roleName: roleName,
        roleOrderPlace: memberRolePlace,
        rolePlayerName: toastmaster?.toastmasterName,
        toastmasterId: toastmaster?.toastmasterId,
        allocatedRolePlayerType: allocatedRolePlayerType,
        toastmasterUsername: toastmaster?.toastmasterUsername,
      ),
    );
    super.setLoading(false);
  }

  Future<void> updateExitngGuestRoleDetails({
    required String chapterMeetingId,
    required String roleName,
    required int memberRolePlace,
    required String? guestName,
    required String allocatedRolePlayerType,
  }) async {
    super.setLoading(true);
    _updateGuestRoleStatus =
        await _allocateRolePlayersService.updateOccupiedRoleDetails(
      chapterMeetingId,
      AllocatedRolePlayer(
        roleName: roleName,
        roleOrderPlace: memberRolePlace,
        rolePlayerName: guestName,
        toastmasterId: null,
        allocatedRolePlayerType: allocatedRolePlayerType,
        toastmasterUsername: null,
        guestInvitationCode: _generateRandomGuestId(),
      ),
    );
    super.setLoading(false);
  }

  Stream<List<AllocatedRolePlayer>> getAllocatedRolePlayers(
          String chapterMeetingId) =>
      _allocateRolePlayersService.getAllAllocatedRolePlayers(chapterMeetingId);

  Future<void> searchForToastmasterUsername(
      {required String toastmasterUsername}) async {
    super.setLoading(true);
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
    super.setLoading(false);
  }

  String _generateRandomGuestId() {
    const uuid = Uuid();
    String guestInvitationCode = uuid.v4();
    guestInvitationCode =
        guestInvitationCode.substring(1, guestInvitationCode.indexOf("-"));
    return guestInvitationCode;
  }
}
