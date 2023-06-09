import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:speaxpoint/models/slot_applicant.dart';
import 'package:speaxpoint/models/toastmaster.dart';

import '../../failure.dart';
import '../common_services/i_meeting_arrangement_common_services.dart';

abstract class IAllocateRolePlayersService
    extends IMeetingArrangementCommonServices {
  Future<Result<Unit, Failure>> deleteAllocatedRolePlayer(
      String chapterMeetingId, int allocatedRolePlayerUniqueId);

  Future<Result<Unit, Failure>> allocateNewRolePlayer(String chapterMeetingId,
      AllocatedRolePlayer allocatedRolePlayer, bool deteleVolunteerSlot);

  //return false if existed else true
  Future<Result<bool, Failure>> validateIfRoleIsTaken(
    String chapterMeetingId,
    String roleName,
    int memberRolePlace,
  );

  //there should be another method here to update an exiting role player if it's taken
  Future<Result<Unit, Failure>> updateOccupiedRoleDetails(
      String chapterMeetingId, AllocatedRolePlayer allocatedRolePlayer);

  Future<Result<Toastmaster, Failure>> searchOtherClubsMember(
      String toastmasterUsername);

  Future<Result<Unit, Failure>> deleteAnnouncedVolunteerSlot(
      {required String chapterMeetingId,
      required int volunteerSlotId,
      required String roleName,
      required int roleOderPlace});

  Future<Result<List<Toastmaster>, Failure>>
      getListOfAllVolunteerSlotApplicants({
    required String chapterMeetingId,
    required int volunteerSlotId,
  });
  Future<Result<Toastmaster, Failure>> getAcceptedVolunteerDetails({
    required String chapterMeetingId,
    required int volunteerSlotId,
  });

  Future<Result<Unit, Failure>> acceptVolunteerSlotApplicant({
    required String chapterMeetingId,
    required int volunteerSlotId,
    required SlotApplicant slotApplicant,
  });

//this API service is used to allow an app user to join the session from the annoucemenet of the chapter meeting
//from the Add To Schedule Button
  Future<Result<Unit, Failure>> allocateChapterMeetingVisitor({
    required String chapterMeetingId,
    required String clubId,
    required AllocatedRolePlayer allocatedRolePlayer,
  });
}
