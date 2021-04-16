import 'package:flutter/material.dart';
import 'package:json_to_flutter/models/ui/button.dart';
import 'package:json_to_flutter/models/ui/center.dart';
import 'package:json_to_flutter/models/ui/column.dart';
import 'package:json_to_flutter/models/ui/expanded.dart';
import 'package:json_to_flutter/models/ui/image.dart';
import 'package:json_to_flutter/models/ui/listview.dart';
import 'package:json_to_flutter/models/ui/padding.dart';
import 'package:json_to_flutter/models/ui/row.dart';
import 'package:json_to_flutter/models/ui/spacer.dart';
import 'package:json_to_flutter/models/ui/text.dart';
import 'package:json_to_flutter/models/ui/vertical_spacer.dart';

class JsonUIUtils {
  static List<Widget> getWidgets(List json) {
    List<Widget> widgets = <Widget>[];

    for (var widget in json) {
      widgets.add(getWidgetFromJson(widget));
    }

    return widgets;
  }

  static Widget getWidgetFromJson(Map<String, dynamic>? json) {
    if (json == null) return Container();
    switch (json['type']) {
      case 'image':
        return JsonImage.fromJson(json).toWidget();
      case 'button':
        return JsonButton.fromJson(json).toWidget();
      case 'text':
        return JsonText.fromJson(json).toWidget();
      case 'row':
        return JsonRow.fromJson(json).toWidget();
      case 'listView':
        return JsonListView.fromJson(json).toWidget();
      case 'column':
        return JsonColumn.fromJson(json).toWidget();
      case 'expanded':
        return JsonExpanded.fromJson(json).toWidget();
      case 'verticalSpacer':
        return JsonVerticalSpacer.fromJson(json).toWidget();
      case 'spacer':
        return JsonSpacer.fromJson(json).toWidget();
      case 'center':
        return JsonCenter.fromJson(json).toWidget();
      case 'padding':
        return JsonPadding.fromJson(json).toWidget();

      default:
        return Container();
    }
  }
}
