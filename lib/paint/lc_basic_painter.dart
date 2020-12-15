import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/lc_paint_model.dart';
import '../extension/num_extension.dart';

abstract class LCBasicPainter extends CustomPainter {
  List<LCPaintModel> paintModels = [];
  List<LCPaintAngle> paintAngles = [];
  double strokeWidth;

  LCBasicPainter({
    @required this.paintModels,
    @required this.paintAngles,
    @required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {

    if(paintModels == null || paintModels.length <= 0) return;
    for (int i = 0; i < paintAngles.length; i++) {
      LCPaintAngle paintAngle = paintAngles[i];
      LCPaintModel paintModel = paintModels[i];

      /// 绘制比例图
      lcPaint(canvas, size, paintAngle.startAngle, paintAngle.sweepAngle, paintModel.arcColor);

      if(kDebugMode) {
        /// 绘制文字
        paintText(canvas, size, paintAngle.startAngle, paintAngle.sweepAngle, paintModel.proportion, paintModel.textColor,
                paintModel.textFont);
      }
    }
  }

  void lcPaint(Canvas canvas, Size size, double startAngle, double sweepAngle, Color arcColor);

  /// 绘制文字
  paintText(Canvas canvas, Size size, double startAngle, double sweepAngle, double proportion, Color textColor,
      double fontSize) {
    double midAngle = sweepAngle / 2 + startAngle;
    double r = size.width / 2;

    /// 偏移以左上角为原点, r/2 取半径一半计算扇形的中心线的重点
    double offsetX = (r / 2) * cos(midAngle.toRadian()) + size.width / 2 - 10;
    double offsetY = (r / 2) * sin(midAngle.toRadian()) + size.height / 2 - 5;

    TextPainter textPainter = _textPaint(canvas, '$proportion'.substring(0, 3) + ' %', textColor, fontSize);
    textPainter.layout();
    textPainter.paint(canvas, Offset(offsetX, offsetY));
  }

  TextPainter _textPaint(Canvas canvas, String text, Color color, double fontSize) {
    TextPainter textPainter = TextPainter()
      ..text = TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
        ),
      )
      ..textDirection = TextDirection.ltr;
    return textPainter;
  }

  @override
  bool shouldRepaint(covariant LCBasicPainter oldDelegate) {
    return oldDelegate.paintModels != paintModels;
  }
}
