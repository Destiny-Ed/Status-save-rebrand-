import 'package:flutter/material.dart';
import 'package:video_saver/Styles/colors.dart';

import 'Screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: MyColors()
              .green, //Changing this will change the color of the TabBar
          accentColor: MyColors().accent,
          primaryColorDark: MyColors().dark),
    );
  }
}
