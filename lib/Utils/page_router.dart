import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageRouter {
  PageRouter({this.ctx});

  BuildContext? ctx;

  ///Navigate to next page
  void nextPage({Widget? page}) {
    Navigator.push(ctx!, MaterialPageRoute(builder: (_) => page!));
  }

  ///Navigate to next page and remove previous page
  void nextPageOnly({Widget? page}) {
    Navigator.pushAndRemoveUntil(
        ctx!, MaterialPageRoute(builder: (_) => page!), (route) => false);
  }
}
