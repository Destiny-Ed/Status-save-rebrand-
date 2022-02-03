import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_saver/Screens/Whatsapp/Images/image_home.dart';
import 'package:video_saver/Screens/Whatsapp/Stickers/sticker_home_page.dart';
import 'package:video_saver/Screens/Whatsapp/Videos/video_home_page.dart';
import 'package:video_saver/Styles/colors.dart';

class WSaverHome extends StatefulWidget {
  @override
  _WSaverHomeState createState() => _WSaverHomeState();
}

class _WSaverHomeState extends State<WSaverHome>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: _tabText.length, vsync: this);

    _tabController!.addListener(() {
      setState(() {
        _currentIndex = _tabController!.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // shadowColor: MyColors().white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 10.0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          tabs: List<Widget>.generate(
            _tabText.length,
            (index) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: _currentIndex == index
                      ? MyColors().grey
                      : MyColors().green),
              child: Text(
                _tabText[index]!,
                style: TextStyle(
                    color: _currentIndex == index
                        ? MyColors().green
                        : MyColors().white),
              ),
            ),
          ),
          // backgroundColor: MyColors().green,
        ),
      ),
      body: TabBarView(controller: _tabController, children: _tabBody),
    );
  }

  final List<Widget> _tabBody = [
    ImageHomePage(),
    VideoHomePage(path: "Hello"),
    StickerHomePage(),
  ];

  final List<String?> _tabText = ["Images", "Videos", "Stickers"];
}
