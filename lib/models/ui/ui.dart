import 'package:flutter/material.dart';
import 'package:json_to_flutter/constants/constants.dart';
import 'package:json_to_flutter/models/ui/button.dart';
import 'package:json_to_flutter/models/ui/image.dart';
import 'package:json_to_flutter/models/ui/text.dart';

class JsonUI {
  final Color backgroundColor;
  final Color dismissButtonColor;
  final bool shouldShowDismiss;
  final bool isDismissWithBackbuttonEnabled;
  final String dismissErrorMessage;
  final List<Widget> widgets;

  JsonUI(
      {this.backgroundColor: kPrimaryColorDark,
      this.dismissButtonColor: kButtonSplashColor,
      this.shouldShowDismiss: true,
      this.isDismissWithBackbuttonEnabled: true,
      this.dismissErrorMessage: "Action required",
      this.widgets: const <Widget>[]});

  factory JsonUI.fromJson(Map<String, dynamic> json) {
    return JsonUI(
        backgroundColor: Color(
            int.tryParse(json['backgroundColor']) ?? kPrimaryColorLight.value),
        dismissButtonColor: Color(int.tryParse(json['dismissButtonColor']) ??
            kButtonSplashColor.value),
        isDismissWithBackbuttonEnabled: json['isDismissWithBackbuttonEnabled'],
        shouldShowDismiss: json['shouldShowDismiss'],
        dismissErrorMessage: json['dismissErrorMessage'],
        widgets: _getWidgets(json['widgets']));
  }

  static List<Widget> _getWidgets(List json) {
    List<Widget> widgets = <Widget>[];

    for (var i in json) {
      i = Map<String, dynamic>.from(i);
      switch (i['widget']) {
        case 'image':
          JsonImage image = JsonImage.fromJson(i['schema']);
          widgets.add(image.toWidget());
          widgets.add(SizedBox(height: image.verticalPadding));

          break;
        case 'button':
          JsonButton button = JsonButton.fromJson(i['schema']);
          widgets.add(button.toWidget());
          widgets.add(SizedBox(height: button.verticalPadding));
          break;
        case 'text':
          widgets.add(JsonText.fromJson(i['schema']).toWidget());

          break;
        default:
      }
    }

    return widgets;
  }
}
