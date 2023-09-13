import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/services/manage_club_members/i_manage_club_members_service.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class ClubMembersManagementViewModel extends BaseViewModel {
  final IManageClubMembersService _manageClubMembersService;

  Result<List<Toastmaster>, Failure>? _getMemberRequestSatus;
  List<Toastmaster> members = [];
  ClubMembersManagementViewModel(this._manageClubMembersService);

  Future<List<Toastmaster>> getAllMembersDetails() async {
    super.setLoading(loading:true);
    _getMemberRequestSatus =
        await _manageClubMembersService.getAllClubMembers();
    _getMemberRequestSatus?.whenSuccess((success) => members = success);
    super.setLoading(loading:false);
    return members;
  }
}
