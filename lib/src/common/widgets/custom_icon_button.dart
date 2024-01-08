import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mega_moolah/src/common/app_images.dart';
import 'package:mega_moolah/src/controllers/settings_controller.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final String icon;
  final Function()? onPressed;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (_) {
        final model = SettingsProvider.read(context)!.model;
        if (model.sound) AudioPlayer().play(AssetSource('audio/sound.wav'));
        isPressed = true;
        setState(() {});
        Future.delayed(const Duration(milliseconds: 150), () {
          isPressed = false;
          setState(() {});
        });
        if (widget.onPressed == null) return;
        widget.onPressed!();
      },
      onPanDown: (_) => setState(() {
        isPressed = true;
      }),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            isPressed ? AppImages.iconButtonPressed : AppImages.iconButton,
            width: 64,
            height: 64,
            fit: BoxFit.contain,
          ),
          Image.asset(
            widget.icon,
            width: 38,
            height: 38,
          ),
        ],
      ),
    );
  }
}
