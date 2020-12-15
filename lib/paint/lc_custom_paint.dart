import 'package:flutter/material.dart';

import 'lc_pie_chart.dart';
import '../model/lc_paint_model.dart';
import 'lc_doughnut_chart.dart';
import 'lc_paint_calculate.dart';

enum PaintType { pie, doughnut }

typedef ClickedAtIndex = Function(int index, LCPaintModel paintModel);

class LCCustomPaint extends StatefulWidget {
  final Size size;
  final PaintType paintType;
  final List<LCPaintModel> paintModels;
  final ClickedAtIndex clickedAtIndex;

  LCCustomPaint({
    this.size,
    this.paintType = PaintType.doughnut,
    this.paintModels,
    this.clickedAtIndex,
  });

  @override
  _LCCustomPaintState createState() => _LCCustomPaintState();
}

class _LCCustomPaintState extends State<LCCustomPaint> {
  List<LCPaintAngle> _paintAngles;

  @override
  void initState() {
    super.initState();
    _paintAngles = calculatePaintAngles(widget.paintModels, minAngel: widget.paintType == PaintType.doughnut ? 16 : 5);
  }


  @override
  Widget build(BuildContext context) {
    _paintAngles = calculatePaintAngles(widget.paintModels, minAngel: widget.paintType == PaintType.doughnut ? 16 : 5);
    return GestureDetector(
      child: Container(
        width: widget.size.width,
        height: widget.size.height,
        child: CustomPaint(
          painter: _painter(),
          size: widget.size,
        ),
      ),
      onTapUp: (details) {
        if (widget.clickedAtIndex != null) {
          double angle = calculatePointAngle(details.localPosition, Size(widget.size.width, widget.size.height));
          int index = indexOfAngle(_paintAngles, angle);
          widget.clickedAtIndex(index, widget.paintModels[index]);
        }
      },
    );
  }

  CustomPainter _painter() {
    switch (widget.paintType) {
      case PaintType.pie:
        return PieChart(
          paintModels: widget.paintModels,
          paintAngles: _paintAngles,
        );
        break;

      case PaintType.doughnut:
        return DoughnutChart(
          paintModels: widget.paintModels,
          paintAngles: _paintAngles,
        );
        break;
    }
    return null;
  }
}
