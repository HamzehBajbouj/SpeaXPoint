import 'dart:convert';

import 'package:speaxpoint/services/local_database/i_local_database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataBaseSharedPreferencesService extends ILocalDataBaseService {
  @override
  Future<Map<String, dynamic>> loadData(String searchKey) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonDataString = prefs.getString(searchKey) ?? 'jj';
    if (jsonDataString.isNotEmpty) {
      Map<String, dynamic> data = jsonDecode(jsonDataString);
      return data;
    } else {
      return {};
    }
  }

  @override
  Future<void> saveData(String searchKey, String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(searchKey, data);
  }

  @override
  Future<void> clearLocalDatabase() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
