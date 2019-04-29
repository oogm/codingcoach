import 'package:easycode/colors.dart';
import 'package:flutter/material.dart';
import 'package:easycode/code.dart';

class SensorBadge extends StatelessWidget {
  final Sensor sensor;

  SensorBadge({this.sensor});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      elevation: 0,
      color: sensor == null ? Colors.white : CodeColors.sensor,
      child: Center(
        child: Text(
          sensor?.name ?? "",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
