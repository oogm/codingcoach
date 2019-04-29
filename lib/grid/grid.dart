import 'package:easycode/app_state.dart';
import 'package:easycode/grid/grid_item.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridSize,
        ),
        itemBuilder: _buildGridItems,
        itemCount: gridSize * gridSize,
      ),
    );
  }

  Widget _buildGridItems(BuildContext context, int index) {
    var x = (index % gridSize);
    var y = (index / gridSize).floor();
    return Consumer<AppState>(
      builder: (context, app) {
        var items = app.gridItems.where((it) => it.x == x && it.y == y).toList();
        var item = items.isNotEmpty ? items.first : null;
        return GridTile(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            child: Center(
              child: Visibility(
                visible: item != null,
                child: _buildGridItem(app, item),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridItem(AppState app, GridItem item) {
    if (item is Player) {
      return RotatedBox(
        quarterTurns: app.getPlayer().rotation ~/ 90 - 1,
        child: Icon(
          Icons.arrow_forward_ios,
          size: 30,
          color: Colors.red,
        ),
      );
    } else if (item is Obstacle) {
      return Container(
        color: Colors.grey,
      );
    } else if (item is Target) {
      return Icon(
        Icons.flag,
        size: 30,
        color: Colors.blue,
      );
    } else {
      return Container();
    }
    /*switch (gridState[x][y]) {
      case '':
        return Text('');
        break;

      case 'P1':
        return Container(
          color: Colors.blue,
        );
        break;

      case 'P2':
        return Container(
          color: Colors.yellow,
        );
        break;

      case 'T':
        return Icon(
          Icons.terrain,
          size: 40.0,
          color: Colors.red,
        );
        break;

      case 'B':
        return Icon(Icons.remove_red_eye, size: 40.0);
        break;

      default:
        return Text(gridState[x][y].toString());
    }*/
  }
}
