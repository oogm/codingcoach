abstract class CodeElement {
  final String name;
  bool currentLine;

  CodeElement({this.name});
}

class Sensor extends CodeElement {
  Sensor({String name}) : super(name: name);
}

class Action extends CodeElement {
  Action({String name}) : super(name: name);
}

class IfStructure extends CodeElement {
  final Sensor sensor;
  final ifCode = List<CodeElement>();
  final elseCode = List<CodeElement>();
  bool elseActive = false;
  bool endIf = false;
  CodeElement parent;

  IfStructure({this.sensor, this.parent}) : super(name: "If");
}

class WhileStructure extends CodeElement {
  Sensor sensor;
  var code = List<CodeElement>();
  bool endWhile = false;
  CodeElement parent;

  WhileStructure({this.sensor, this.parent}) : super(name: "While");
}
