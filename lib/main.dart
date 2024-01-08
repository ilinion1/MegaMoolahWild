import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mega_moolah/src/common/app_colors.dart';
import 'package:mega_moolah/src/common/app_images.dart';
import 'package:mega_moolah/src/common/widgets/custom_button.dart';
import 'package:mega_moolah/src/common/widgets/custom_icon_button.dart';
import 'package:mega_moolah/src/controllers/settings_controller.dart';
import 'package:mega_moolah/src/game/components/rules_page.dart';
import 'package:mega_moolah/src/game/components/settings_page.dart';
import 'package:mega_moolah/src/game/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyAnimatedProgressBar(),
        // home: SettingsProvider(
        //   model: SettingsController()..initSettings(),
        //   child: const InitAudio(child: MainPage()),
        // ),
      ),
    );
  }
}

class MyAnimatedProgressBar extends StatefulWidget {
  @override
  _MyAnimatedProgressBarState createState() => _MyAnimatedProgressBarState();
}

class _MyAnimatedProgressBarState extends State<MyAnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener(splashListener);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  void splashListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SettingsProvider(
            model: SettingsController()..initSettings(),
            child: const InitAudio(child: MainPage()),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.splash),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 80.h),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.orange,
                              Colors.deepOrange.shade400,
                            ],
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: SizedBox(
                            width: double.infinity,
                            height: 30.h,
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.green.shade100,
                              color: Color.lerp(
                                Colors.greenAccent.shade100,
                                Colors.green.shade700,
                                _animation.value,
                              ),
                              value: _animation.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeStatusListener(splashListener);
    _controller.dispose();
    super.dispose();
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = SettingsProvider.watch(context).model;
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.splash),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomIconButton(
                    icon: AppImages.settings,
                    onPressed: () {
                      return Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SettingsProvider(
                            model: model,
                            child: const SettingsPage(),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 22),
                ],
              ),
              const SizedBox(height: 165),
              CustomButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingsProvider(
                      model: model,
                      child: MyGame(level: model.level),
                    ),
                  ),
                ),
                text: 'New Game',
              ),
              const SizedBox(height: 25),
              CustomButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RulesPage(),
                  ),
                ),
                text: 'Rules',
              ),
              const SizedBox(height: 108),
            ],
          ),
        ),
      ),
    );
  }
}

class InitAudio extends StatefulWidget {
  const InitAudio({super.key, required this.child});

  final Widget child;

  @override
  State<InitAudio> createState() => InitAudioState();
}

class InitAudioState extends State<InitAudio> with WidgetsBindingObserver {
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (AppLifecycleState.paused == state) {
      final model = SettingsProvider.read(context)!.model;
      await model.stopAudio();
    } else if (AppLifecycleState.resumed == state) {
      if (SettingsProvider.read(context)!.model.sound) {
        final model = SettingsProvider.read(context)!.model;
        if (model.sound) {
          await model.playAudio();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // print('disposed');
    // player.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Future<void> initialize() async {
  //   final sound = SettingsProvider.read(context)!.model.sound;
  //   print(sound);
  //   if (sound) {
  //     await playAudio();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) async {
        final model = SettingsProvider.read(context)!.model;
        await model.stopAudio();
      },
      child: widget.child,
    );
  }
}
