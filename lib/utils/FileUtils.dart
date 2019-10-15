import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;


class FileUtils{
  static Future<String> loadAsset(var fileName) async {
    return await rootBundle.loadString(fileName);
  }
}
