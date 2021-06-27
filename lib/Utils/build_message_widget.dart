import 'package:flutter/material.dart';
import 'package:video_saver/Styles/colors.dart';

Widget buildMessageWidget(VoidCallback onTap, String buttonText, String message,
    Widget icon, BuildContext context) {
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width - 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MyColors().white, width: 1.5),
            ),
            child: Column(
              children: [
                icon,
                const SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
                width: MediaQuery.of(context).size.width - 150,
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.5, color: MyColors().green),
                ),
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: MyColors().green),
                )),
          )
        ],
      ),
    ),
  );
}
