import 'package:easycode/app_state.dart';
import 'package:easycode/code.dart';
import 'package:easycode/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef void SensorCallback(Sensor sensor);

class BlockReservoir extends StatefulWidget {
  @override
  _BlockReservoirState createState() => _BlockReservoirState();
}

class _BlockReservoirState extends State<BlockReservoir> {
  bool ifSensorSelection = false;
  bool whileSensorSelection = false;

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
                Visibility(
                  visible: app.availableElements("Walk") > 0,
                  child: _buildActionButton(app, "Walk"),
                ),
                Visibility(
                  visible: app.availableElements("Turn") > 0,
                  child: _buildActionButton(app, "Turn"),
                ),
                Visibility(
                  visible: app.availableElements("If") > 0,
                  child: _buildIfButton(app),
                ),
                _buildIfActionButtons(app)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(AppState app, String action) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 150,
          child: RaisedButton(
            onPressed: () {
              app.addElement(Action(name: action));
            },
            color: CodeColors.action,
            child: Text(
              action,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(width: 10),
        Text("${app.availableElements(action)}x"),
      ],
    );
  }

  Widget _buildIfButton(AppState app) {
    return Visibility(
      visible: !ifSensorSelection,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  ifSensorSelection = true;
                });
              },
              color: CodeColors.ifElse,
              child: Text(
                "If / Else",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 10),
          Text("${app.availableElements("If")}x"),
        ],
      ),
      replacement: _buildSensorSelection((sensor) {
        app.addElement(IfStructure(sensor: sensor));
        setState(() {
          ifSensorSelection = false;
        });
      }),
    );
  }

  Widget _buildIfActionButtons(AppState app) {
    if (app.currentContainer?.name != "If") {
      return Container();
    } else {
      var ifStructure = app.currentContainer as IfStructure;
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: !ifStructure.elseActive,
            child: SizedBox(
              width: 100,
              child: RaisedButton(
                onPressed: () {
                  app.elseIf();
                  setState(() {
                    ifSensorSelection = false;
                  });
                },
                color: CodeColors.ifElse,
                child: Text(
                  "Else",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 100,
            child: RaisedButton(
              onPressed: () {
                app.endIf();
                setState(() {
                  ifSensorSelection = false;
                });
              },
              color: CodeColors.ifElse,
              child: Text(
                "End If",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildSensorSelection(SensorCallback callback) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RaisedButton(
            child: new Text("Hungry"),
            color: CodeColors.sensor,
            onPressed: () {
              callback(Sensor(name: "Hungry"));
            },
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))),
        SizedBox(width: 10),
        RaisedButton(
            child: new Text("Wall Ahead"),
            color: CodeColors.sensor,
            onPressed: () {
              callback(Sensor(name: "Wall Ahead"));
            },
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)))
      ],
    );
  }
}
