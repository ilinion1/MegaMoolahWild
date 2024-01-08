import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mega_moolah/src/common/app_images.dart';
import 'package:mega_moolah/src/common/widgets/custom_button.dart';
import 'package:mega_moolah/src/common/widgets/outline_text.dart';
import 'package:mega_moolah/src/controllers/settings_controller.dart';
import 'package:mega_moolah/src/game/components/middle_widget.dart';

enum GameStatus { won, lose, playing }

class MyGame extends StatefulWidget {
  const MyGame({
    super.key,
    required this.level,
  });

  final int level;

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  late int level;
  // comment
  String title = 'Click to start';

  // for check
  int selectedIndex = -1;
  bool? success;
  bool isPause = false;

  // score & lifes
  int score = 0;
  int life = 3;

  // status
  GameStatus status = GameStatus.playing;

  late List<int> type;
  void levelType() {
    type = switch (level) {
      1 => List.generate(4, (index) => index + 1),
      2 => List.generate(12, (index) => index + 1),
      3 => List.generate(13, (index) => index + 1),
      _ => List.generate(4, (index) => index + 1),
    };
  }

  // Card flipped or not
  late List<bool> cardFlips;
  void levelCardFlips() {
    cardFlips = switch (level) {
      1 => List.generate(8, (index) => false),
      2 => List.generate(24, (index) => false),
      3 => List.generate(36, (index) => false),
      _ => List.generate(8, (index) => false),
    };
  }

  // Card flipped & is done
  late List<bool> isDone;
  void levelIsDone() {
    isDone = switch (level) {
      1 => List.generate(8, (index) => false),
      2 => List.generate(24, (index) => false),
      3 => List.generate(36, (index) => false),
      _ => List.generate(8, (index) => false),
    };
  }

  @override
  void initState() {
    super.initState();
    level = widget.level;
    // levelType();
    // init level
    refreshLevel();
  }

  void refreshLevel() {
    levelType();
    levelCardFlips();
    levelIsDone();

    if (level == 3 && type.length <= 13) {
      extendSquare();
    }
    type
      ..addAll(List.from(type))
      ..shuffle();
    showCards();
  }

  void showCards() {
    isPause = true;
    setState(() {});
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      print('flip');
      cardFlips = switch (level) {
        1 => List.generate(8, (index) => true),
        2 => List.generate(24, (index) => true),
        3 => List.generate(36, (index) => true),
        _ => List.generate(8, (index) => true),
      };
      setState(() {});
    });
    setState(() {});
    Future.delayed(Duration(seconds: level + 1), () {
      if (!mounted) return;
      print('flip');
      isPause = false;

      levelCardFlips();
      setState(() {});
    });
  }

  void extendSquare() {
    final extendSquare = List.generate(13, (index) => index + 1);
    extendSquare.shuffle();
    type.addAll(extendSquare.sublist(0, 5));
  }

  // Game Status
  Future<void> isWon() async {
    if (isDone.where((element) => element == false).isNotEmpty) return;
    status = GameStatus.won;
    title = 'Congratulations!';
    setState(() {});
    final model = SettingsProvider.read(context)!.model;
    if (model.bestScore < score) await model.setScore(score);
  }

  Future<void> isLose() async {
    if (life > 0) return;
    status = GameStatus.lose;
    title = 'ooohh...';
    setState(() {});
    final model = SettingsProvider.read(context)!.model;
    if (model.bestScore < score) await model.setScore(score);
  }

  // Buttons pressed
  void onTryAgainPressed() {
    final model = SettingsProvider.read(context)!.model;
    if (model.sound) AudioPlayer().play(AssetSource('audio/sound.wav'));
    level = SettingsProvider.read(context)!.model.level;
    title = 'Click to start';
    selectedIndex = -1;
    success = false;
    isPause = false;
    score = 0;
    life = 3;
    status = GameStatus.playing;
    refreshLevel();
    setState(() {});
  }

  void onItemPressed(int itemIndex) {
    final model = SettingsProvider.read(context)!.model;
    if (model.sound) AudioPlayer().play(AssetSource('audio/sound.wav'));
    if (isPause || isDone[itemIndex] || selectedIndex == itemIndex) return;
    setState(() {
      cardFlips[itemIndex] = !cardFlips[itemIndex];
    });
    if (selectedIndex == -1) {
      // if item is not selected
      selectedIndex = itemIndex;
      success = null;
    } else if (type[selectedIndex] != type[itemIndex]) {
      // if items isn't same
      success = false;
      isPause = true;
      title = '-1 extra diamond';
      Future.delayed(const Duration(milliseconds: 500), () async {
        isPause = false;
        cardFlips[itemIndex] = false;
        cardFlips[selectedIndex] = false;
        selectedIndex = -1;
        life--;
        setState(() {});
        await isLose();
      });
    } else if (type[selectedIndex] == type[itemIndex]) {
      // if items is same
      final isDoneIndex = selectedIndex;
      selectedIndex = -1;
      success = true;
      isPause = true;
      title = '+30 points';
      score += 30;
      Future.delayed(const Duration(milliseconds: 500), () async {
        isPause = false;
        isDone[isDoneIndex] = true;
        isDone[itemIndex] = true;
        success = null;
        setState(() {});
        await isWon();
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.levelBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          toolbarHeight: 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedText(
                text: 'Score: $score',
                textStyle: TextStyle(
                  fontFamily: 'Luckiest Guy',
                  fontSize: 18.sp,
                ),
              ),
              Row(
                children: List.generate(
                  3,
                  (index) => Image.asset(
                    life >= (index + 1)
                        ? AppImages.diamond
                        : AppImages.diamondBack,
                    width: 36,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Image.asset(
                      AppImages.platform,
                      width: 332.w,
                      height: 216.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            AppImages.labelBack,
                            width: 110.w,
                            height: 36.h,
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0.h),
                            child: OutlinedText(
                              text: 'Level: $level',
                              textStyle: TextStyle(
                                fontFamily: 'Luckiest Guy',
                                fontSize: 18.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Luckiest Guy',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.h)
                    ],
                  ),
                ],
              ),
              MiddleWidget(
                status: status,
                type: type,
                cardFlips: cardFlips,
                isDone: isDone,
                success: success,
                level: level,
                onTryAgainPressed: onTryAgainPressed,
                onItemPressed: onItemPressed,
              ),
              CustomButton(
                onPressed: () => Navigator.pop(context),
                text: 'LOBBY',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
