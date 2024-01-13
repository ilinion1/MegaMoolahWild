import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      2 => Level1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      3 => Level1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      4 => Level1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      5 => Level3(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      6 => Level3(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      _ => Level1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
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
                Text(
                  'Game over',
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Try your luck again!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CustomButton(
              onPressed: onTryAgainPressed,
              text: 'Restart',
            ),
            const SizedBox(height: 22),
          ],
        ),
      GameStatus.won => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Big win!',
              style: TextStyle(
                fontSize: 48.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: 256.w,
              child: Text(
                'You managed to collect all the pairs!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              text: 'Next level',
            ),
            const SizedBox(height: 10),
            CustomButton(
              onPressed: onTryAgainPressed,
              text: 'Restart',
            ),
            const SizedBox(height: 22),
          ],
        ),
    };
  }
}
