import 'package:easycode/code.dart';
import 'package:easycode/colors.dart';
import 'package:flutter/material.dart';

class ActionBlock extends StatelessWidget {
  final CodeElement action;

  ActionBlock({this.action});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CodeColors.action,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: SizedBox(
        width: 150,
        height: 25,
        child: Center(
          child: Text(
            action.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
