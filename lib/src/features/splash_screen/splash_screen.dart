

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../core/resources/color_manager.dart';
import '../dashboard/presentation/ui/dashboard.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen(
      backgroundColor: MyColors.lightBlue,
      splash: 'assets/images/logo.png',
      nextScreen: const Dashboard(),
      splashIconSize: 140,
      centered: true,
      curve: Curves.easeInOut,
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
      duration: 1000,
    );
  }
}