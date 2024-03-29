import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:thumbnails/thumbnails.dart';
import 'package:video_saver/Constants/adsView.dart';
import 'package:video_saver/Screens/Whatsapp/Videos/video_fetch.dart';
import 'package:video_saver/Screens/Whatsapp/Videos/video_items.dart';
import 'package:video_saver/Screens/Whatsapp/Videos/video_model.dart';
import 'package:video_saver/Screens/Whatsapp/Videos/video_state_management.dart';
import 'package:video_saver/Styles/colors.dart';
import 'package:video_saver/Utils/build_message_widget.dart';
import 'package:video_saver/Utils/page_router.dart';
import 'package:video_saver/Utils/shimmer_loader.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoHomePage extends StatefulWidget {
  String? path;

  VideoHomePage({this.path});

  @override
  _VideoHomePageState createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {
  // List<Map<String, dynamic>> data = []..reversed;

  // Uint8List? thumb;

  bool _fetched = false;

  @override
  void initState() {
    // print("This is the data $data");
    // FetchVideo().listofFiles().then((value) {
    //   setState(() {
    //     data.addAll(value);
    //   });
    // });
    super.initState();
  }

  Future<String> videoThumbNail(videoPathUrl) async {
    //await Future.delayed(Duration(milliseconds: 500));
    String thumb = await Thumbnails.getThumbnail(
        videoFile: videoPathUrl,
        imageType:
            ThumbFormat.PNG, //this image will store in created folderpath
        quality: 10);

    print("kfkdfdf $thumb");
    return thumb;
  }

  @override
  Widget build(BuildContext context) {
    ///Get video
    return Consumer<VideoProvider>(builder: (context, videoProvider, child) {
      if (_fetched == false) {
        videoProvider.fetchVideo();
        Future.delayed(const Duration(seconds: 2), () {
          _fetched = true;
        });
      }
      return Scaffold(
        body: videoProvider.getData.isEmpty
            ? Column(
                children: [
                  shimmerLoader(),
                ],
              )
            : videoProvider.getData.length < 1
                ? buildMessageWidget(() {
                    ///Launch whatsapp to view users status
                    try {
                      FlutterNativeApi.launchExternalApp("com.whatsapp");
                    } catch (_) {
                      FlutterNativeApi.launchExternalApp("com.whatsapp.wb4");
                    }
                  }, "View Video", "You have zero viewed status",
                    Icon(Icons.hourglass_empty_rounded), context)
                : Column(
                    children: [
                      // BannerAdsView(),
                      Expanded(
                        child: Container(
                          color: MyColors().green,
                          padding: const EdgeInsets.all(10.0),
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 12,
                            itemCount: videoProvider.getData.length,
                            itemBuilder: (context, index) {
                              // print(videoProvider.getData[index]);
                              final video =
                                  videoProvider.getData[index]["video_path"];
                              // final thumbnail =
                              //     videoProvider.getData[index]['thumbnail'];

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
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: MyColors().white),
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: FutureBuilder(
                                          future: videoThumbNail(video),
                                          builder: (context,
                                              AsyncSnapshot<String> snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              if (snapshot.hasData) {
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                  child: Image.file(
                                                      File(snapshot.data!),),
                                                );
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          }),
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
                              return StaggeredTile.count(
                                  1, index.isEven ? 1.2 : 1.8);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
      );
    });
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
