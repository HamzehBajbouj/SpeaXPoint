//data will be stored in json string and retreived in json
abstract class ILocalDataBaseService {
  Future<void> saveData(String searchKey, String data);
  Future<Map<String, dynamic>> loadData(String searchKey);
  Future<void> clearLocalDatabase();
}