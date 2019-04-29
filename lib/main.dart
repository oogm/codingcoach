import 'package:easycode/ui/action_block.dart';
import 'package:easycode/ui/if_else_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easycode/code.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        backgroundColor: Color(0xFFEEEEEE),
        scaffoldBackgroundColor: Color(0xFFEEEEEE),
        textTheme: TextTheme(
          subhead: TextStyle(
            fontSize: 20.0,
            color: Color(0xFF424242),
          ),
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: CodeSpace(),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Reservoir(),
          ),
        ),
      ],
    );
  }
}

class CodeSpace extends StatefulWidget {
  @override
  _CodeSpaceState createState() => _CodeSpaceState();
}

class _CodeSpaceState extends State<CodeSpace> {
  List<CodeElement> code;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
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
          )),
    );
  }
}

class Reservoir extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //Draggable(
        //child: WalkBlock(),
        //feedback: WalkBlock(),
        //)
      ],
    );
  }
}
