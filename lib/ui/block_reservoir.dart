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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            Visibility(
              visible: app.availableElements("Walk") > 0,
              child: _buildActionButton(app, "Walk"),
            ),
            Visibility(
              visible: app.availableElements("Turn") > 0,
              child: _buildActionButton(app, "Turn"),
            ),
            _buildIfButton(app),
            _buildIfActionButtons(app),
            Visibility(
              visible: app.availableElements("While") > 0,
              child: _buildWhileButton(app),
            ),
            _buildWhileActionButton(app),
          ],
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
                  whileSensorSelection = false;
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
          whileSensorSelection = false;
        });
      }),
    );
  }

  Widget _buildIfActionButtons(AppState app) {
    if (app.currentEditContainer?.name != "If") {
      return Container();
    }

    var ifStructure = app.currentEditContainer as IfStructure;
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

  Widget _buildWhileButton(AppState app) {
    return Visibility(
      visible: !whileSensorSelection,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  whileSensorSelection = true;
                  ifSensorSelection = false;
                });
              },
              color: CodeColors.whileLoop,
              child: Text(
                "While",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 10),
          Text("${app.availableElements("While")}x"),
        ],
      ),
      replacement: _buildSensorSelection((sensor) {
        app.addElement(WhileStructure(sensor: sensor));
        setState(() {
          whileSensorSelection = false;
        });
      }),
    );
  }

  Widget _buildWhileActionButton(AppState app) {
    if (app.currentEditContainer?.name != "While") {
      return Container();
    }

    return SizedBox(
      width: 100,
      child: RaisedButton(
        onPressed: () {
          app.endWhile();
          setState(() {
            whileSensorSelection = false;
          });
        },
        color: CodeColors.whileLoop,
        child: Text(
          "End While",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
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
