import 'package:easycode/app_state.dart';
import 'package:easycode/code.dart';
import 'package:easycode/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlockReservoir extends StatefulWidget {
  @override
  _BlockReservoirState createState() => _BlockReservoirState();
}

class _BlockReservoirState extends State<BlockReservoir> {
  List<CodeElement> code;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, app) {
        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Available Blocks",
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 10),
                _buildActionButton(app, Action(name: "Walk"), 4),
                SizedBox(height: 10),
                _buildIfButton(app, 2),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(AppState app, Action action, int amount) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 150,
          child: RaisedButton(
            onPressed: () {
              var list = app.codeList;
              list.add(action);
              app.codeList = list;
            },
            color: CodeColors.action,
            child: Text(
              action.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(width: 10),
        Text("${amount}x"),
      ],
    );
  }

  Widget _buildIfButton(AppState app, int amount) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 150,
          child: RaisedButton(
            onPressed: () {},
            color: CodeColors.ifElse,
            child: Text(
              "If / Else",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(width: 10),
        Text("${amount}x"),
      ],
    );
  }
}
