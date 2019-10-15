

//文件解析类
import 'package:flutter_reader/utils/FileUtils.dart';

class FileParse {

  static Future<String> parseFile(fileName) {
    return FileUtils.loadAsset(fileName);
  }
}