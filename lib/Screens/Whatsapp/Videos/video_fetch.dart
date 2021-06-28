import 'package:permission_handler/permission_handler.dart';
import 'package:video_saver/Screens/Whatsapp/Videos/video_model.dart';
import 'package:video_saver/Utils/getLocalPath.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FetchVideo {
  List<VideoModel> arrVideo = <VideoModel>[];

  Future<List<VideoModel>> listofFiles() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      Permission.storage.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      await GetLocalFilePath().getLocalPath().then((value) async {
        // if (mounted) {
        //   setState(() {
        //     file.addAll(value.listSync().where((element) =>
        //         element.path.endsWith(".mp4"))); //Add Files to fileList
        //   });
        // }
        var list =
            value.listSync().where((element) => element.path.endsWith(".mp4"));

        for (var data in list) {
          final s = data.path;

          final thumbnail = await VideoThumbnail.thumbnailData(video: s);

          final video = VideoModel(thumbnail: thumbnail!, path: s);

          arrVideo.add(video);
        }
      });
    } else {
      await GetLocalFilePath().getLocalPath().then((value) async {
        // if (mounted) {
        //   setState(() {
        //     file.addAll(value.listSync().where((element) =>
        //         element.path.endsWith(".mp4"))); //Add Files to fileList
        //   });
        // }
        var list =
            value.listSync().where((element) => element.path.endsWith(".mp4"));

        for (var data in list) {
          final s = data.path;

          final thumbnail = await VideoThumbnail.thumbnailData(video: s);

          final video = VideoModel(thumbnail: thumbnail!, path: s);

          arrVideo.add(video);
        }
      });
    }

    return arrVideo;
  }
}
