import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lc_paint/lc_paint.dart';

class Draw extends StatefulWidget {
  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  PaintType _type = PaintType.doughnut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LCCustomPaint(
              size: Size(180, 180),
              paintModels: _getModels(),
              paintType: _type,
              clickedAtIndex: (index, model) {
                showDialog(
                  context: context,
                  barrierDismissible: false, //// user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('提示'),
                      content: Container(
                        child: Text('点击了: $index，占比：${model.proportion}'),
                      ),
                      actions: [
                        RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('确定'),
                        )
                      ],
                    );
                  },
                );
              },
            ),
            _switchItem('扇形', PaintType.pie),
            _switchItem('环形', PaintType.doughnut),
          ],
        ),
      ),
    );
  }

  Widget _switchItem(String title, PaintType type) {
    return GestureDetector(
      child: Container(
        height: 40,
        padding: EdgeInsets.only(left: 15, right: 30),
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(title),
            Container(width: 10),
            Icon(Icons.adjust_outlined, color: type == _type ? Colors.blue : Colors.grey),
          ],
        ),
      ),
      onTapUp: (details) {
        if (type != _type) {
          _type = type;
          setState(() {});
        }
      },
    );
  }

  _getModels() {
    return [
      LCPaintModel(proportion: 25, arcColor: _randomColor()),
      LCPaintModel(proportion: 0.1, arcColor: _randomColor()),
      LCPaintModel(proportion: 19.9, arcColor: _randomColor()),
      LCPaintModel(proportion: 15, arcColor: _randomColor()),
      LCPaintModel(proportion: 29.5, arcColor: _randomColor()),
      LCPaintModel(proportion: 0.5, arcColor: _randomColor()),
      LCPaintModel(proportion: 10, arcColor: _randomColor()),
    ];
  }

  Color _randomColor() {
    return Color.fromRGBO(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), 1);
  }
}
