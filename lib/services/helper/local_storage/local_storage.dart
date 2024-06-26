import 'package:shared_preferences/shared_preferences.dart';

/// LocalStorage
///
/// In this class, we write  the functions needed to store and get data
/// from the local storage using the plugin
class LocalStorage {
  Future writeUserToken(String value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString("userToken", value);
  }

  Future<dynamic> readUserToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var storedData = storage.getString("userToken");
    return storedData;
  }

  Future write(String name, dynamic value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString(name, value);
  }

  Future<dynamic> read(String name) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var storedData = storage.getString(name);
    return storedData;
  }

  clearAllData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.clear();
  }
}
