import 'package:flutter/material.dart';
import 'package:json_to_flutter/utils/json_ui_utils.dart';

class JsonColumn {
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final double verticalPadding;

  JsonColumn(
      {required this.children,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.verticalPadding: 0});

  factory JsonColumn.fromJson(Map<String, dynamic> json) {
    return JsonColumn(
        children: JsonUIUtils.getWidgets(json['widgets']),
        mainAxisAlignment: _getAlignment(true, json['alignment']),
        crossAxisAlignment: _getAlignment(false, json['alignment']),
        verticalPadding: json['verticalPadding'] ?? 0);
  }

  static _getAlignment(bool isMainAxisAlignment, String? alignment) {
    switch (alignment) {
      case 'start':
        if (isMainAxisAlignment) return MainAxisAlignment.start;
        return CrossAxisAlignment.start;
      case 'center':
        if (isMainAxisAlignment) return MainAxisAlignment.center;
        return CrossAxisAlignment.center;
      case 'end':
        if (isMainAxisAlignment) return MainAxisAlignment.end;
        return CrossAxisAlignment.end;
      case 'spaceEvenly':
        return MainAxisAlignment.spaceEvenly;
      case 'baseline':
        return CrossAxisAlignment.baseline;
      case 'stretch':
        return CrossAxisAlignment.stretch;
      case 'spaceAround':
        return MainAxisAlignment.spaceAround;
      case 'spaceBetween':
        return MainAxisAlignment.spaceBetween;

      default:
    }
  }

  Widget toWidget() {
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: children,
    );
  }
}
