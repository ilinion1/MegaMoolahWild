import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mega_moolah/src/data/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends ChangeNotifier {
  bool sound = false;
  int level = 1;
  int bestScore = 0;

  Future<void> initSettings() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = LocalStorage(sharedPreferences);
    Map<String, dynamic> data = storage.getSettings();
    if (data['sound'] == null ||
        data['level'] == null ||
        data['score'] == null) {
      await storage.setSettings(sound, level, bestScore);
      data = storage.getSettings();
    }
    print(data);
    sound = data['sound'];
    level = data['level'];
    bestScore = data['score'];
    notifyListeners();
    await toggleAudio();
  }

  void setSound(bool value) {
    sound = value;
    notifyListeners();
  }

  void setLevel(int value) {
    level = value;
    notifyListeners();
  }

  Future<void> setScore(int value) async {
    bestScore = value;
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = LocalStorage(sharedPreferences);
    await storage.setScore(value);
    notifyListeners();
  }

  Future<void> setSettings() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = LocalStorage(sharedPreferences);
    await storage.setSettings(sound, level, bestScore);
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