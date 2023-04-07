import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/services/Failure.dart';

abstract class IManageClubMembersService {
  Future<Result<List<Toastmaster>, Failure>> getAllClubMembers();

  Future<Result<Unit, Failure>> registerNewMember(
      String email, String password, Toastmaster toastmaster);
  Future<Result<Unit, Failure>> updateMemberDetails(Toastmaster toastmaster);
   Future<Result<Toastmaster, Failure>> getToastmasterDetails(String toastmasterId);
}
