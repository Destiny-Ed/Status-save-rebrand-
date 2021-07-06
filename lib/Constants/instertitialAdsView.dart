import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_saver/Constants/ads_helper.dart';

class IntertitialAds extends ChangeNotifier {
  InterstitialAd? _interstitialAd;

  bool _isInterstitialAdReady = false;

  ///Implement Getters
  InterstitialAd get interstitialAd => _interstitialAd!;

  bool get isInterstitialAdReady => _isInterstitialAdReady;

  ///Load InterstitialAd
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdsHelper.intertitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          notifyListeners();

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print(ad.responseInfo);
            },
          );

          _isInterstitialAdReady = true;
          notifyListeners();
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
          notifyListeners();
        },
      ),
    );
  }
}
