import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:video_saver/Styles/colors.dart';

class SavedHomePage extends StatefulWidget {
  @override
  _SavedHomePageState createState() => _SavedHomePageState();
}

class _SavedHomePageState extends State<SavedHomePage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabText.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50.0,
          bottom: TabBar(
            // indicatorColor: Colors.transparent,
            onTap: (int index) {
              setState(() {
                _selectedTab = index;
              });
            },
            tabs: List<Widget>.generate(
              _tabText.length,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  _tabText[index]!,
                ),
              ),
            ),
            // backgroundColor: MyColors().green,
          ),
        ),
      ),
    );
  }

  final List<String?> _tabText = ["Saved Images", "Saved Videos"];
}
