import 'package:easycode/ui/block_reservoir.dart';
import 'package:easycode/ui/exec_screen.dart';
import 'package:flutter/material.dart';

class ControlPanel extends StatefulWidget {
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  bool runScreen = false;

  @override
  Widget build(BuildContext context) {
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
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  runScreen ? "Run Code" : "Available Blocks",
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: runScreen ? ExecScreen() : BlockReservoir(),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  runScreen = !runScreen;
                });
              },
              icon: Icon(runScreen ? Icons.code : Icons.map),
            )
          ],
        ),
      ),
    );
  }
}
