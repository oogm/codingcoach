import 'package:easycode/code.dart';
import 'package:easycode/task.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  Task _task = Task(walk: 3, turn: 2, ifelse: 3, whileLoop: 4);
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

  CodeElement _currentContainer;
  CodeElement get currentContainer => _currentContainer;

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
    if (_currentContainer == null) {
      codeList.add(code);
    } else if (_currentContainer is IfStructure) {
      var ifStructure = _currentContainer as IfStructure;
      if (!ifStructure.elseActive) {
        ifStructure.ifCode.add(code);
      } else {
        ifStructure.elseCode.add(code);
      }
    } else {
      var whileStructure = _currentContainer as WhileStructure;
      whileStructure.code.add(code);
    }

    if (code is IfStructure) {
      code.parent = _currentContainer;
      _currentContainer = code;
    } else if (code is WhileStructure) {
      code.parent = _currentContainer;
      _currentContainer = code;
    }
    notifyListeners();
  }

  void endIf() {
    var ifStructure = _currentContainer as IfStructure;
    ifStructure.endIf = true;
    _currentContainer = ifStructure.parent;
    notifyListeners();
  }

  void elseIf() {
    var ifStructure = _currentContainer as IfStructure;
    ifStructure.elseActive = true;
    notifyListeners();
  }

  void endWhile() {
    var whileStructure = _currentContainer as WhileStructure;
    whileStructure.endWhile = true;
    _currentContainer = whileStructure.parent;
    notifyListeners();
  }

  void clean() {
    _codeList = [];
    _currentContainer = null;
    notifyListeners();
  }
}
