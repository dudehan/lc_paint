import 'package:flutter/material.dart';

import './lc_basic_painter.dart';
import '../extension/num_extension.dart';
import '../model/lc_paint_model.dart';

class PieChart extends LCBasicPainter {
  PieChart({
    @required List<LCPaintModel> paintModels,
    @required List<LCPaintAngle> paintAngles,
    double strokeWidth = 1.0,
  }) : super(
          paintModels: paintModels,
          paintAngles: paintAngles,
          strokeWidth: strokeWidth,
        );

  @override

  /// 绘制扇形
  @override
  void lcPaint(Canvas canvas, Size size, double startAngle, double sweepAngle, Color arcColor) {
    Paint paint = Paint()
      ..strokeWidth = 1.0
      ..color = arcColor
      ..isAntiAlias = true;
    Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);
    canvas.drawArc(rect, startAngle.toRadian(), sweepAngle.toRadian(), true, paint);
  }
}
