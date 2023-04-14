import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  setLoading({bool loading = false}) {
    _loading = loading;
    notifyListeners();
  }
}
