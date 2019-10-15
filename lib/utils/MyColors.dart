import 'package:flutter/material.dart';
import 'dart:math';


class MyColors {

  static var DEEP_PURPLE = const Color(0xff3a0080);


  static var PRIMARY_COLOR = PRIMARY_PURPLE;
  static var PRIMARY_PURPLE = Colors.deepPurple;
  static var PRIMARY_PINK = Colors.pink;
  static var PRIMARY_RED = Colors.red;
  static var PRIMARY_YELLOW = Colors.deepOrange;
  static var PRIMARY_GREEN = Colors.teal;
  static var PRIMARY_BLUE = Colors.blue;

  static var primaryColorList = [PRIMARY_PURPLE, PRIMARY_PINK, PRIMARY_RED, PRIMARY_YELLOW, PRIMARY_GREEN, PRIMARY_BLUE];
  static List themes = ["purple", "pink", "red", "yellow", "green", "blue"];

  //这个顺序是一个死命令不能改动，只能增加。
  static var BEAUTIFY_COLORS_0 = const Color(0xfff77754);
  static var BEAUTIFY_COLORS_1 = const Color(0xff018790);
  static var BEAUTIFY_COLORS_2 = const Color(0xff0a516d);
  static var BEAUTIFY_COLORS_3 = const Color(0xff2b2726);
  static var BEAUTIFY_COLORS_4 = const Color(0xffdf0054);
  static var BEAUTIFY_COLORS_5 = const Color(0xff283148);


  static var GREY_100 = const Color(0xfff5f5f5);
  static var GREY_200 = const Color(0xffeeeeee);
  static var GREY_300 = const Color(0xffe0e0e0);
  static var GREY_400 = const Color(0xffbdbdbd);
  static var GREY_500 = const Color(0xff9e9e9e);
  static var GREY_600 = const Color(0xff757575);
  static var GREY_800 = const Color(0xff424242);
  static var GREY_900 = const Color(0xff212121);



  static var colorList = [BEAUTIFY_COLORS_0, BEAUTIFY_COLORS_1, BEAUTIFY_COLORS_2, BEAUTIFY_COLORS_3, BEAUTIFY_COLORS_4, BEAUTIFY_COLORS_5];
//  static Color getRandomColor() {
//    Random random = new Random();
//    return colorList[random.nextInt(colorList.length)];
//  }
//
//  static Color getColor(var index) {
//    return colorList[index % colorList.length];
//  }


}