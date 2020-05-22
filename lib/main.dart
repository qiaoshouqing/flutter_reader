import 'package:flutter/material.dart';
import 'package:flutter_reader/page/ReaderPage.dart';
import 'package:flutter_reader/provider/module/ReaderModule.dart';
import 'package:flutter_reader/provider/module/ShowSettingModule.dart';
import 'package:flutter_reader/utils/FileUtils.dart';
import 'package:provider/provider.dart';

void main() {
//  runApp(ChangeNotifierProvider.value(
//    value: new ShowSettingModule(),
//    child: ChangeNotifierProvider.value(
//        value: new ReaderModule(),
//        child: MyApp()
//  )));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
//            ChangeNotifierProvider.value(
//            value: new ShowSettingModule(),
//            child: ChangeNotifierProvider.value(
//                value: new ReaderModule(),
//                child: ReaderPage()
//            ))
                ReaderPage()));
  }

  @override
  void initState() {
    FileUtils.loadAsset("assets/demo.txt").then((res) {
      print("结果部分预览：" + res.substring(0, 10));
      print("读取完毕, 准备写入文件");
      FileUtils.writeFile("demo.txt", res);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("_MyHomePage build called");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          '时间一分一秒的过去了，难道你真的不在乎吗？',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
