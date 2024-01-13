import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mega_moolah/src/data/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends ChangeNotifier {
  bool sound = false;
  int level = 1;

  // updates
  int money = 0;
  DateTime dateTime = DateTime.parse("2012-02-27");

  Future<void> setMoney(int amount) async {
    print('setting money');
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = LocalStorage(sharedPreferences);
    money += amount;
    print(money);
    notifyListeners();
    await storage.setMoney(money);
  }

  Future<void> setDateTime() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = LocalStorage(sharedPreferences);
    dateTime = DateTime.now();
    notifyListeners();
    await storage.setDateTime(dateTime);
  }

  Future<void> initSettings() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = LocalStorage(sharedPreferences);
    Map<String, dynamic> data = storage.getSettings();
    if (data['sound'] == null || data['level'] == null) {
      await storage.setSettings(
        sound,
        level,
        dateTime,
        money,
      );
      data = storage.getSettings();
    }
    print(data);
    sound = data['sound'];
    level = data['level'];
    money = data['money'];
    dateTime = data['date_time'];
    notifyListeners();
    await toggleAudio();
  }

  Future<void> setSound(bool value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = LocalStorage(sharedPreferences);
    sound = value;
    notifyListeners();
    await toggleAudio();
    await storage.setSound(sound);
  }

  Future<void> setLevel(int value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = LocalStorage(sharedPreferences);
    level = value;
    notifyListeners();
    await storage.setLevel(value);
  }

  // Audio Section
  final player = AudioPlayer();

  Future<void> toggleAudio() async {
    if (sound) {
      await playAudio();
    } else {
      await stopAudio();
    }
  }

  Future<void> playAudio() async {
    print('play audio');
    if (player.state == PlayerState.playing) return;
    await player.play(AssetSource('audio/music.mp3'), volume: 0.3);
    player.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> stopAudio() async {
    await player.pause();
  }
}

class SettingsProvider extends InheritedNotifier {
  final SettingsController model;

  const SettingsProvider({
    super.key,
    required super.child,
    required this.model,
  }) : super(
          notifier: model,
        );

  static SettingsProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<SettingsProvider>()
        ?.widget;
    return (widget is SettingsProvider) ? widget : null;
  }

  static SettingsProvider watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SettingsProvider>()!;
  }
}
