import 'dart:async' show Future;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class FileUtils{
  static Future<String> loadAsset(var fileName) async {
    return await rootBundle.loadString(fileName);
  }

  static writeFile(fileName, content) async {
    var directory = await getApplicationSupportDirectory();
    File file = new File(directory.path + "/" + fileName);
    print("文件位置：" + directory.path + "/" + fileName);
    file = await file.writeAsString(content);
    print("写入完成");
  }

  static Future<Directory> getPath() async {
    return await getApplicationSupportDirectory();
  }
}
