import 'dart:developer';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/services/meeting_arrangement/allocate_role_players/i_allocate_role_players_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class AllocateRolePlayersViewModel extends BaseViewModel {
  final IAllocateRolePlayersService _allocateRolePlayersService;

  Result<Unit, Failure>? _updateRoleStatus;
  Result<Unit, Failure>? get updateRoleStatus => _updateRoleStatus;

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
    return await _allocateRolePlayersService.validateIfRoleIsTaken(
        chapterMeetingId, roleName, memberRolePlace);
  }

  Future<Result<Unit, Failure>> allocateNewPlayerFromTheClub(
    String chapterMeetingId,
    Toastmaster toastmaster,
    String roleName,
    int memberRolePlace,
  ) async {
    return await _allocateRolePlayersService.allocateClubMemberNewRolePlayer(
      chapterMeetingId,
      AllocatedRolePlayer(
        roleName: roleName,
        rolePlayerOrderPlace: memberRolePlace,
        rolePlayerName: toastmaster.toastmasterName,
        toastmasterId: toastmaster.toastmasterId,
        allocatedRolePlayerType: AllocatedRolePlayerType.ClubMember.name,
        toastmasterUsername: toastmaster.toastmasterUsername,
      ),
    );
  }

  Future<void> updateExitngRoleDetails(
    String chapterMeetingId,
    String roleName,
    int memberRolePlace,
    Toastmaster toastmaster,
  ) async {
    super.setLoading(true);
    _updateRoleStatus =
        await _allocateRolePlayersService.updateOccupiedRoleDetails(
      chapterMeetingId,
      AllocatedRolePlayer(
        roleName: roleName,
        rolePlayerOrderPlace: memberRolePlace,
        rolePlayerName: toastmaster.toastmasterName,
        toastmasterId: toastmaster.toastmasterId,
        allocatedRolePlayerType: AllocatedRolePlayerType.ClubMember.name,
        toastmasterUsername: toastmaster.toastmasterUsername,
      ),
    );
    super.setLoading(false);
  }

  Stream<List<AllocatedRolePlayer>> getAllocatedRolePlayers(
          String chapterMeetingId) =>
      _allocateRolePlayersService.getAllAllocatedRolePlayers(chapterMeetingId);
}
