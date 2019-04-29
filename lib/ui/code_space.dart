import 'package:easycode/app_state.dart';
import 'package:easycode/code.dart';
import 'package:easycode/ui/action_block.dart';
import 'package:easycode/ui/code_block.dart';
import 'package:easycode/ui/if_else_block.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CodeSpace extends StatefulWidget {
  @override
  _CodeSpaceState createState() => _CodeSpaceState();
}

class _CodeSpaceState extends State<CodeSpace> {
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildCode(app),
                    reverse: true,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    app.clean();
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCode(AppState app) {
    return CodeBlock(
      code: app.codeList,
    );
    /*return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IfElseBlock(
          ifStructure: IfStructure()
            ..sensor = Sensor(name: "Wall")
            ..ifCode = []
            ..elseCode = [Action(name: "Sleep")]
            ..endIf = true,
        ),
        ActionBlock(
          action: Action(name: "Walk"),
        )
      ],
    );*/
  }
}
