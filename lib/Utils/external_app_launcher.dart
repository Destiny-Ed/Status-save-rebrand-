import 'package:flutter/services.dart';

class FlutterNativeAPI {
  static const platform = const MethodChannel('com.nativeAPI');

  void launchExternalApp(String? appPackageName) async {
    try {
      final int result = await platform
          .invokeMethod('showWhatsApp', {"appPackage": appPackageName});
      print(result);
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'.");
    }
  }

  void printImage(String? image, String? imageTitle) async {
    try {
      final int result = await platform
          .invokeMethod('printImage', {"image": image, "title": imageTitle});
      print(result);
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'.");
    }
  }

  void shareImage(String? image) async {
    try {
      final int result =
          await platform.invokeMethod('shareImage', {"image": image});
      print(result);
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'.");
    }
  }

  getVideoThumbNail(String? image) async {
    try {
      final result =
          await platform.invokeMethod("videoThumbNail", {"image": image});
      print(" ======== $result");
      return result;
    } catch (e) {
      print("Erorororoororo $e");
    }
  }
}
