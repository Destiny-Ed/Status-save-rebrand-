import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:video_saver/Screens/Whatsapp/Videos/video_fetch.dart';
import 'package:video_saver/Screens/Whatsapp/Videos/video_items.dart';
import 'package:video_saver/Screens/Whatsapp/Videos/video_model.dart';
import 'package:video_saver/Styles/colors.dart';
import 'package:video_saver/Utils/build_message_widget.dart';
import 'package:video_saver/Utils/external_app_launcher.dart';
import 'package:video_saver/Utils/page_router.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoHomePage extends StatefulWidget {
  @override
  _VideoHomePageState createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {
  List<VideoModel> data = [];

  @override
  void initState() {
    print("This is the data $data");
    FetchVideo().listofFiles().then((value) {
      setState(() {
        data.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : data.length == 0
              ? buildMessageWidget(() {
                  ///Launch whatsapp to view users status
                  FlutterNativeAPI().launchExternalApp("com.whatsapp");
                }, "View Video", "You have zero viewed status",
                  Icon(Icons.hourglass_empty_rounded), context)
              : Container(
                  padding: const EdgeInsets.all(10.0),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final video = data[index].path;

                      final thumbNail = data[index].thumbnail;

                      ///Return Widget
                      return InkWell(
                        onTap: () {
                          PageRouter(ctx: context).nextPage(
                              page: VideoItems(
                            video: video,
                            autoplay: true,
                            looping: true,
                          ));
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: MyColors().green),
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                child: Image.memory(
                                  thumbNail!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            ///Show Play Icon on Video thumbnail
                            Container(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.play_circle_outline,
                                size: 35,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) {
                      return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                    },
                  ),
                ),
    );
  }

  Future<Uint8List> getThumbnail(String path) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );

    return uint8list!;
  }
}
