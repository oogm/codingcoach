import 'package:easycode/colors.dart';
import 'package:easycode/ui/code_block.dart';
import 'package:easycode/ui/sensor_badge.dart';
import 'package:flutter/material.dart';
import 'package:easycode/code.dart';

class IfElseBlock extends StatelessWidget {
  final IfStructure ifStructure;

  IfElseBlock({this.ifStructure});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          margin: EdgeInsets.zero,
          color: CodeColors.ifElse,
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
                    "if",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 80,
                    child: SensorBadge(sensor: ifStructure.sensor),
                  ),
                  Spacer(),
                  Text(
                    "then",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ),
        CodeBlock(
          code: ifStructure.ifCode,
          barColor: CodeColors.ifElse,
        ),
        Visibility(
          visible: ifStructure.elseCode.isNotEmpty,
          child: _buildElse(),
        ),
        Visibility(
          visible: ifStructure.endIf,
          child: _buildEndIf(),
        ),
      ],
    );
  }

  Widget _buildElse() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          margin: EdgeInsets.zero,
          color: CodeColors.ifElse,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          child: SizedBox(
            width: 70,
            height: 20,
            child: Row(
              children: <Widget>[
                SizedBox(width: 14),
                Text(
                  "else",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        CodeBlock(
          code: ifStructure.elseCode,
          barColor: CodeColors.ifElse,
        ),
      ],
    );
  }

  Widget _buildEndIf() {
    return Card(
      margin: EdgeInsets.zero,
      color: CodeColors.ifElse,
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
              "end if",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
