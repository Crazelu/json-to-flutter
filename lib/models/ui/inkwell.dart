import 'package:flutter/material.dart';
import 'package:json_to_flutter/constants/constants.dart';
import 'package:json_to_flutter/models/api/request.dart';
import 'package:json_to_flutter/utils/json_ui_utils.dart';
import 'package:json_to_flutter/utils/method_channel.dart';

class JsonInkWell {
  final Widget child;
  final Color splashColor;
  final ApiRequest? requestParams;

  JsonInkWell(
      {required this.child,
      this.splashColor: kButtonSplashColor,
      this.requestParams});

  factory JsonInkWell.fromJson(Map<String, dynamic> json) {
    return JsonInkWell(
        child: JsonUIUtils.getWidgetFromJson(json['child']),
        splashColor: Color(int.tryParse(json['splashColor'] ?? '') ??
            kButtonSplashColor.value),
        requestParams: ApiRequest.fromJson(json['requestParams']));
  }

  Widget toWidget() => InkWell(
      splashColor: splashColor,
      onTap: () {
        JsonMethodChannel().invokeMethod(kMakeRequest, params: requestParams);
      },
      child: child);
}
