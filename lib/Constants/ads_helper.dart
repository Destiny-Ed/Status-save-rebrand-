import 'dart:io';

class AdsHelper {
  ///Test Ads

  // static String get bannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/6300978111';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/2934735716';
  //   }
  //   throw new UnsupportedError("Unsupported platform");
  // }
  //
  // static String get intertitialAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "ca-app-pub-3940256099942544/1033173712";
  //   } else if (Platform.isIOS) {
  //     return "ca-app-pub-3940256099942544/4411468910";
  //   } else {
  //     throw new UnsupportedError("Unsupported platform");
  //   }
  // }

  ///Production Ads id

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1320195383145171/3536455874";
    } else if (Platform.isIOS) {
      return "Ios banner ads";
    } else {
      throw UnimplementedError("Unsupported platform");
    }
  }

  static String get intertitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1320195383145171/3153953127";
    } else if (Platform.isIOS) {
      return "Ios banner ads";
    } else {
      throw UnimplementedError("Unsupported platform");
    }
  }
}
