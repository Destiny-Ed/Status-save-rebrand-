import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_saver/Constants/instertitialAdsView.dart';
import 'package:video_saver/Styles/colors.dart';
import 'package:video_saver/Utils/external_app_launcher.dart';

class VideoItems extends StatefulWidget {
  final String? video;
  final bool? looping;
  final bool? autoplay;

  VideoItems({
    this.video,
    this.looping,
    this.autoplay,
    Key? key,
  }) : super(key: key);

  @override
  _VideoItemsState createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.file(File(widget.video!)),
      aspectRatio: 5 / 8,
      autoInitialize: true,
      autoPlay: widget.autoplay!,
      looping: widget.looping!,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );

    loadInterstitialAd();
  }

  @override
  void dispose() {
    if (mounted) {
      _chewieController!.pause();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Chewie(
        controller: _chewieController!,
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 20.0, left: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: () async {
                ///Download Video to Local Directory
                ///
                await ImageGallerySaver.saveFile(widget.video!).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: MyColors().green,
                      content: Text(
                        "Video Saved Successfully",
                        style: TextStyle(color: MyColors().white),
                      ),
                    ),
                  );
                });
              },
              child: Icon(Icons.download_rounded),
            ),
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                FlutterNativeApi.shareVideo(widget.video);
              },
              child: Icon(Icons.share),
            ),
          ],
        ),
      ),
    );
  }
}
