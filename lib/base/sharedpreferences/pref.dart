import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  addIntToSF({required String key, required int value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  addBoolToSF({required String key, required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  addStringToSF({required String key, required String? value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value!);
  }

  Future<String?> getStringValuesSF({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(key);
    if (stringValue == null) {
      stringValue = null;
    }
    return stringValue;
  }

  Future<bool?> getBoolValuesSF({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool? boolValue = prefs.getBool(key);
    if (boolValue == null) {
      boolValue = false;
    }
    return boolValue;
  }

  Future<int?> getIntValuesSF({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int? intValue = prefs.getInt(key);
    if (intValue == null) {
      intValue = 0;
    }
    return intValue;
  }
}
