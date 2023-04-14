import 'dart:math';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/meeting_agenda.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_agenda/i_manage_meeting_agenda_service.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class PrepareMeetingAgendaViewModel extends BaseViewModel {
  final IManageMeetingAgendaService _manageMeetingAgendaService;

  Result<Unit, Failure>? _generatedListStatus;
  Result<Unit, Failure>? get getGeneratedListStatus => _generatedListStatus;

  Result<Unit, Failure>? _addingNewCardStatus;
  Result<Unit, Failure>? get addingNewCardStatus => _addingNewCardStatus;

  Result<Unit, Failure>? _deteteAgendaCardCardStatus;
  Result<Unit, Failure>? get deteteAgendaCardCardStatus =>
      _deteteAgendaCardCardStatus;

  Result<Unit, Failure>? _updateTimeSequenceStatus;
  Result<Unit, Failure>? get updateTimeSequenceStatus =>
      _updateTimeSequenceStatus;

  Result<Unit, Failure>? _updateAgendaCardStatus;
  Result<Unit, Failure>? get updateAgendaCardStatus => _updateAgendaCardStatus;

  //this list is always updated according to the stream,
  List<MeetingAgenda> _meetingAgendaList = [];
  List<MeetingAgenda> get meetingAgendaList => _meetingAgendaList;
  set meetingAgendaList(List<MeetingAgenda> agendaList) {
    _meetingAgendaList = agendaList;
  }

  PrepareMeetingAgendaViewModel(this._manageMeetingAgendaService);

  Future<void> generateListOfAgenda(
      String chapterMeetingId, int numberOfCards) async {
    _generatedListStatus = await _manageMeetingAgendaService
        .generateListOfEmptyAgendaCards(chapterMeetingId, numberOfCards);
  }

  Stream<List<MeetingAgenda>> getChapterMeetingAgenda(
          String chapterMeetingId) =>
      _manageMeetingAgendaService.getAllMeetingAgenda(chapterMeetingId);

  //this method will find the last and biggest AgendaCardOrder and return the value with +1
  int _getNewCardOrder() {
    int biggestAgendaCardNumber = -1;

    if (_meetingAgendaList.isNotEmpty) {
      return biggestAgendaCardNumber = _meetingAgendaList.fold(
            biggestAgendaCardNumber,
            (previousValue, element) =>
                max(previousValue, element.agendaCardOrder!),
          ) +
          1;
    } else {
      return biggestAgendaCardNumber += biggestAgendaCardNumber + 1;
    }
  }

  Future<void> addNewAgendaEmptyCard(String chapterMeetingId) async {
    setLoading(loading:true);
    _addingNewCardStatus = await _manageMeetingAgendaService
        .createEmptyAgendaCard(chapterMeetingId, _getNewCardOrder());
    setLoading(loading:false);
  }

  Future<void> deleteAgendaCard(
      String chapterMeetingId, int agendaCardNumber) async {
    setLoading(loading:true);
    _deteteAgendaCardCardStatus = await _manageMeetingAgendaService
        .deleteAgendaCard(chapterMeetingId, agendaCardNumber);
    setLoading(loading:false);
  }

  Future<void> updateTimeSequence({
    required String chapterMeetingId,
    required String timeSequence,
    required int agendaCardNumber,
  }) async {
    setLoading(loading:true);
    _updateTimeSequenceStatus = await _manageMeetingAgendaService
        .updateAgendaTime(chapterMeetingId, timeSequence, agendaCardNumber);
    setLoading(loading:false);
  }

  Future<void> updateAgendaCardDetails({
    required String chapterMeetingId,
    required String roleName,
    required String agendaCardTitle,
    required int agendaCardNumber,
    required int roleOrderPlace,
  }) async {
    setLoading(loading:true);
    _updateAgendaCardStatus =
        await _manageMeetingAgendaService.updateAgendaCardDetails(
      chapterMeetingId,
      MeetingAgenda(
        agendaCardOrder: agendaCardNumber,
        agendaTitle: agendaCardTitle,
        roleName: roleName,
        roleOrderPlace: roleOrderPlace,
      ),
    );
    setLoading(loading:false);
  }
}
