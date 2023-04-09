import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:speaxpoint/models/toastmaster.dart';

import '../../failure.dart';
import '../common_services/i_meeting_arrangement_common_services.dart';

abstract class IAllocateRolePlayersService
    extends IMeetingArrangementCommonServices {
  Future<Result<Unit, Failure>> deleteAllocatedRolePlayer(
      String chapterMeetingId, int allocatedRolePlayerUniqueId);
  Future<Result<Unit, Failure>> allocateNewRolePlayer(
      String chapterMeetingId, AllocatedRolePlayer allocatedRolePlayer);

  //return false if existed else true
  Future<Result<bool, Failure>> validateIfRoleIsTaken(
    String chapterMeetingId,
    String roleName,
    int memberRolePlace,
  );

  //there should be another method here to update an exiting role player if it's taken
  Future<Result<Unit, Failure>> updateOccupiedRoleDetails(
    String chapterMeetingId,
AllocatedRolePlayer allocatedRolePlayer
  );
   Future<Result<Toastmaster, Failure>> searchOtherClubsMember(String toastmasterUsername);

  //will search in the toastmasters collection and get the club member id if not existed then display error


}
