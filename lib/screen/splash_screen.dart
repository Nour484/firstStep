import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:learningfirebase/screen/login_screen.dart';
import 'package:learningfirebase/screen/signup_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/background_splash.jpg"),
          fit: BoxFit.cover,
        )),
        child: AnimatedSplashScreen(
          backgroundColor: Colors.transparent,
          splashIconSize: 150,
          //animationDuration: const Duration(seconds: 2),
          splashTransition: SplashTransition.scaleTransition,
          pageTransitionType: PageTransitionType.topToBottom,
          splash: "assets/images/splash_logo.png",
          nextScreen: SignUpScreen(),
        ),
      ),
      //  Image(image: AssetImage("assets/images/brand_image.png"))
    );
  }
}
