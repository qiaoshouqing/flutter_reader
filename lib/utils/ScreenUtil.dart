/**
 * 屏幕适配
 *
 */
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math';


class ScreenUtil {

  static var screenWidthDp;
  static var screenHeightDp;
  static printDeviceMessage(var context) {
    screenWidthDp = MediaQuery.of(context).size.width;
    screenHeightDp = MediaQuery.of(context).size.height;
    print("devices width dp:" + screenWidthDp.toString());
    print("devices height dp:" + screenHeightDp.toString());

    var widthPx =  window.physicalSize.width;  //宽度
    var heightPx =  window.physicalSize.height;  //高度
    print("devices width px:" + widthPx.toString());
    print("devices width px:" + heightPx.toString());
  }

  static double scale = 1;
  //屏幕显示标准按照iphone XR的标准 414dp/896dp
  static double standard = 414;
  //初始化ScreenUtil
  static init(var context) {
    printDeviceMessage(context);

    double widthDp = MediaQuery.of(context).size.width;
    scale = widthDp / standard;

  }

  //主要按照宽度比例为调整标准
  static double of(double oldSize) {
    double newSize = scale * oldSize;

//    print("scale:" + scale.toString());
//    print("oldSize:" + oldSize.toString());
//    print("newSize:" + newSize.toString());
    return newSize;
  }


  static double degToRad(num deg) => deg * (pi / 180.0);
  static double radToDeg(num rad) => rad * (180.0 / pi);

  static double getStatusBarHeight() => MediaQueryData.fromWindow(window).padding.top;
  static double getScreenWidth() => screenWidthDp;
  static double getScreenHeight() => screenHeightDp;
}