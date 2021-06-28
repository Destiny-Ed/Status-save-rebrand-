import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class GetLocalFilePath {
  Future<Directory> getLocalPath() async {
    Directory? directory = await getExternalStorageDirectory();

    List<String> path = directory!.path.split("/");

    ///return this :       ///storage/emulated/0/Android/data/com.destinyed.video_saver/files
    ///So now I will have to split it to Android

    String storepath = "";

    for (int i = 1; i < path.length; i++) {
      String folder = path[i];

      if (folder != "Android") {
        storepath += "/" + folder;
      } else {
        print("StorePath " + storepath);
        break;
      }
    }
    storepath = storepath + "/WhatsApp/Media/.Statuses";
    //Update the directory path to the new path
    directory = Directory(storepath);
    return directory;
  }

  ///Download User Image
  Future<String> downloadImage(String? image) async {
    Directory? directory = await getExternalStorageDirectory();

    List<String> path = directory!.path.split("/");

    String storepath = "";

    for (int i = 1; i < path.length; i++) {
      String folder = path[i];

      if (folder != "Android") {
        storepath += "/" + folder;
      } else {
        print("StorePath " + storepath);
        break;
      }
    }
    storepath = storepath + "/VideoSaver";
    //Update the directory path to the new path
    directory = Directory(storepath);

    try {
      if (!await directory.exists()) {
        await directory.create(recursive: true); /*Create New Directory */
      }
      if (await directory.exists()) {
        //Save File as csv
        final File file = File("${directory.path}/$image");
        List<int> bytes = utf8.encode(image!);
        file.writeAsBytes(bytes); /*Save File to Directory */
      }
      return "Image saved";
    } catch (e) {
      return "File Not Saved";
    }
  }
}
