import 'package:easycode/app_state.dart';
import 'package:easycode/code.dart';
import 'package:easycode/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionBlock extends StatelessWidget {
  final CodeElement action;

  ActionBlock({this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 2, bottom: 2),
          child: Card(
            margin: EdgeInsets.zero,
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
          ),
        ),

        /*Consumer<AppState>(builder:(context, app) {
          return Visibility(visible: app.lastExecutedElement == ,)
        })*/
      ],
    );
  }
}
