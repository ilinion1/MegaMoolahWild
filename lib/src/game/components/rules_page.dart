import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mega_moolah/src/common/app_colors.dart';
import 'package:mega_moolah/src/common/app_images.dart';
import 'package:mega_moolah/src/common/widgets/custom_app_bar.dart';
import 'package:mega_moolah/src/common/widgets/custom_button.dart';
import 'package:mega_moolah/src/common/widgets/money_widget.dart';
import 'package:mega_moolah/src/common/widgets/outline_text.dart';
import 'package:mega_moolah/src/game/components/card_widget.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background1),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox.shrink(),
            const CustomAppBar(text: 'Rules'),
            SizedBox(
              width: 275.w,
              child: Text(
                'You have to collect pairs of elements hidden under the cards',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
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
            SizedBox(
              width: 273.w,
              child: const Text(
                'You earn points for every successful combination',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const MoneyWidget(money: 20),
            SizedBox(
              width: 299.w,
              child: const Text(
                'If you fail, you lose your extra hearts. Their offering is limited. When they run out, the game is over',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
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
                  width: 46.w,
                  height: 40.h,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            // const Spacer(),
            CustomButton(
              onPressed: () => Navigator.pop(context),
              text: 'Lobby',
            ),
          ],
        ),
      ),
    );
  }
}
