import 'package:easycode/app_state.dart';
import 'package:easycode/grid/grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExecScreen extends StatefulWidget {
  @override
  _ExecScreenState createState() => _ExecScreenState();
}

class _ExecScreenState extends State<ExecScreen> {
  bool running = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Grid(),
          ),
        ),
        Consumer<AppState>(builder: (context, app) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: !running,
                child: IconButton(
                  onPressed: () {
                    var result = app.execNextStep();
                    print("RESULT " + result.toString());
                    /*setState(() {
                    running = true;
                  });*/
                  },
                  icon: Icon(Icons.play_arrow),
                  iconSize: 40,
                  color: Colors.green,
                ),
              ),
              Visibility(
                visible: running,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      running = false;
                    });
                  },
                  icon: Icon(Icons.stop),
                  iconSize: 40,
                  color: Colors.red,
                ),
              )
            ],
          );
        }),
      ],
    );
  }
}
