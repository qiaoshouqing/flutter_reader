import 'package:flutter/material.dart';
import 'package:flutter_reader/bean/FPage.dart';
import 'package:flutter_reader/engine/FileParse.dart';
import 'package:flutter_reader/engine/TypeSetting.dart';
import 'package:flutter_reader/provider/module/ReaderModule.dart';
import 'package:flutter_reader/provider/module/ShowSettingModule.dart';
import 'package:flutter_reader/utils/FileUtils.dart';
import 'package:flutter_reader/utils/MyColors.dart';
import 'package:flutter_reader/utils/ScreenUtil.dart';
import 'package:provider/provider.dart';

class ReaderPage extends StatefulWidget {
  @override
  ReaderPageState createState() => ReaderPageState();
}

class ReaderPageState extends State<ReaderPage> {
  String fileName = "assets/demo.txt";
  String str = "";

//  String str =
//      "我一向以为奇葩的人不在少数。有些人看起来奇葩实际上靠谱，有些人看起来靠谱实际上奇葩，我不知道朱一发属于哪一种，也不知道自己属于哪一种。\n朱一发是我刚到北京时的合租室友，是我见过的少数特立独行的人之一。孔子说颜回“一箪食，一瓢饮，在陋巷，人也不堪其忧，回也不改其乐”。朱一发就有点“不改其乐”的意思。他具备一种能力——把无聊的事变得有趣，而我和他相反，擅长把有意思的事变得无聊。因缘凑泊，我们成了朋友。\n朱一发的签名是“红灯须硬闯，马路要横穿”。这句话让我在未曾谋面时就断定他是奇葩一枚。第一次见面是在合租的房子里，他十足的屌丝相，递了张名片给我，我顺口就念出来了：“来一发！”\n“不是来一发，是朱一发。”\n“你这名字跟埃及前住房部长马格拉比有一拼，让有知识的人一不小心就念错。”当时朱一发正在学车，每次去驾校前他都拎一听啤酒上路。他说在驾校不会有交警查，要趁机体会体会酒驾的感觉。他喜欢跑到高档商场问衣服，和售货员漫天砍价，砍完就走，从来不买。我骂他有病。他说这不叫病，叫沟通力。\n\n朱一发和我去超市，路上碰到个衣着干净打扮光鲜的小姑娘，说自己是外地来的，钱包被偷了，让我给她买点吃的。这种我见得多了，直接无视。走出十几米，朱一发说：“干吗不和她聊聊。”\n我说：“你看不出来她是骗子？”\n“能看出来还怕被骗？”\n“不想耽误时间。”\n“你日理万机吗？”\n“不。”\n“那何不聊聊呢？”\n朱一发长了一张像被人刚刚扁过一顿的脸，每次开口又有让人再扁一顿的冲动。不过，他的话虽然听起来欠揍，但要过过脑子，似乎也有那么一点道理。\n我想起大学时候吃食堂，受《高效能人士的七个习惯》毒害，明明可以一顿饭吃二十分钟，我偏要五分钟吃完，剩下十五分钟坐着干等同学，边等边眼馋他们碗里的鸡腿儿。\n也许朱一发是对的。反正闲着也是闲着。\n我们转身返回。又见小姑娘，朱一发迎上去。\n小姑娘说：“好心人帮帮我吧。”\n朱一发问：“你是学生吗？”\n“是的，大四，准备考研呢。”\n“那我问你，中国革命的三大法宝是什么？”\n小姑娘摇摇头，一脸茫然。\n“知道任汝芬是谁吗？”\n小姑娘急了：“不给就算了，带这样欺负人的吗！”\n朱一发笑了：“你想吃什么，我给你买。”\n“肯德基。”\n我和朱一发面面相觑，他冲我递了个无辜的眼神。\n“妹子，你吓到我了，你看我们这身打扮像吃得起肯德基的人吗，我们只吃得起方便面。”\n其实朱一发有时周末在家加班，一天12小时不离电脑，三顿肯德基。\n“那你给我几块钱，我自己买吧。”\n“你不会是骗子吧？”\n“我这有身份证，还有学生证，你看。”小姑娘娴熟地掏出证件。学生证是人大的，五块钱的那种。\n“哎呦，原来是学妹”，朱一发也掏出自己办的人大学生证，“他也是人大的，把证拿出来给师妹瞧瞧。”\n我从书包里翻出北外的学生证。\n“他不是说你也是人大的吗？”\n“对，我是人大的，但我出门一般带这个证，这个证比人大的值钱，人大的五块，这个十块。”\n小姑娘反应过来，脸“刷”一下就挂不住了。朱一发生气地冲我说：“去去去，别欺负人家。”然后真的带小姑娘去吃了肯德基。\n吃完，小姑娘大概明白被我们看破了身份，也不再提额外的要求，千恩万谢地告辞。走了几步，朱一发叫住她：“妹子，你还年轻，别耽误了。”\n小姑娘愣住，眼圈登时就红了。\n两年后的今天我才学会“人艰不拆”这个词，回想起来，朱一发那时已经做到了。他比我高明的地方，只有这么一点。\n可单单这么一点，就是不小的距离。";
  FileParse fileParse;

