import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:video_saver/Styles/colors.dart';
import 'BottomNavPages/wSaver.dart';
import 'MusicDownloader/Music/music_home_page.dart';

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors().green,
        title: Text("Downloader"),
        elevation: 0,
      ),
      body: _buildBody[_currentIndex],
      bottomNavigationBar: GNav(
        tabs: _tabs,
        activeColor: MyColors().green,
        selectedIndex: _currentIndex,
        color: Colors.grey[700],
        onTabChange: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  final List<Widget> _buildBody = [
    WSaverHome(),
    MMusicHome(), //NewsFeed
    WSaverHome(), //Settings
  ];

  final List<GButton> _tabs = [
    GButton(
      icon: Icons.save_alt,
      gap: 5.0,
      text: "Wsaver",
    ),
    GButton(
      icon: Icons.my_library_music,
      gap: 5.0,
      text: "MSaver",
    ),
    GButton(
      icon: Icons.settings,
      gap: 5.0,
      text: "Settings",
    ),
  ];
}
