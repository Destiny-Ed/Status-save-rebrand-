import 'package:permission_handler/permission_handler.dart';
import 'package:video_saver/Utils/getLocalPath.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FetchVideo {
  List<Map<String, dynamic>> arrVideo = [];

  Future<List<Map<String, dynamic>>> listofFiles() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      Permission.storage.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      await GetLocalFilePath().getLocalPath(true).then((value) async {
        // if (mounted) {
        //   setState(() {
        //     file.addAll(value.listSync().where((element) =>
        //         element.path.endsWith(".mp4"))); //Add Files to fileList
        //   });
        // }
        var list = value
            .listSync()
            .reversed
            .where((element) => element.path.endsWith(".mp4"));

        for (var data in list) {
          final videoPath = data.path;

          // final s = await FlutterNativeApi().getVideoThumbNail(videoPath);

          // final thumbnail =
          //     await VideoThumbnail.thumbnailData(video: videoPath);

          final mapOfVideo = {"video_path": videoPath};

          arrVideo.add(mapOfVideo);
        }
      });
    } else {
      await GetLocalFilePath().getLocalPath(true).then((value) async {
        var list = value
            .listSync()
            .reversed
            .where((element) => element.path.endsWith(".mp4"));

        for (var data in list) {
          final videoPath = data.path;
          final path = data.absolute.path;

          // print("Video path $videoPath");
          // print("Absoulte $path");

          // final s = await FlutterNativeApi().getVideoThumbNail(path.toString());

          // final thumbnail =
          //     await VideoThumbnail.thumbnailData(video: videoPath);

          final mapOfVideo = {"video_path": videoPath};

          arrVideo.add(mapOfVideo);
        }
      });
    }

    return arrVideo;
  }
}
