import 'package:flutter/material.dart';
import 'package:json_to_flutter/constants/constants.dart';
import 'package:json_to_flutter/utils/json_ui_utils.dart';

class JsonExpanded {
  final Widget child;
  final int flex;

  JsonExpanded({required this.child, this.flex: kDefaultFlex});

  factory JsonExpanded.fromJson(Map<String, dynamic> json) {
    return JsonExpanded(
        child: JsonUIUtils.getWidgetFromJson(json['child']),
        flex: json['flex'] ?? kDefaultFlex);
  }

  Widget toWidget() {
    return Expanded(flex: flex, child: child);
  }
}
