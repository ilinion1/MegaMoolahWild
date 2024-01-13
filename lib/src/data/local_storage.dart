import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences sharedPreferences;
  LocalStorage(this.sharedPreferences);

  Future<void> setSettings(
    bool sound,
    int level,
    DateTime dateTime,
    int money,
  ) async {
    await sharedPreferences.setBool('sound', sound);
    await sharedPreferences.setInt('level', level);

    // updated
    final dateTimeFilter = dateTime.toIso8601String();

    await sharedPreferences.setString('date_time', dateTimeFilter);
    await sharedPreferences.setInt('money', money);
  }

  Future<void> setLevel(int value) async {
    await sharedPreferences.setInt('level', value);
  }

  Future<void> setSound(bool sound) async {
    await sharedPreferences.setBool('sound', sound);
  }

  Future<void> setMoney(int money) async {
    print('Storage: setMoney $money');
    await sharedPreferences.setInt('money', money);
  }

  Future<void> setDateTime(DateTime dateTime) async {
    final dateTimeFilter = dateTime.toIso8601String();
    await sharedPreferences.setString('date_time', dateTimeFilter);
  }

  Map<String, dynamic> getSettings() {
    final sound = sharedPreferences.getBool('sound');
    final level = sharedPreferences.getInt('level');

    final dateTime = sharedPreferences.getString('date_time');
    final money = sharedPreferences.getInt('money');

    final dateTimeFilter = DateTime.parse(dateTime ?? "2012-02-27");

    return {
      'sound': sound,
      'level': level,
      'date_time': dateTimeFilter,
      'money': money,
    };
  }
}
