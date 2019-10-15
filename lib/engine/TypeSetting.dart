import 'package:flutter/material.dart';
import 'package:flutter_reader/bean/Line.dart';
import 'package:flutter_reader/bean/Page.dart';
import 'package:flutter_reader/utils/ScreenUtil.dart';

//排版类
class TypeSetting {

  static TextPainter initPainer(String str) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 17,
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
    double startX = getLeftRightPadding() + getTextWidth(0, painter) * 2;
    int startOffset = 0;
    while (offset < length) {
      var char = str.substring(offset, offset + 1);
      double width = getTextWidth(offset, painter);
      bool isNewLine = false;
      bool isNewParagraph = false;
      int offsetNum = 0;

      if (char == '\n' || char == '\r') {
        if(char == '\n') {
          offsetNum = 1;
          isNewLine = true;
          isNewParagraph = true;
        }
        if(char == '\r') {
          if(offset + 1 < length) {
            if(str.substring(offset, offset + 2) == '\r\n') {
              offsetNum = 2;
              isNewLine = true;
              isNewParagraph = true;
            }
          }
        }
      } else if (currentLineX + width > getTextAreaMaxX(context)) {
        //正常换行
        isNewLine = true;
      }

      if(isNewLine) {
        Line line = new Line();
        //把上一行的文字存储起来。如果越界了说明文本解析完成了，跳出循环。
        if(startOffset > length || offset > length) {
          break;
        }
        line.lineStr = str.substring(startOffset, offset);
        line.y = currentLineY;
        line.x = startX;
        page.lines.add(line);
        if(isNewParagraph) {
          //段首缩进
          startX = getLeftRightPadding() + 2 * getTextWidth(0, painter);
          currentLineX = getLeftRightPadding() + 2 * getTextWidth(0, painter);
        } else {
          startX = getLeftRightPadding();
          currentLineX = getLeftRightPadding();
        }
        //存在换行的话，把startOffset往后挪一下，避免读取下一行文字的时候带上换行符。
        startOffset = offset + offsetNum;
        offset = startOffset;
        //因为要换行，提前赋值下一行坐标。
        currentLineY += getTextHeight(0, painter) + getLinePadding();
        //换页
        if (isNewPage(currentLineY, getTextHeight(0, painter),
            getTextAreaMaxY(context))) {
          pages.add(page);
          page = new Page();
          currentLineY = getTopPadding(context);
        }
      }

      //offset是当前字符，如果当前字符应该属于下一行。所以先不增加offset。
      //如果是新段落的话换行的时候
      if(!isNewLine) {
        currentLineX += width;
        offset++;
      }
      isNewLine = false;
      isNewParagraph = false;
    }
    pages.add(page);

    //输出排版内容
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

  ///获取文字区域的最大y坐标
  static double getTextAreaMaxY(BuildContext context) {
    return MediaQuery.of(context).size.height - getBottomPadding(context);
  }

  ///文字宽度
  static double getTextWidth(int offest, TextPainter painter) {
    List<TextBox> textBoxList = painter.getBoxesForSelection(
        new TextSelection(baseOffset: offest, extentOffset: offest + 1));
    TextBox textBox = textBoxList.elementAt(0);
    return textBox.right - textBox.left;
  }

  ///文字高度
  static double getTextHeight(int offest, TextPainter painter) {
    List<TextBox> textBoxList = painter.getBoxesForSelection(
        new TextSelection(baseOffset: offest, extentOffset: offest + 1));
    TextBox textBox = textBoxList.elementAt(0);
    return textBox.bottom - textBox.top;
  }

  ///实际行宽，屏幕宽度减去左右空余空间
  static double getLineWidth(BuildContext context) {
    return MediaQuery.of(context).size.width - getLeftRightPadding() * 2;
  }

  static double getTextAreaMaxX(BuildContext context) {
    return MediaQuery.of(context).size.width - getLeftRightPadding();
  }

  ///文字左右空间
  static double getLeftRightPadding() {
    return 20;
  }

  ///文字距离顶部距离（安全区域）
  static double getTopPadding(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  ///文字距离顶部距离（本身的安全区域+底部空余空间）
  static double getBottomPadding(BuildContext context) {
    return MediaQuery.of(context).padding.bottom + getFooterPadding();
  }

  ///底部空余空间（页码显示区域）
  static double getFooterPadding() {
    return ScreenUtil.of(20);
  }

  ///行间距
  static double getLinePadding(){
    return ScreenUtil.of(10);
  }

}