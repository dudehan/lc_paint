import 'package:flutter/material.dart';

class LCPaintModel {
  /// 占比(0~100)
  double proportion;

  /// 画笔颜色
  Color arcColor;

  /// 文字颜色
  Color textColor;

  /// 文字font
  double textFont;

  LCPaintModel({
    @required this.proportion,
    @required this.arcColor,
    this.textColor = Colors.black,
    this.textFont = 12.0,
  });
}

class LCPaintAngle {
  double startAngle;
  double sweepAngle;

  LCPaintAngle({this.startAngle, this.sweepAngle});

  @override
  String toString() {
    print('startAngle : $startAngle; sweepAngle : $sweepAngle');
    return super.toString();
  }
}
