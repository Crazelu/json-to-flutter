import 'package:flutter/material.dart';

class JsonImage {
  final Size size;
  final String imageUrl;
  final String overlayText;
  final double verticalPadding;

  JsonImage(this.imageUrl, this.size,
      {this.overlayText: '', this.verticalPadding: 0});

  factory JsonImage.fromJson(Map<String, dynamic> json) {
    return JsonImage(
        json['imageUrl'], Size(json['size']['width'], json['size']['height']),
        overlayText: json['displayText'] ?? '',
        verticalPadding: json["verticalPadding"] ?? 0);
  }

  Widget toWidget() {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(imageUrl))),
      child: Text(overlayText),
    );
  }
}
