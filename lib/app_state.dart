import 'package:easycode/code.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  List<CodeElement> _codeList = [];
  List<CodeElement> get codeList => _codeList;
  set codeList(List<CodeElement> code) {
    _codeList = code;
    notifyListeners();
  }
}
