import 'package:flutter/material.dart';
import 'package:easycode/code.dart';

class SensorContainer extends StatelessWidget {
  final Sensor sensor;

  SensorContainer({this.sensor});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      elevation: 0,
      color: sensor == null ? Colors.white : Colors.blue[200],
      child: Center(
        child: Text(
          sensor?.name ?? "",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
