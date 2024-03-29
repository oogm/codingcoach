import 'package:easycode/colors.dart';
import 'package:easycode/ui/code_block.dart';
import 'package:easycode/ui/sensor_badge.dart';
import 'package:flutter/material.dart';
import 'package:easycode/code.dart';

class WhileBlock extends StatelessWidget {
  final WhileStructure whileStructure;

  WhileBlock({this.whileStructure});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            margin: EdgeInsets.zero,
            color: CodeColors.whileLoop,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: SizedBox(
              height: 35,
              width: 180,
              child: Padding(
                padding: EdgeInsets.only(top: 3, bottom: 3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(width: 15),
                    Text(
                      "While",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 100,
                      child: SensorBadge(sensor: whileStructure.sensor),
                    ),
                    Spacer(),
                    Text(
                      "Do",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ),
          CodeBlock(
            code: whileStructure.code,
            barColor: CodeColors.whileLoop,
          ),
          Visibility(
            visible: whileStructure.endWhile,
            child: _buildEndWhile(),
          ),
        ],
      ),
    );
  }

  Widget _buildEndWhile() {
    return Card(
      margin: EdgeInsets.zero,
      color: CodeColors.whileLoop,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
      ),
      child: SizedBox(
        width: 180,
        height: 20,
        child: Row(
          children: <Widget>[
            SizedBox(width: 14),
            Text(
              "End While",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
