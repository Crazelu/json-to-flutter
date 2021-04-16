import 'package:flutter/material.dart';
import 'package:json_to_flutter/utils/json_ui_utils.dart';

class JsonListView {
  final List<Widget> children;

  JsonListView({required this.children});

  factory JsonListView.fromJson(Map<String, dynamic> json) {
    return JsonListView(children: JsonUIUtils.getWidgets(json['children']));
  }

  Widget toWidget() => ListView(children: children);
}
