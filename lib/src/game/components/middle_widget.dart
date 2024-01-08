import 'package:flutter/material.dart';
import 'package:mega_moolah/src/common/widgets/custom_button.dart';
import 'package:mega_moolah/src/common/widgets/outline_text.dart';
import 'package:mega_moolah/src/controllers/settings_controller.dart';
import 'package:mega_moolah/src/game/components/levels/level1.dart';
import 'package:mega_moolah/src/game/components/levels/level2.dart';
import 'package:mega_moolah/src/game/components/levels/level3.dart';
import 'package:mega_moolah/src/game/game.dart';

class MiddleWidget extends StatelessWidget {
  const MiddleWidget({
    super.key,
    required this.status,
    required this.type,
    required this.cardFlips,
    required this.isDone,
    required this.success,
    required this.level,
    required this.onTryAgainPressed,
    required this.onItemPressed,
  });

  final GameStatus status;
  final List<int> type;
  final List<bool> cardFlips;
  final List<bool> isDone;
  final bool? success;
  final int level;
  final Function(int) onItemPressed;
  final Function() onTryAgainPressed;

  Widget playingWidget() {
    return switch (level) {
      1 => Level1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) => onItemPressed(itemIndex),
        ),
      2 => Level2(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) => onItemPressed(itemIndex),
        ),
      3 => Level3(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) => onItemPressed(itemIndex),
        ),
      _ => Level1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) => onItemPressed(itemIndex),
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      GameStatus.playing => playingWidget(),
      GameStatus.lose => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Column(
              children: [
                OutlinedText(
                  text: 'GAME OVER',
                  strokeWidth: 8,
                  textStyle: TextStyle(
                    fontSize: 48,
                  ),
                ),
                OutlinedText(
                  text: 'try your luck again!',
                  textStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CustomButton(
              onPressed: onTryAgainPressed,
              text: 'Try again',
            ),
            const SizedBox(height: 22),
          ],
        ),
      GameStatus.won => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const OutlinedText(
              text: 'Big win!',
              strokeWidth: 8,
              textStyle: TextStyle(
                fontSize: 48,
              ),
            ),
            const SizedBox(
              width: 236,
              child: OutlinedText(
                text: 'You managed to collect all the pairs!',
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            CustomButton(
              onPressed: () async {
                final model = SettingsProvider.read(context)!.model;
                model.setLevel(level % 3 + 1);
                await model.setSettings();
                onTryAgainPressed();
              },
              text: 'Next level',
            ),
            const SizedBox(height: 10),
            CustomButton(
              onPressed: onTryAgainPressed,
              text: 'Try again',
            ),
            const SizedBox(height: 22),
          ],
        ),
    };
  }
}
