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
}
