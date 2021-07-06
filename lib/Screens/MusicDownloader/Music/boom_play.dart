import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_saver/Constants/adsView.dart';
import 'package:video_saver/Constants/file_path.dart';
import 'package:video_saver/Screens/Whatsapp/Images/image_view.dart';
import 'package:video_saver/Styles/colors.dart';
import 'package:video_saver/Utils/build_message_widget.dart';
import 'package:video_saver/Utils/external_app_launcher.dart';
import 'package:video_saver/Utils/getLocalPath.dart';
import 'package:video_saver/Utils/page_router.dart';

class BoomHomePage extends StatefulWidget {
  @override
  _BoomHomePageState createState() => _BoomHomePageState();
}

class _BoomHomePageState extends State<BoomHomePage> {
  //Declare Globaly
  String? directory;
  List<FileSystemEntity> file = [];

  //Audio Player
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listofFiles();
  }

  playAudio(String path) async {
    await audioPlayer.setFilePath(
        "/storage/emulated/0/Boom Player/download/118902850/You Love Good - Phil.mp3");

    await audioPlayer.play();
  }

  // Make New Function
  void _listofFiles() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      Permission.storage.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      directory =
          await GetLocalFilePath().getBoomPlayPath("").then((firstPath) async {
        ///Fetch the first random folder
        final folderPath = firstPath.listSync();

        String randomFolder = folderPath[0].path.split("/").last;

        ///Get the Folder int path

        ///Fetch all the download musics
        directory = await GetLocalFilePath()
            .getBoomPlayPath("$randomFolder")
            .then((value) {
          if (mounted) {
            setState(() {
              file.addAll(value.listSync().where((element) =>
                  element.path.endsWith(".bp"))); //Add Files to fileList
            });
          }
        });
      });
    } else {
      directory =
          await GetLocalFilePath().getBoomPlayPath("").then((firstPath) async {
        ///Fetch the first random folder
        final folderPath = firstPath.listSync();

        String randomFolder = folderPath[0].path.split("/").last;

        ///Get the Folder int path

        ///Fetch all the download musics
        directory = await GetLocalFilePath()
            .getBoomPlayPath("$randomFolder")
            .then((value) {
          if (mounted) {
            setState(() {
              file.addAll(value.listSync().where((element) =>
                  element.path.endsWith(".bp"))); //Add Files to fileList
            });
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: file == []
            ? Center(
                child: CircularProgressIndicator(),
              )
            : file.length < 1
                ? buildMessageWidget(() {
                    ///Launch whatsapp to view users status
                    FlutterNativeAPI()
                        .launchExternalApp("com.afmobi.boomplayer");
                  }, "View boomplayer", "You have zero boom player music",
                    Icon(Icons.hourglass_empty_rounded), context)
                : Column(
                    children: [
                      BannerAdsView(),
                      Expanded(
                        child: ListView(
                          children: List.generate(file.length, (index) {
                            ///Music to play
                            final audioFile = file[index].path;

                            ///Music title to display
                            final music = file[index]
                                .path
                                .replaceAll(".bp", ".mp3")
                                .replaceRange(0, 51, "");
                            return Card(
                              elevation: 8.0,
                              shadowColor: MyColors().green,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ListTile(
                                  trailing: InkWell(
                                    onTap: () {
                                      ///Download music

                                      GetLocalFilePath()
                                          .moveFile(File(audioFile),
                                              "/storage/emulated/0/VideoSaver/$music")
                                          .then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor: MyColors().green,
                                          content: Text(
                                            "Music Saved to $value",
                                            style: TextStyle(
                                                color: MyColors().white),
                                          ),
                                        ));
                                      });
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: MyColors().green,
                                        child: Icon(Icons.download)),
                                  ),
                                  title: Text("$music"),
                                  // leading: InkWell(
                                  //   onTap: () {
                                  //     ///Play Audio
                                  //     playAudio(audioFile); //play audio
                                  //     print(audioFile);
                                  //   },
                                  //   child: CircleAvatar(
                                  //       backgroundColor: MyColors().green,
                                  //       child: Icon(Icons.play_circle_outline)),
                                  // ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ));
  }
}
