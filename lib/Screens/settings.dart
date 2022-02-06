import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_saver/Constants/adsView.dart';
import 'package:video_saver/Styles/colors.dart';
import 'package:share/share.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ///Get Other Apps
          ///
          settingWidget("More Apps", Icon((Icons.apps)), () {
            FlutterNativeApi.launchExternalApp("app.puzzle_bee");
          }),

          ///
          ///Share App
          settingWidget("Share App", Icon((Icons.share)), () {
            final String text =
                "I use Wsaver to download whatsApp statuses, boomplay and audiomack songs without internet  https://play.google.com/store/apps/details?id=app.wsaver";
            FlutterNativeApi.shareText(text);
          }),

          ///Rate the app
          ///
          settingWidget("Rate HaveIt | Show some love", Icon((Icons.star_rate)),
              () async {
            // FlutterNativeApi()
            //     .launchExternalApp("app.wsaver");
            final url =
                "https://play.google.com/store/apps/details?id=app.wsaver";
            await canLaunch(url)
                ? await launch(url)
                : throw 'Could not launch $url';
          }),

          ///Ads
          BannerAdsView(),

          ///Current app version
        ],
      ),
    );
  }
}

Widget settingWidget(String? text, Icon? icon, VoidCallback? onTap) {
  return InkWell(
    onTap: onTap,
    child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15.0),
      elevation: 8.0,
      shadowColor: MyColors().green,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListTile(
          trailing:
              CircleAvatar(backgroundColor: MyColors().green, child: icon),
          title: Text(text!),
          // leading: CircleAvatar(
          //     backgroundColor: MyColors().green,
          //     child: Icon(Icons.arrow_forward_ios_rounded)),
        ),
      ),
    ),
  );
}
