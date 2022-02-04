import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:video_saver/Styles/colors.dart';

Widget shimmerLoader() {
  return Expanded(
    child: Container(
      color: MyColors().green,
      padding: const EdgeInsets.all(10.0),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
        itemCount: 20,
        itemBuilder: (context, index) {
          ///Return Widget
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: MyColors().white),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Text("Loading..."),
                ),
              ),

              ///Show Play Icon on Video thumbnail
              Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.play_circle_outline,
                  size: 35,
                ),
              ),

              Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: MyColors().white,
                  )),
            ],
          );
        },
        staggeredTileBuilder: (int index) {
          return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
        },
      ),
    ),
  );
}
