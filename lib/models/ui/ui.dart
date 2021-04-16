import 'package:flutter/material.dart';
import 'package:json_to_flutter/constants/constants.dart';
import 'package:json_to_flutter/utils/json_ui_utils.dart';

class JsonUI {
  final Color backgroundColor;
  final Color dismissButtonColor;
  final Color dismissIconColor;
  final bool shouldShowDismiss;
  final Widget widget;

  JsonUI(
      {this.backgroundColor: kPrimaryColorDark,
      this.dismissIconColor: kPrimaryColorLight,
      this.dismissButtonColor: kButtonSplashColor,
      this.shouldShowDismiss: true,
      this.widget: const SizedBox()});

  factory JsonUI.fromJson(Map<String, dynamic> json) {
    return JsonUI(
        backgroundColor: Color(int.tryParse(json['backgroundColor'] ?? '') ??
            kPrimaryColorLight.value),
        dismissButtonColor: Color(
            int.tryParse(json['dismissButtonColor'] ?? '') ??
                kButtonSplashColor.value),
        dismissIconColor: Color(int.tryParse(json['dismissIconColor'] ?? '') ??
            kPrimaryColorLight.value),
        shouldShowDismiss: json['shouldShowDismiss'] ?? true,
        widget: JsonUIUtils.getWidgetFromJson(json));
  }
}
