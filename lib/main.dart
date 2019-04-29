import 'package:easycode/app_state.dart';
import 'package:easycode/ui/action_block.dart';
import 'package:easycode/ui/block_reservoir.dart';
import 'package:easycode/ui/code_space.dart';
import 'package:easycode/ui/if_else_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easycode/code.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

var appState = AppState();

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
          child: ChangeNotifierProvider<AppState>.value(
            notifier: appState,
            child: MyHomePage(),
          ),
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
            child: BlockReservoir(),
          ),
        ),
      ],
    );
  }
}
