
import 'dart:math';

extension NumExtension on num {

    /// 角度转弧度
    toRadian() {
        return this * pi / 180;
    }
    /// 弧度转角度
    toAngle() {
        return this * 180 / pi;
    }

}