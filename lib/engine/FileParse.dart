//文件解析类
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';


class FileParse {
  static int BUFF_SIZE = 4 * 1024;
  int length = -1;

  RandomAccessFile randomAccessFile;
  File file;

  //初始化
  FileParse(fileName) {
    file = new File(fileName);
    randomAccessFile = file.openSync();
    length = randomAccessFile.lengthSync();
  }

  Future<String> readBuffFromFile(len) async {
    print("file read start, and current file position：" + randomAccessFile.positionSync().toString());
    Uint8List inputAsUint8List = await randomAccessFile.read(len);
    Utf8Decoder utf8decoder = new Utf8Decoder();
    var result;
    try {
      result = utf8decoder.convert(inputAsUint8List);
    } catch(e) {
      print("readBuffFromFile error:" + e.toString());
      return await readBuffFromFile(len);
    }
    print("file read end, and current file position：" + randomAccessFile.positionSync().toString());
    return result;
  }

  //修改位置
  static int lastFileOffest = 0;
  void goBackPosition(int fileOffest) {
    print("go to back position: " + fileOffest.toString());
    lastFileOffest = fileOffest;
    randomAccessFile.setPosition(fileOffest);
  }

  void close() {
    randomAccessFile.closeSync();
  }


  bool isEnd() {
    return false;
//    return randomAccessFile.positionSync() >= length - 1;
  }
}
