import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mega_moolah/src/common/app_colors.dart';
import 'package:mega_moolah/src/common/app_images.dart';
import 'package:mega_moolah/src/common/widgets/custom_app_bar.dart';
import 'package:mega_moolah/src/common/widgets/custom_button.dart';
import 'package:mega_moolah/src/common/widgets/money_widget.dart';
import 'package:mega_moolah/src/common/widgets/outline_text.dart';
import 'package:mega_moolah/src/controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: const Color(0xFFA4CD00).withAlpha(70),
      border: Border.all(
        color: Colors.black,
        width: 2.w,
      ),
      borderRadius: BorderRadius.circular(30),
    );
    final model = SettingsProvider.watch(context).model;
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background1),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black45,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            children: [
              SizedBox(height: 47.h),
              const CustomAppBar(text: 'Settings'),
              SizedBox(height: 53.h),
              Container(
                height: 124,
                decoration: decoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Sound: ${model.sound ? 'on' : 'off'}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
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
                        await model.setSound(value);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                height: 178,
                width: double.infinity,
                decoration: decoration,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'You have:',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    MoneyWidget(
                      money: model.money,
                    )
                  ],
                ),
              ),
              const Spacer(),
              CustomButton(
                onPressed: () => Navigator.pop(context),
                text: 'Lobby',
              ),
              SizedBox(height: 64.h),
            ],
          ),
        ),
      ),
    );
  }
}
