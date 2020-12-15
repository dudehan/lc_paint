import 'dart:math';
import 'package:flutter/material.dart';
import '../model/lc_paint_model.dart';

/// 角度所在index
int indexOfAngle(List<LCPaintAngle> paintAngles, double angle) {
    for (int i = 0; i < paintAngles.length; i++) {
        LCPaintAngle paintAngle = paintAngles[i];
        if (paintAngle.startAngle < angle && (paintAngle.startAngle + paintAngle.sweepAngle) > angle) return i;
    }
    return -1;
}

/// 计算每个比例的绘制区域
List<LCPaintAngle> calculatePaintAngles(List<LCPaintModel> paintModels, {
    /// separateAngle: 分隔角度
    double separateAngle = 0,
    /// 最小比例，低于1%则显示最小角度
    double minProportion = 1,
    /// 最小角度，
    /// 绘制扇形时，当比例小于1%时显示1度
    /// 绘制圆环时，以圆环的中心点为圆心，1/2个圆环
    double minAngel = 1,
}) {
    /// 总角度(减去小于最小比例的固定角度，剩余的角度)
    double _residualTotalAngle = 360;

    /// 剩余总比例
    /// 1.减去小于_minProportion的比例，
    /// 2.大于_minProportion的部分以_totalProportion为总比例分割_totalAngle
    double _residualTotalProportion = 100;

    List<LCPaintAngle> paintAngles = [];
    double totalProportion = 0;
    double startAngle = 0;

    /// 计算剩余总角度及剩余总比例(减去所有小于比例小于_minProportion的部分)
    paintModels.forEach((element) {
        if (element.proportion < minProportion) {
            _residualTotalAngle -= minAngel;
            _residualTotalProportion -= element.proportion;
        }
        totalProportion += element.proportion;
    });

    /// 总比例大于100抛出异常
    assert(() {
        if (totalProportion > 100) {
            throw FlutterError.fromParts(<DiagnosticsNode>[
                ErrorSummary('总比例相加大于100'),
            ]);
        }
        return true;
    }());

    /// 生成paintAngles
    paintModels.forEach((element) {
        double sweepAngle = element.proportion < minProportion
                ? minAngel
                : element.proportion / _residualTotalProportion * _residualTotalAngle;
                // : element.proportion / _residualTotalProportion * _residualTotalAngle;

        LCPaintAngle paintAngle = LCPaintAngle(startAngle: startAngle, sweepAngle: sweepAngle);
        paintAngles.add(paintAngle);
        startAngle += sweepAngle;
    });

    return paintAngles;
}

/// 计算角度
calculatePointAngle(Offset point, Size size) {
    /// 原点：矩形框的中心点
    double originX = size.width / 2;
    double originY = size.height / 2;

    /// 两点间距离（point - 原点）
    double d = sqrt((originX - point.dx) * (originX - point.dx) + (originY - point.dy) * (originY - point.dy));

    /// 弧度
    double radian = asin((point.dy - originY).abs() / d);

    /// 角度
    double angle = radian * 180 / pi;

    //          |
    //      er  |  yi
    //   -------+-------> x
    //      san |  si
    //          |
    //          y
    /// 第一象限
    if (point.dx > originX && point.dy < originY) {
        angle = 360 - angle;
    }

    /// 第二象限
    if (point.dx < originX && point.dy < originY) {
        angle = 180 + angle;
    }

    /// 第三象限
    if (point.dx < originX && point.dy > originY) {
        angle = 180 - angle;
    }

    /// 第四象限
    if (point.dx > originX && point.dy > originY) {
        angle = angle;
    }

    return angle;
}
