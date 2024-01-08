import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mega_moolah/src/common/app_colors.dart';
import 'package:mega_moolah/src/common/app_images.dart';
import 'package:mega_moolah/src/common/widgets/custom_button.dart';
import 'package:mega_moolah/src/common/widgets/outline_text.dart';
import 'package:mega_moolah/src/controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: Colors.white54,
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(30),
    );
    final model = SettingsProvider.watch(context).model;
    return PopScope(
      canPop: true,
      onPopInvoked: (value) async => await model.setSettings(),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.levelBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox.shrink(),
                const OutlinedText(
                  text: 'Settings',
                  textStyle: TextStyle(
                    fontSize: 48,
                  ),
                ),
                Container(
                  height: 124,
                  decoration: decoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedText(
                        text: 'Sound: ${model.sound ? 'on' : 'off'}',
                        textStyle: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Switch(
                        inactiveTrackColor: Colors.white,
                        inactiveThumbColor: AppColors.secondaryColor,
                        activeTrackColor: AppColors.mainColor,
                        activeColor: Colors.lightGreenAccent,
                        trackOutlineColor: const MaterialStatePropertyAll(
                          AppColors.secondaryColor,
                        ),
                        value: model.sound,
                        onChanged: (value) async {
                          model.setSound(value);
                          await model.toggleAudio();
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 178,
                  decoration: decoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const OutlinedText(
                        text: 'Complexity',
                        textStyle: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: (model.level > 1)
                                ? () {
                                    final model =
                                        SettingsProvider.read(context)!.model;
                                    if (model.sound) {
                                      AudioPlayer()
                                          .play(AssetSource('audio/sound.wav'));
                                    }
                                    model.setLevel(model.level - 1);
                                  }
                                : null,
                            icon: Image.asset(
                              AppImages.leftArrow,
                              width: 33,
                              height: 57,
                              fit: BoxFit.contain,
                            ),
                          ),
                          OutlinedText(
                            text: 'Level${model.level}',
                            strokeWidth: 8,
                            textStyle: const TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          IconButton(
                            onPressed: (model.level < 3)
                                ? () {
                                    final model =
                                        SettingsProvider.read(context)!.model;
                                    if (model.sound) {
                                      AudioPlayer()
                                          .play(AssetSource('audio/sound.wav'));
                                    }
                                    model.setLevel(model.level + 1);
                                  }
                                : null,
                            icon: Image.asset(
                              AppImages.rightArrow,
                              width: 33,
                              height: 57,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: decoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const OutlinedText(
                        text: 'Best score',
                        textStyle: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      OutlinedText(
                        text: '${model.bestScore}',
                        textStyle: const TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  onPressed: () async {
                    await model.setSettings();
                    if (context.mounted) Navigator.pop(context);
                  },
                  text: 'lobby',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
