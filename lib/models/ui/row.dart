import 'package:flutter/material.dart';
import 'package:json_to_flutter/utils/json_ui_utils.dart';

class JsonRow {
  final List<Widget> children;
  final double verticalPadding;
  final double horizontalSpacing;

  JsonRow(
      {required this.children,
      this.verticalPadding: 0,
      this.horizontalSpacing: 10});

  factory JsonRow.fromJson(Map<String, dynamic> json) {
    return JsonRow(
        children: JsonUIUtils.getWidgets(json['children']),
        verticalPadding: json["verticalPadding"] ?? 0,
        horizontalSpacing: json["horizontalSpacing"] ?? 0);
  }

  Widget toWidget() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: horizontalSpacing,
      runSpacing: horizontalSpacing,
      children: children,
    );
  }
}
