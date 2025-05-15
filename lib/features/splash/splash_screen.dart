import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:provider_base1/common/color_constants.dart';
import 'package:provider_base1/common/routes/routes.dart';

import '../authentication/provider/auth_provider.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    /// Use a Timer to simulate the splash screen duration
    Timer(Duration(milliseconds: 1500), () {
      /// Check authentication status here
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.isAuthenticated) {
        /// If authenticated, go to the home screen
        context.go(Routes.base);
      } else {
        /// If not authenticated, go to the phone number screen
       // context.pushReplacement(Routes.phoneNumberScreen);
        context.go(Routes.base);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kBlueColor, // Set your desired background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add your app's logo or a simple text
            // Wrap the FlutterLogo with a Hero widget
            Hero(
              tag: 'flutter_logo_hero', // Unique tag for the animation
              child: SizedBox(height: 150 ,child: Lottie.asset('assets/lottie/lottie1.json')), // Replace with your logo if you have one
            //  child: FlutterLogo(size: 100), // Replace with your logo if you have one
            ),
          ],
        ),
      ),
    );
  }
}


