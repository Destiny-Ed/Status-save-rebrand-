import 'package:flutter/material.dart';
import 'package:video_saver/Screens/main_activity.dart';
import 'package:video_saver/Utils/page_router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        PageRouter(ctx: context).nextPageOnly(page: MainActivity());
      }
    });
    return Scaffold(
      body: Center(
          child: Image.asset(
        "assets/logo.png",
        width: 180,
        height: 180,
      )),
    );
  }
}
