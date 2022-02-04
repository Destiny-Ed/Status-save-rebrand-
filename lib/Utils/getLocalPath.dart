import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class GetLocalFilePath {
  Future<Directory> getLocalPath(bool isStatus) async {
    final String fetch_path = isStatus == true
        ? ".Statuses"
        : Uri.decodeFull("WhatsApp Business Stickers");
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

    // storepath =
    //     storepath + "/Android/media/com.whatsapp/WhatsApp/Media/$fetch_path";

    if (fetch_path == '.Statuses') {
      storepath = storepath +
          "/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/$fetch_path";

      final newDirectory = Directory(storepath);

      if (newDirectory.existsSync()) {
        print("It does not exist");
        return newDirectory;
      } else if (Directory("/storage/emulated/0/WhatsApp/Media/$fetch_path")
          .existsSync()) {
        final newStorePath = "/storage/emulated/0/WhatsApp/Media/$fetch_path";
        print("It exists $newStorePath");
        //Update the directory path to the new path
        return Directory(newStorePath);
      } else {
        final newStorePath =
            "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/$fetch_path";
        print("It exists $newStorePath");
        //Update the directory path to the new path
        return Directory(newStorePath);
      }
    } else {
      storepath = storepath +
          "/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/$fetch_path";

      final newDirectory = Directory(storepath);

      if (newDirectory.existsSync()) {
        print("It does not exist");
        return newDirectory;
      } else if (Directory(
              "/storage/emulated/0/WhatsApp/Media/WhatsApp Stickers")
          .existsSync()) {
        final newStorePath = "/storage/emulated/0/WhatsApp/Media/$fetch_path";
        print("It exists $newStorePath");
        //Update the directory path to the new path
        return Directory(newStorePath);
      } else {
        final newStorePath =
            "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Stickers";
        print("It exists $newStorePath");
        //Update the directory path to the new path
        return Directory(newStorePath);
      }
    }
  }

  ///Music BoomPlay Path
  Future<Directory> getBoomPlayPath(String otherPath) async {
    final String fetch_path = Uri.decodeFull("Boom Player");
    Directory? directory = await getExternalStorageDirectory();

    List<String> path = directory!.path.split("/");

    ///return this :       ///storage/emulated/0/Android/data/app.saver/files
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

    print("Complete store path $storepath");
    storepath = storepath + "/$fetch_path/download/$otherPath";
    //Update the directory path to the new path
    directory = Directory(storepath);
    return directory;
  }

  ///Music BoomPlay Path
  Future<Directory> getAudioMarkPath() async {
    // final String fetch_path = Uri.decodeFull("Boom Player");
    Directory? directory = await getExternalStorageDirectory();

    List<String> path = directory!.path.split("/");

    ///return this :       ///storage/emulated/0/Android/data/app.saver/files
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

    print("Complete store path $storepath");
    storepath = storepath + "/Android/data/com.audiomack/files/Audiomack";
    //Update the directory path to the new path
    directory = Directory(storepath);
    return directory;
  }

  ///Move or Copy a file from one path to the other
  Future<File> moveFile(File sourceFile, String newPath) async {
    final directory = Directory("/storage/emulated/0/VideoSaver");

    try {
      if (!await directory.exists()) {
        await directory.create(recursive: true); /*Create New Directory */
      }
      if (await directory.exists()) {
        try {
          // prefer using rename as it is probably faster
          return await sourceFile.rename(newPath);
        } on FileSystemException catch (e) {
          // if rename fails, copy the source file and then delete it
          final newFile = await sourceFile.copy(newPath);
          await sourceFile.delete();
          return newFile;
        }
      }

      return File(directory.path);
    } catch (e) {
      return File(directory.path);
    }
  }

  ///Download User Image
  Future<String> downloadMusic(String? music) async {
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
        final File file = File("${directory.path}/$music");
        List<int> bytes = utf8.encode(music!);
        file.writeAsBytes(bytes); /*Save File to Directory */
      }
      return "Music saved";
    } catch (e) {
      return "File Not Saved";
    }
  }
}
