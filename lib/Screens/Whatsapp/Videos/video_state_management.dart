import 'package:flutter/material.dart';
import 'package:video_saver/Screens/Whatsapp/Videos/video_fetch.dart';

class VideoProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _data = []..reversed;

  List<Map<String, dynamic>> get getData => _data;

  ///fetch video

  void fetchVideo() {
    FetchVideo().listofFiles().then((value) {
      _data = value;
      notifyListeners();
    });
  }
}
