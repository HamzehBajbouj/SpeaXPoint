import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/meeting_agenda.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/i_meeting_arrangement_common_services.dart';

//since there are some functionlities that are need in the ManageMeetingAgenda screen
//that is related to rolePlayer allocation, we extended the IAllocateRolePlayersService
abstract class IManageMeetingAgendaService
    extends IMeetingArrangementCommonServices {
  Future<Result<Unit, Failure>> createEmptyAgendaCard(
      String chapterMeetingId, int agendaCardOrder);

  Future<Result<Unit, Failure>> generateListOfEmptyAgendaCards(
      String chapterMeetingId, int numberOfCards);

  Future<Result<Unit, Failure>> deleteAgendaCard(
      String chapterMeetingId, int agendaCardNumber);

  Future<Result<Unit, Failure>> updateAgendaTime(
      String chapterMeetingId, String timeSequence, int agendaCardNumber);

  Future<Result<Unit, Failure>> updateAgendaCardDetails(
      String chapterMeetingId, MeetingAgenda agnedaCard);

//this is a stream , which is used in the UI widgets
  Stream<List<MeetingAgenda>> getAllMeetingAgenda(String chapterMeetingId);
  
//this one will return a list of all meeting agenda , it's used for validation purposes
   Future<Result<List<MeetingAgenda>, Failure>> getMeetingAgenda(String chapterMeetingId);
    //this method will return a list of all agenda cards that has a role (e.g.: Speaker 1)
  //where is role has not been allocated yet. 
  Future<Result<List<MeetingAgenda>, Failure>>
      getListOfAllAgendaWithNoAllocatedRolePlayers(String chapterMeetingId);
}
