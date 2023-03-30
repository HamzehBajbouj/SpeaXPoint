import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/services/Failure.dart';

abstract class IManageComingSessionsService {
  Future<Result<Unit, Failure>> createNewSession(
      String sessionTitle, String sessionDate);

  // Future<Result<Stream<List<Task>>, Failure>> getAllComingSessions();
}
