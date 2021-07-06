import 'dart:io';

class AdsHelper {
  ///Test Ads

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw new UnsupportedError("Unsupported platform");
  }

  static String get intertitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

// static String get bannerAdsUnitId {
//   if (Platform.isAndroid) {
//     return "ca-app-pub-4655432953203287/9419553548";
//   } else if (Platform.isIOS) {
//     return "Ios banner ads";
//   } else {
//     throw UnimplementedError("Unsupported platform");
//   }
// }
//
// static String get intertitialAdUnitId {
//   if (Platform.isAndroid) {
//     return "ca-app-pub-4655432953203287/5348925523";
//   } else if (Platform.isIOS) {
//     return "Ios banner ads";
//   } else {
//     throw UnimplementedError("Unsupported platform");
//   }
// }
}
