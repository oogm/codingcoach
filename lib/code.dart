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
  Sensor sensor;
  var ifCode = List<CodeElement>();
  var elseCode = List<CodeElement>();
  bool endIf;

  IfStructure() : super(name: "if");
}

class WhileStructure extends CodeElement {
  Sensor sensor;
  var code = List<CodeElement>();

  WhileStructure() : super(name: "while");
}
