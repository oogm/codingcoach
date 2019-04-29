import 'package:easycode/ui/action_block.dart';
import 'package:easycode/ui/if_else_block.dart';
import 'package:flutter/material.dart';
import 'package:easycode/code.dart';

class CodeBlock extends StatelessWidget {
  final List<CodeElement> code;
  final Color barColor;

  CodeBlock({this.code, this.barColor});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Visibility(
            visible: barColor != null,
            child: Container(
              color: barColor,
              width: 15,
            ),
          ),
          Visibility(
            visible: code.isNotEmpty,
            child: _buildCode(),
            replacement: SizedBox(
              height: 20,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCode() {
    var codeWidgets = code.map(_buildCodeElement).toList();
    return Padding(
      padding: barColor != null ? EdgeInsets.all(2.0) : EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: codeWidgets,
      ),
    );
  }

  Widget _buildCodeElement(CodeElement element) {
    if (element is IfStructure) {
      return IfElseBlock(ifStructure: element);
    } else if (element is Action) {
      return ActionBlock(action: element);
    } else {
      return Container();
    }
  }
}
