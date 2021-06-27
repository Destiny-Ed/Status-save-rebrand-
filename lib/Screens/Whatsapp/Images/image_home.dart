import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_saver/Styles/colors.dart';
import 'package:video_saver/Utils/build_message_widget.dart';
import 'package:video_saver/Utils/external_app_launcher.dart';
import 'package:video_saver/Utils/getLocalPath.dart';

class ImageHomePage extends StatefulWidget {
  @override
  _ImageHomePageState createState() => _ImageHomePageState();
}

class _ImageHomePageState extends State<ImageHomePage> {
  //Declare Globaly
  String? directory;
  List<FileSystemEntity> file = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listofFiles();
  }

  // Make New Function
  void _listofFiles() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      Permission.storage.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      directory = await GetLocalFilePath().getLocalPath().then((value) {
        if (mounted) {
          setState(() {
            file.addAll(value.listSync().where((element) =>
                element.path.endsWith(".jpg"))); //Add Files to fileList
          });
        }
      });
    } else {
      directory = await GetLocalFilePath().getLocalPath().then((value) {
        if (mounted) {
          setState(() {
            file.addAll(value.listSync().where((element) =>
                element.path.endsWith(".jpg"))); //Add Files to fileList
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: file.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : file.length == 0
              ? buildMessageWidget(() {
                  ///Launch whatsapp to view users status
                  FlutterNativeAPI().launchExternalApp("com.whatsapp");
                }, "View Image", "You have zero viewed status",
                  Icon(Icons.hourglass_empty_rounded), context)
              : Container(
                  padding: const EdgeInsets.all(10.0),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    itemCount: file.length,
                    itemBuilder: (context, index) {
                      final image = file[index].path;

                      ///Return Widget
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: MyColors().green),
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Image.file(
                            File(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) {
                      return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                    },
                  ),
                ),
      // : ListView(
      //     children: List.generate(
      //       file.length,
      //       (index) {
      //         final image = file[index].path;
      //
      //         //get extension : Only Show Images here
      //         final ext =
      //             image.contains(".mp4") || image.contains(".nomedia");
      //
      //         if (ext) {
      //           return Text("");
      //         }
      //         return Image.file(File(image));
      //       },
      //     ),
      //   ),
    );
  }
}
