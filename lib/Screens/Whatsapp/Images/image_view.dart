import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:video_saver/Constants/ads_helper.dart';
import 'package:video_saver/Constants/instertitialAdsView.dart';
import 'package:video_saver/Styles/colors.dart';
import 'package:video_saver/Utils/getLocalPath.dart';

class ImageViewPage extends StatefulWidget {
  ImageViewPage(this.index, {this.file, this.tag, this.image});

  int? index;
  List<FileSystemEntity>? file;
  String? image;
  String? tag;

  @override
  _ImageViewPageState createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  PageController? _controller;

  int? currentIndex;

  @override
  void initState() {
    _controller = PageController(initialPage: widget.index!)
      ..addListener(() {
        setState(() {
          currentIndex = _controller!.page!.toInt();
          // print(currentIndex);
        });
      });

    loadInterstitialAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Return Body Widget Here
    return Scaffold(
      body: Center(
        child: Hero(
          tag: widget.tag!,
          // child: Image.file(
          //   File(widget.image!),
          // ),
          child: PageView(
            controller: _controller,
            children: List.generate(
              widget.file!.length,
              (index) => Image.file(
                File(widget.file![index].path),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () async {
                ///Download Image to Local Directory
                ///
                await ImageGallerySaver.saveFile(
                        widget.file![_controller!.page!.toInt()].path)
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: MyColors().green,
                      content: Text(
                        "Image Saved Successfully",
                        style: TextStyle(color: MyColors().white),
                      ),
                    ),
                  );
                });
              },
              tooltip: "Download Image",
              heroTag: "btn1",
              child: Icon(Icons.download_rounded),
            ),
            FloatingActionButton(
              tooltip: "Print Image",
              heroTag: "btn2",
              onPressed: () {
                ///Show the android print manager API

                FlutterNativeApi.printImage(
                    widget.file![_controller!.page!.toInt()].path,
                    widget.file![_controller!.page!.toInt()].path);
              },
              child: Icon(Icons.print),
            ),
            FloatingActionButton(
              tooltip: "Share Image",
              heroTag: "btn3",
              onPressed: () {
                ///Share Image to any Sharable Application
                FlutterNativeApi
                    .shareMultiple(widget.file![_controller!.page!.toInt()].path, "From Destiny Ed");
              },
              child: Icon(Icons.share),
            ),
          ],
        ),
      ),
    );
  }
}
