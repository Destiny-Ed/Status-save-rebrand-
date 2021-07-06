import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_saver/Constants/adsView.dart';
import 'package:video_saver/Styles/colors.dart';
import 'package:video_saver/Utils/external_app_launcher.dart';
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
            FlutterNativeAPI().launchExternalApp("app.bazarr");
          }),

          ///
          ///Share App
          settingWidget("Share App", Icon((Icons.share)), () {
            final String text =
                "I use HaveIt to download whatsApp status, boomplay and audiomack songs without spending a dime  https://play.google.com/store/apps/details?id=com.destinyed.statussaverpro";
            Share.share(text);
          }),

          ///Rate the app
          ///
          settingWidget("Rate HaveIt | Show some love", Icon((Icons.star_rate)),
              () async {
            // FlutterNativeAPI()
            //     .launchExternalApp("com.destinyed.statussaverpro");
            final url =
                "https://play.google.com/store/apps/details?id=com.destinyed.statussaverpro";
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
