import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/meeting_agenda.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/i_meeting_arrangement_common_services.dart';

//since there are some functionlities that are need in the ManageMeetingAgenda screen
//that is related to rolePlayer allocation, we extended the IAllocateRolePlayersService
abstract class IManageMeetingAgendaService extends IMeetingArrangementCommonServices{
  Future<Result<Unit, Failure>> createEmptyAgendaCard(
      String chapterMeetingId, int agendaCardOrder);
  Future<Result<Unit, Failure>> generateListOfEmptyAgendaCards(
      String chapterMeetingId, int numberOfCards);

  Future<Result<Unit, Failure>> deleteAgendaCard(
      String chapterMeetingId, int agendaCardNumber);
        Future<Result<Unit, Failure>> updateAgendaTime(
      String chapterMeetingId, int agendaCardNumber);

  Stream<List<MeetingAgneda>> getAllMeetingAgenda(String chapterMeetingId);
}
