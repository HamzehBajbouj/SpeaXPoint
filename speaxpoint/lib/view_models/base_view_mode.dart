import 'package:flutter/cupertino.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';

class BaseViewModel extends ChangeNotifier {
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
}
