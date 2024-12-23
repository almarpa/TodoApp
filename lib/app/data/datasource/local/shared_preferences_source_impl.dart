import 'package:shared_preferences/shared_preferences.dart';
import 'shared_preferences_source.dart';

class SharedPreferencesSourceImpl extends SharedPreferencesSource {
  @override
  Future<String?> getString(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }

  @override
  Future<bool> saveString(String name, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(name, value);
  }
}
