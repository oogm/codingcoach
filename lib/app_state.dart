import 'dart:collection';
import 'dart:math';

import 'package:easycode/code.dart';
import 'package:easycode/grid/grid_item.dart';
import 'package:easycode/task.dart';
import 'package:flutter/material.dart';

var gridSize = 6;

class AppState extends ChangeNotifier {
  Task _task = Task(walk: 3, turn: 2, ifelse: 2, whileLoop: 1);
  Task get task => _task;
  set task(Task task) {
    _task = task;
    notifyListeners();
  }

  List<CodeElement> _codeList = [];
  List<CodeElement> get codeList => _codeList;
  set codeList(List<CodeElement> code) {
    _codeList = code;
    notifyListeners();
  }

  CodeElement _currentEditContainer;
  CodeElement get currentEditContainer => _currentEditContainer;

  List<GridItem> _gridItems = [
    Player(x: 0, y: 0),
    Obstacle(x: 3, y: 0),
    Obstacle(x: 5, y: 4),
    Obstacle(x: 0, y: 5),
    Target(x: 2, y: 3),
  ];
  List<GridItem> get gridItems => _gridItems;
  set gridItems(List<GridItem> items) {
    _gridItems = items;
    notifyListeners();
  }

  int _count(List<CodeElement> list, String searchElement) {
    var count = 0;
    for (var e in list) {
      if (e.name == searchElement) {
        count++;
      }

      if (e is IfStructure) {
        count += _count(e.ifCode, searchElement);
        count += _count(e.elseCode, searchElement);
      }

      if (e is WhileStructure) {
        count += _count(e.code, searchElement);
      }
    }

    return count;
  }

  int availableElements(String elementName) {
    var used = _count(_codeList, elementName);
    if (elementName == "Walk") {
      return task.walk - used;
    } else if (elementName == "Turn") {
      return task.turn - used;
    } else if (elementName == "If") {
      return task.ifelse - used;
    } else if (elementName == "While") {
      return task.whileLoop - used;
    }
  }

  void addElement(CodeElement code) {
    if (_currentEditContainer == null) {
      codeList.add(code);
    } else if (_currentEditContainer is IfStructure) {
      var ifStructure = _currentEditContainer as IfStructure;
      if (!ifStructure.elseActive) {
        ifStructure.ifCode.add(code);
      } else {
        ifStructure.elseCode.add(code);
      }
    } else {
      var whileStructure = _currentEditContainer as WhileStructure;
      whileStructure.code.add(code);
    }

    if (code is IfStructure) {
      code.parent = _currentEditContainer;
      _currentEditContainer = code;
    } else if (code is WhileStructure) {
      code.parent = _currentEditContainer;
      _currentEditContainer = code;
    }
    notifyListeners();
  }

  void endIf() {
    var ifStructure = _currentEditContainer as IfStructure;
    ifStructure.endIf = true;
    _currentEditContainer = ifStructure.parent;
    notifyListeners();
  }

  void elseIf() {
    var ifStructure = _currentEditContainer as IfStructure;
    ifStructure.elseActive = true;
    notifyListeners();
  }

  void endWhile() {
    var whileStructure = _currentEditContainer as WhileStructure;
    whileStructure.endWhile = true;
    _currentEditContainer = whileStructure.parent;
    notifyListeners();
  }

  void clean() {
    _codeList = [];
    cleanGrid();
    notifyListeners();
  }

  void cleanGrid() {
    _currentEditContainer = null;
    _runListStack = null;
    _lastExecutedElement = null;
    _gridItems = [
      Player(x: 0, y: 0),
      Obstacle(x: 3, y: 0),
      Obstacle(x: 5, y: 4),
      Obstacle(x: 0, y: 5),
      Target(x: 2, y: 3),
    ];
    notifyListeners();
  }

  CodeElement _lastExecutedElement;
  //CodeElement _currentRunContainer;
  ListQueue<StackEntry> _runListStack;
  bool _hungry = true;
  //List<CodeElement> _currentRunList;

