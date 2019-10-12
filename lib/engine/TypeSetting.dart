import 'package:flutter/material.dart';
import 'package:flutter_reader/bean/Line.dart';
import 'package:flutter_reader/bean/Page.dart';

//排版类
class TypeSetting {

  static TextPainter initPainer(String str) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
      height: 1.7,
    );
    final textSpan = TextSpan(
      text: str,
      style: textStyle,
    );
    TextPainter painter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    return painter;
  }

  static List<Page> breakText(String str, TextPainter painter, BuildContext context) {
    List<Page> pages = List();
    Page page = new Page();

    int length = str.length;
    int offset = 0;
    double currentLineX = 2 * getTextWidth(0, painter);
    double currentLineY = getTopPadding(context);
    double startX = getTextWidth(0, painter) * 2;
    int startOffset = 0;
    while (offset < length) {
      var char = str.substring(offset, offset + 1);
      double width = getTextWidth(offset, painter);
      bool isNewLine = false;
      bool isNewParagraph = false;

      if (char == '\n' || char == '\r') {
        //换行符号
        isNewLine = true;
        isNewParagraph = true;
      } else if (currentLineX + width > getLineWidth(context)) {
        //正常换行
        isNewLine = true;
      }

      if(isNewLine) {
        isNewLine = false;
        //换行
        Line line = new Line();
        line.lineStr = str.substring(startOffset, offset);
        line.y = currentLineY;
        line.x = startX;
        page.lines.add(line);

        if(isNewParagraph) {
          //如果是一个新段落，则跳过一个字符。这个地方可能需要改。
          startOffset = offset + 1;
          //段首缩进
          startX = 2 * getTextWidth(0, painter);
          currentLineX = 2 * getTextWidth(0, painter);
        } else {
          startOffset = offset;
          startX = 0;
          currentLineX = 0;
        }
        isNewParagraph = false;
        //因为要换行，提前赋值下一行坐标。
        currentLineY += getTextHeight(offset, painter);

        //换页
        if (isNewPage(currentLineY, getTextHeight(offset, painter),
            getScreenHeight(context))) {
          pages.add(page);
          page = new Page();
          currentLineY = 0;
        }
      }
      currentLineX += width;
      offset++;
    }
    pages.add(page);

    print("page count:" + pages.length.toString());
    for (int i = 0; i < pages.length; i++) {
      print("page-" +
          i.toString() +
          " line count:" +
          pages[i].lines.length.toString());
      for (int j = 0; j < pages[i].lines.length; j++) {
        print("lineStr:" + pages[i].lines[j].lineStr);
      }
    }
    return pages;
  }

  ///如果下下行的Y大于屏幕宽度了则换一页开始，下一行是即将绘制的。之所以是下下行，因为是y是一行的顶部坐标。
  static isNewPage(double currentY, double textHeight, double screenHeight) {
    if (currentY + textHeight > screenHeight) {
      return true;
    }
    return false;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height - getBottomPadding(context);
  }

  static double getTextWidth(int offest, TextPainter painter) {
    List<TextBox> textBoxList = painter.getBoxesForSelection(
        new TextSelection(baseOffset: offest, extentOffset: offest + 1));
    TextBox textBox = textBoxList.elementAt(0);
    return textBox.right - textBox.left;
  }

  static double getTextHeight(int offest, TextPainter painter) {
    List<TextBox> textBoxList = painter.getBoxesForSelection(
        new TextSelection(baseOffset: offest, extentOffset: offest + 1));
    TextBox textBox = textBoxList.elementAt(0);
    return textBox.bottom - textBox.top;
  }

  static double getLineWidth(BuildContext context) {
    return MediaQuery.of(context).size.width - getLeftRightPadding() * 2;
  }

  static double getLeftRightPadding() {
    return 10;
  }

  static double getTopPadding(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getBottomPadding(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

}