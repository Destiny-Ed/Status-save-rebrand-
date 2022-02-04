import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_saver/Constants/adsView.dart';
import 'package:video_saver/Screens/Whatsapp/Images/image_view.dart';
import 'package:video_saver/Styles/colors.dart';
import 'package:video_saver/Utils/build_message_widget.dart';
import 'package:video_saver/Utils/getLocalPath.dart';
import 'package:video_saver/Utils/page_router.dart';

class ImageHomePage extends StatefulWidget {
  @override
  _ImageHomePageState createState() => _ImageHomePageState();
}

class _ImageHomePageState extends State<ImageHomePage> {
  //Declare Globally
  String? directory;
  List<FileSystemEntity> file = []..reversed;

  @override
  void initState() {
    super.initState();
    _listofFiles();
  }

  // Make New Function
  void _listofFiles() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      Permission.storage.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      directory = await GetLocalFilePath().getLocalPath(true).then((value) {
        if (mounted) {
          setState(() {
            file.addAll(value.listSync().where((element) =>
                element.path.endsWith(".jpg"))); //Add Files to fileList
          });
        }
      });
    } else {
      directory = await GetLocalFilePath().getLocalPath(true).then((value) {
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
          : file.length < 1
              ? buildMessageWidget(() {
                  ///Launch whatsapp to view users status
                  FlutterNativeApi.launchExternalApp("com.whatsapp");
                }, "View Image", "You have zero viewed status",
                  Icon(Icons.hourglass_empty_rounded), context)
              : Column(
                  children: [
                    BannerAdsView(),
                    Expanded(
                      child: Container(
                        color: MyColors().green,
                        padding: const EdgeInsets.all(10.0),
                        child: StaggeredGridView.countBuilder(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                          itemCount: file.length,
                          itemBuilder: (context, index) {
                            final image = file[index].path;

                            ///Return Widget
                            return InkWell(
                              onTap: () {
                                PageRouter(ctx: context).nextPage(
                                    page: ImageViewPage(
                                  index,
                                  file: file,
                                  tag: index.toString(),
                                  image: image,
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: MyColors().white),
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  child: Hero(
                                    tag: index.toString(),
                                    child: Image.file(
                                      File(image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          staggeredTileBuilder: (int index) {
                            return StaggeredTile.count(
                                1, index.isEven ? 1.2 : 1.8);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
