import 'package:shared_preferences/shared_preferences.dart';

class DataPreferences {
  static late SharedPreferences _preferences ;

  static Future init() async => 
      _preferences = await SharedPreferences.getInstance();

  static Future save(List<List<String>> data) async {
    var count = 0;
    data.forEach((element) async {
      await _preferences.setStringList(count.toString(), element);
      count ++;
    });
  }

  static List<List<String>> retrieveData() {
    List<List<String>> data = [];
    final keys = _preferences.getKeys();
    keys.forEach((element) {
      data.add(_preferences.getStringList(element));
    });
    return data;
  }
}