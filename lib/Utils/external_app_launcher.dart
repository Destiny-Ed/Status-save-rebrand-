// import 'package:flutter/services.dart';
//
// class FlutterNativeApi {
//   static const platform = const MethodChannel('com.nativeAPI');
//
//   void launchExternalApp(String? appPackageName) async {
//     try {
//       final int result = await platform
//           .invokeMethod('showWhatsApp', {"appPackage": appPackageName});
//       print(result);
//     } on PlatformException catch (e) {
//       print("Failed to get battery level: '${e.message}'.");
//     }
//   }
//
//   void printImage(String? image, String? imageTitle) async {
//     try {
//       final int result = await platform
//           .invokeMethod('printImage', {"image": image, "title": imageTitle});
//       print(result);
//     } on PlatformException catch (e) {
//       print("Failed to get battery level: '${e.message}'.");
//     }
//   }
//
//   void shareImage(String? image) async {
//     try {
//       final int result =
//           await platform.invokeMethod('shareImage', {"image": image});
//       print(result);
//     } on PlatformException catch (e) {
//       print("Failed to get battery level: '${e.message}'.");
//     }
//   }
// //shareVideo
//
//   void shareVideo(String? video) async {
//     try {
//       final int result =
//           await platform.invokeMethod('shareVideo', {"video": video});
//       print(result);
//     } on PlatformException catch (e) {
//       print("Failed to get battery level: '${e.message}'.");
//     }
//   }
//
//   getVideoThumbNail(String? video) async {
//     try {
//       final result =
//           await platform.invokeMethod("videoThumbNail", {"video": video});
//       print(" ======== $result");
//       return result;
//     } catch (e) {
//       print("Erorororoororo $e");
//     }
//   }
// }
