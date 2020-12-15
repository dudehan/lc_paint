import 'dart:math';
import 'package:flutter/material.dart';

import './lc_basic_painter.dart';
import '../extension/num_extension.dart';
import '../model/lc_paint_model.dart';


class DoughnutChart extends LCBasicPainter {
  DoughnutChart({
    @required List<LCPaintModel> paintModels,
    @required List<LCPaintAngle> paintAngles,
    double strokeWidth = 20.0,
  }) : super(
          paintModels: paintModels,
          paintAngles: paintAngles,
          strokeWidth: strokeWidth,
        );

  /// 绘制圆环
  @override
  void lcPaint(Canvas canvas, Size size, double startAngle, double sweepAngle, Color arcColor) {
    /// strokeWidth为画笔的粗细，即圆环的粗细
    double margin = strokeWidth / 2;

    /// 圆环绘制区域(减去圆环的粗，保证圆环全部绘制在矩形框内)
    Rect rect = Rect.fromLTWH(margin, margin, size.width - strokeWidth, size.height - strokeWidth);
    /// 圆环半径
    double R = min(rect.width, rect.height) / 2;

    /// 圆环两端的小圆半径(圆环粗的一半)
    double r = strokeWidth / 2;

    /// 计算偏移角度,1/2个小球对应的角度
    double angle = asin(r / (R - r)) / pi * 180;

    /// 圆环画笔
    Paint ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = arcColor;

    /// 小圆画笔
    Paint smallCirclePaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = arcColor;

    /// 圆环区域小于一个小圆
    if(sweepAngle <= angle * 2) {
      /// 计算起始小圆圆心偏移量
      double startOffsetX = R * cos((startAngle + angle).toRadian()) + R + margin;
      double startOffsetY = R * sin((startAngle + angle).toRadian()) + R + margin;

      /// 绘制起始位置小圆
      canvas.drawCircle(Offset(startOffsetX, startOffsetY), r, smallCirclePaint);
    } else {

      /// 计算起始小圆圆心偏移量
      double startOffsetX = R * cos((startAngle + angle).toRadian()) + R + margin;
      double startOffsetY = R * sin((startAngle + angle).toRadian()) + R + margin;

      /// 绘制起始位置小圆
      canvas.drawCircle(Offset(startOffsetX, startOffsetY), r, smallCirclePaint);

      /// 计算结束位置小圆圆心偏移量
      double endOffsetX = R * cos((startAngle + sweepAngle - angle).toRadian()) + R + margin;
      double endOffsetY = R * sin((startAngle + sweepAngle - angle).toRadian()) + R + margin;
      /// 绘制结束位置小圆
      canvas.drawCircle(Offset(endOffsetX, endOffsetY), r, smallCirclePaint);

      /// 绘制圆环
      canvas.drawArc(rect, (startAngle + angle).toRadian(), (sweepAngle - 2 * angle).toRadian(), false, ringPaint);
    }
  }

}