  @override
  void initState() {
    FileUtils.getPath().then((dir) {
      fileParse = new FileParse(dir.path + "/demo.txt");
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {
    print("readerpage build called");
//    Provider.of<ReaderModule>(context).setInitPages([new FPage()]);

    if (fileParse == null) {
      return new Scaffold(
        body: new Offstage(
          offstage: !(true),
          child: Center(
            //保证控件居中效果
            child: new SizedBox(
              width: 120.0,
              height: 120.0,
              child: new Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new CircularProgressIndicator(),
                    new Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                      ),
                      child: new Text(
                        "loading",
                        style: new TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
//    return _getReaderPageScaffold();

    return ChangeNotifierProvider.value(
            value: new ShowSettingModule(),
            child: ChangeNotifierProvider.value(
                value: new ReaderModule(),
                child: _getReaderPageScaffold()
            ));

  }

  Widget _getReaderPageScaffold() {
    return Scaffold(body: Builder(
      // Create an inner BuildContext so that the onPressed methods
      // can refer to the Scaffold with Scaffold.of().
        builder: (BuildContext context) {
          print("ReaderPage Scaffold build");
          scaffoldContext = context;
          return new Stack(
            children: <Widget>[
              //阅读页
              Consumer<ShowSettingModule>(
                builder: (context, showSetting, child) {
                  print("PageView.custom consumer build call");
                  return GestureDetector(
                    onTap: showSetting.switchShowSetting,
                    child: child,
                  );
                },
                child: Consumer<ReaderModule>(builder: (context, reader, _) {
                  return new PageView.custom(
                    childrenDelegate: new SliverChildBuilderDelegate(
                          (context, index) {
                        print("page index:" + index.toString());
                        print("pages.length:" + reader.value.length.toString());
                        if (index == reader.value.length - 1) {
                          fileParse
                              .readBuffFromFile(FileParse.BUFF_SIZE)
                              .then((res) {
                            print("readBuffFromFile:" + res.substring(0, 10));
                            print("readBuffFromFile:" + res.substring(res.length - 10, res.length));
                            if (res != null && res != "") {
                              str = res;
                              TextPainter painter = TypeSetting.initPainer(str);
                              painter.layout(
                                  minWidth: 0,
                                  maxWidth: TypeSetting.getLineWidth(context));
                              List<FPage> tempPages = TypeSetting.breakText(str, painter, context, fileOffset: FileParse.lastFileOffest);
                              if (!fileParse.isEnd()) {
                                int fileOffset =
                                TypeSetting.removeOverContent(tempPages);
                                fileParse.goBackPosition(fileOffset);
                              }
                              reader.addNewPages(tempPages);
                            }
                          });
                        }
                        print("build index:" + index.toString());
                        return CustomPaint(
                          size: Size(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height),
                          painter: MyPainter(scaffoldContext, index, reader.value),
                        );
                      },
                    ),
                  );
                }),
              ),
              //顶部返回键标题栏区域
              new Positioned(
                left: 0,
                top: 0,
                right: 0,
                child:
                Consumer<ShowSettingModule>(builder: (context, showSetting, _) {
                  print("ShowSettingModule consumer called");
                  return new Offstage(
                      offstage: !(showSetting.value),
                      child: new Container(
                        color: MyColors.READER_PAGE_BG,
                        padding: EdgeInsets.fromLTRB(
                            ScreenUtil.of(10),
                            MediaQuery.of(context).padding.top + ScreenUtil.of(5),
                            ScreenUtil.of(10),
                            ScreenUtil.of(10)),
                        child: new Row(
                          children: <Widget>[
                            new GestureDetector(
                              child:
                              new Icon(Icons.arrow_back, color: Colors.black),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ));
                }),
              ),
              //底部相关设置区域
              new Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Consumer<ShowSettingModule>(
                    builder: (context, showSetting, _) {
                      return new Offstage(
                          offstage: !(showSetting.value),
                          child: new Container(
                            color: MyColors.READER_PAGE_BG,
                            padding: EdgeInsets.fromLTRB(
                                ScreenUtil.of(10),
                                ScreenUtil.of(10),
                                ScreenUtil.of(10),
                                MediaQuery.of(context).padding.bottom +
                                    ScreenUtil.of(5)),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                new Icon(Icons.menu, color: Colors.black),
                                new Icon(Icons.settings_ethernet,
                                    color: Colors.black),
                                new Icon(Icons.wb_sunny, color: Colors.black),
                                new Icon(Icons.text_format, color: Colors.black),
                              ],
                            ),
                          ));
                    },
                  )),
            ],
          );
        }));
  }
}

class MyPainter extends CustomPainter {
  BuildContext context;
  int pageIndex;
  TextPainter textPainter;
  List<FPage> pages;

  MyPainter(BuildContext context, int index, List<FPage> pages) {
    this.context = context;
    this.pageIndex = index;
    this.pages = pages;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //开始绘制
    if (pageIndex >= pages.length) {
      pageIndex = pages.length - 1;
    }

    print("开始绘制：pageIndex:" + pageIndex.toString());
    //绘制文字
    _paintPage(pages, textPainter, canvas, size);
    //绘制页码
    _pagePageNum(pages, canvas, size);
    print("结束绘制：pageIndex:" + pageIndex.toString());
  }

  _paintPage(List<FPage> pages, TextPainter painter, Canvas canvas, Size size) {
    for (int i = 0; i < pages[pageIndex].lines.length; i++) {
      painter = TypeSetting.initPainer(pages[pageIndex].lines[i].lineStr);
      painter.layout(minWidth: 0, maxWidth: TypeSetting.getLineWidth(context));
      painter.paint(canvas,
          Offset(pages[pageIndex].lines[i].x, pages[pageIndex].lines[i].y));
    }
  }

  //绘制页码
  _pagePageNum(List<FPage> pages, Canvas canvas, Size size) {
    String pageNum =
        (pageIndex + 1).toString() + " / " + (pages.length + 0).toString();
    final textStyle = TextStyle(
      color: MyColors.GREY_800,
      fontSize: 14,
      height: 1.7,
    );
    final textSpan = TextSpan(
      text: pageNum,
      style: textStyle,
    );
    TextPainter painter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    painter.layout(minWidth: 0, maxWidth: TypeSetting.getLineWidth(context));

    //获取页标宽度
    List<TextBox> textBoxList = painter.getBoxesForSelection(
        new TextSelection(baseOffset: 0, extentOffset: pageNum.length - 1));
    TextBox textBox = textBoxList.elementAt(0);
    double pageNumsWidth = textBox.right - textBox.left;
    print("pageNumsWidth:" + pageNumsWidth.toString());

    painter.paint(
        canvas,
        Offset(TypeSetting.getLineWidth(context) - pageNumsWidth,
            TypeSetting.getTextAreaMaxY(context)));
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
