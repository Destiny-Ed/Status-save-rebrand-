import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:video_saver/Screens/Whatsapp/Videos/video_state_management.dart';
import 'package:video_saver/Styles/colors.dart';

import 'Constants/instertitialAdsView.dart';
import 'Screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ///Initialize Google Ads
  MobileAds.instance.initialize();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => VideoProvider(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: MyColors()
                  .green, //Changing this will change the color of the TabBar
              accentColor: MyColors().accent,
              primaryColorDark: MyColors().dark),
        );
      },
    );
  }
}
