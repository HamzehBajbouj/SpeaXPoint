import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/annoucement/announcement.dart';
import 'package:speaxpoint/models/volunteer_slot.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/i_meeting_arrangement_common_services.dart';

abstract class IAskForVolunteersService
    extends IMeetingArrangementCommonServices {
  Future<Result<Unit, Failure>> announceForVolunteers(
      {required String chapterMeetingId,
      required List<VolunteerSlot> volunteerSlots,
      required Announcement announcement});

  Future<Result<List<VolunteerSlot>, Failure>> getVolunteersAnnouncedSlot(
      {required String chapterMeetingId,
      });
      
}
