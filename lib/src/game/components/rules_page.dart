import 'package:flutter/material.dart';
import 'package:mega_moolah/src/common/app_colors.dart';
import 'package:mega_moolah/src/common/app_images.dart';
import 'package:mega_moolah/src/common/widgets/custom_button.dart';
import 'package:mega_moolah/src/common/widgets/outline_text.dart';
import 'package:mega_moolah/src/game/components/card_widget.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox.shrink(),
            const OutlinedText(
              text: 'rules',
              textStyle: TextStyle(
                fontSize: 48,
              ),
            ),
            const SizedBox(
              width: 236,
              child: OutlinedText(
                text:
                    'You have to collect pairs of elements hidden under the cards',
                textStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardWidget(
                  value: 13,
                  isFlipped: true,
                  onPressed: () {},
                  color: AppColors.mainColor,
                  isDone: false,
                ),
                const SizedBox(width: 8),
                CardWidget(
                  value: 13,
                  isFlipped: true,
                  onPressed: () {},
                  color: AppColors.mainColor,
                  isDone: false,
                ),
              ],
            ),
            const SizedBox(
              width: 278,
              child: OutlinedText(
                text: 'You earn points for every successful combination',
                textStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const OutlinedText(
              text: 'Score: 10',
              textStyle: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              width: 302,
              child: OutlinedText(
                text:
                    'If you fail, you lose your extra hearts. Their offering is limited. When they run out, the game is over',
                textStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.diamond,
                  width: 46,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 3),
                Image.asset(
                  AppImages.diamond,
                  width: 46,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 3),
                Image.asset(
                  AppImages.diamond,
                  width: 46,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            // const Spacer(),
            CustomButton(
              onPressed: () => Navigator.pop(context),
              text: 'lobby',
            ),
          ],
        ),
      ),
    );
  }
}
