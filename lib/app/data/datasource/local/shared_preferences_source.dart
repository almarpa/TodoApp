abstract class SharedPreferencesSource {
  Future<String?> getString(String name);
  Future<void> saveString(String name, String value);
}
