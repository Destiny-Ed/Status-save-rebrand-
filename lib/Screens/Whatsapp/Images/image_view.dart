import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:video_saver/Styles/colors.dart';
import 'package:video_saver/Utils/external_app_launcher.dart';
import 'package:video_saver/Utils/getLocalPath.dart';

class ImageViewPage extends StatefulWidget {
  ImageViewPage({this.tag, this.image});

  String? image;
  String? tag;

  @override
  _ImageViewPageState createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: widget.tag!,
          child: Image.file(
            File(widget.image!),
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
                await ImageGallerySaver.saveFile(widget.image!).then((value) {
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
                FlutterNativeAPI().printImage(widget.image!, widget.image!);
              },
              child: Icon(Icons.print),
            ),
            FloatingActionButton(
              tooltip: "Share Image",
              heroTag: "btn3",
              onPressed: () {
                ///Share Image to any Sharable Application
                FlutterNativeAPI().shareImage(widget.image!);
              },
              child: Icon(Icons.share),
            ),
          ],
        ),
      ),
    );
  }
}