  bool execNextStep() {
    if (_runListStack == null) {
      _runListStack = ListQueue();
      _runListStack.add(StackEntry(null, _codeList));
    }

    var next = _findNextActionInContainer();
    if (next == null) {
      var lastStackElement = _runListStack.removeLast();
      if (lastStackElement.runContainer is WhileStructure) {
        var runList = _runListStack.last.runList;
        var indexOfWhile = runList.indexOf(lastStackElement.runContainer);
        if (indexOfWhile == 0) {
          _lastExecutedElement = null;
        } else {
          _lastExecutedElement = runList[indexOfWhile - 1];
        }
      } else {
        _lastExecutedElement = lastStackElement.runContainer;
      }

      if (_runListStack.isEmpty) {
        return null;
      } else {
        return execNextStep();
      }
    }

    _lastExecutedElement = next;

    if (next is Action) {
      if (next.name == "Walk") {
        var result = _walkIfPossible();
        notifyListeners();
        return result;
      } else if (next.name == "Turn") {
        getPlayer().rotation += 90;
        getPlayer().rotation = getPlayer().rotation % 360;
        notifyListeners();
      }
    } else if (next is IfStructure) {
      execIf(next);
      notifyListeners();
      return false;
    } else if (next is WhileStructure) {
      execWhile(next);
      notifyListeners();
      return false;
    }
  }

  Point _getNextWalk() {
    var player = getPlayer();
    var newX = 0;
    var newY = 0;
    if (player.rotation == 0) {
      newX = player.x;
      newY = player.y - 1;
    } else if (player.rotation == 90) {
      newX = player.x + 1;
      newY = player.y;
    } else if (player.rotation == 180) {
      newX = player.x;
      newY = player.y + 1;
    } else if (player.rotation == 270) {
      newX = player.x - 1;
      newY = player.y;
    }

    return Point(newX, newY);
  }

  bool _walkIfPossible() {
    var player = getPlayer();
    var nextPoint = _getNextWalk();
    if (nextPoint.x < 0 || nextPoint.x > gridSize - 1 || nextPoint.y < 0 || nextPoint.y > gridSize - 1) {
      return null;
    }
    var item = getItemAt(nextPoint.x, nextPoint.y);
    bool result;
    if (item == null) {
      result = false;
    } else if (item is Obstacle) {
      result = null;
    } else {
      _hungry = false;
      result = true;
    }

    if (result != null) {
      player.x = nextPoint.x;
      player.y = nextPoint.y;
    }

    return result;
  }

  void execIf(IfStructure ifStructure) {
    var sensorValue = _execSensor(ifStructure.sensor);
    if (sensorValue) {
      if (ifStructure.ifCode.isNotEmpty) {
        _runListStack.add(StackEntry(ifStructure, ifStructure.ifCode));
        _lastExecutedElement = null;
      }
    } else {
      if (ifStructure.elseCode.isNotEmpty) {
        _runListStack.add(StackEntry(ifStructure, ifStructure.elseCode));
        _lastExecutedElement = null;
      }
    }
  }

  void execWhile(WhileStructure whileStructure) {
    var sensorValue = _execSensor(whileStructure.sensor);
    if (sensorValue) {
      if (whileStructure.code.isNotEmpty) {
        _runListStack.add(StackEntry(whileStructure, whileStructure.code));
        _lastExecutedElement = null;
      }
    }
  }

  bool _execSensor(Sensor sensor) {
    if (sensor.name == "Hungry") {
      return _hungry;
    } else {
      var nextPoint = _getNextWalk();
      if (nextPoint.x < 0 || nextPoint.x > gridSize - 1 || nextPoint.y < 0 || nextPoint.y > gridSize - 1) {
        return true;
      }
      var item = getItemAt(nextPoint.x, nextPoint.y);
      return item != null && item is Obstacle;
    }
  }

  GridItem getItemAt(int x, int y) {
    var items = _gridItems.where((it) => it.x == x && it.y == y);
    if (items.isNotEmpty) {
      return items.first;
    } else {
      return null;
    }
  }

  Player getPlayer() {
    return _gridItems.firstWhere((it) => it is Player) as Player;
  }

  CodeElement _findNextActionInContainer() {
    var runList = _runListStack.last.runList;
    var index = runList.indexOf(_lastExecutedElement);
    if (index >= runList.length - 1) {
      return null;
    } else {
      return runList[index + 1];
    }
  }
}

class StackEntry {
  List<CodeElement> runList;
  CodeElement runContainer;

  StackEntry(this.runContainer, this.runList);
}
