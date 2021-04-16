import 'package:flutter/material.dart';
import 'package:json_to_flutter/models/ui/button.dart';
import 'package:json_to_flutter/models/ui/column.dart';
import 'package:json_to_flutter/models/ui/image.dart';
import 'package:json_to_flutter/models/ui/row.dart';
import 'package:json_to_flutter/models/ui/text.dart';

class JsonUIUtils {
  static List<Widget> getWidgets(List json) {
    List<Widget> widgets = <Widget>[];

    for (var widget in json) {
      widget = Map<String, dynamic>.from(widget);
      switch (widget['widget']) {
        case 'image':
          JsonImage image = JsonImage.fromJson(widget['schema']);
          widgets.add(image.toWidget());
          widgets.add(SizedBox(height: image.verticalPadding));

          break;
        case 'button':
          JsonButton button = JsonButton.fromJson(widget['schema']);
          widgets.add(button.toWidget());
          widgets.add(SizedBox(height: button.verticalPadding));
          break;
        case 'text':
          widgets.add(JsonText.fromJson(widget['schema']).toWidget());

          break;
        case 'row':
          JsonRow row = JsonRow.fromJson(widget['schema']);
          widgets.add(row.toWidget());
          widgets.add(SizedBox(height: row.verticalPadding));
          break;
        case 'column':
          JsonColumn column = JsonColumn.fromJson(widget['schema']);
          widgets.add(column.toWidget());
          widgets.add(SizedBox(height: column.verticalPadding));
          break;
        default:
      }
    }

    return widgets;
  }
}
