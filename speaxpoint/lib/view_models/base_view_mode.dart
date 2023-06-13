import 'package:flutter/cupertino.dart';
import 'package:speaxpoint/app/service_locator.dart';
import 'package:speaxpoint/services/local_database/i_local_database_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/shared_preferences_keys.dart';

class BaseViewModel extends ChangeNotifier {
  final ILocalDataBaseService _localDataBaseService =
      serviceLocator<ILocalDataBaseService>();

  bool _loading = false;
  bool get loading => _loading;

  setLoading({bool loading = false}) {
    _loading = loading;
    notifyListeners();
  }

  /*
  this method is used to get the correct roleOrderPlace,
  because in case we have Ah counter it's better to assign it to 0 instead of 1 
  as we need to make sure that all the roles except speakers and speech evaluators
  can only be one role, currently we assign them 1, from the view/screens.
  and if we check the firestore we will find all the roles excepts speakers and speech evaluators.
  have the roleOrderPlace set to 1. but we need to change it to 0 in the viewModel.
  */
  int getCorrectRoleOrderPlace(
      {required int roleOrder, required String roleName}) {
    if (roleName == LisrOfRolesPlayers.Speaker.name ||
        roleName ==
            LisrOfRolesPlayers.Speach_Evaluator.name.replaceAll("_", " ")) {
      return roleOrder;
    } else {
      return 0;
    }
  }

  Future<String> getDataFromLocalDataBase({required String keySearch}) async {
    Map<String, dynamic> loggedUser =
        await _localDataBaseService.loadData(SharedPrefereneceKeys.loggedUser);
    return loggedUser[keySearch];
  }

  Future<void> clearLocalDatabase() async {
    await _localDataBaseService.clearLocalDatabase();
  }
}
