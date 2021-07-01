import 'package:flutter/material.dart';

import 'audiomack.dart';
import 'boom_play.dart';

class MMusicHome extends StatefulWidget {
  @override
  _MMusicHomeState createState() => _MMusicHomeState();
}

class _MMusicHomeState extends State<MMusicHome> {
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
        body: TabBarView(children: [BoomHomePage(), AudioMarkHomePage()]),
      ),
    );
  }

  final List<String?> _tabText = ["Boom player music", "Audio mark Music"];
}
