import 'package:flutter/material.dart';

class JsonImage {
  final Size size;
  final String imageUrl;
  final String overlayText;
  final double verticalPadding;
  final double borderRadius;

  JsonImage(this.imageUrl, this.size,
      {this.overlayText: '', this.verticalPadding: 0, this.borderRadius: 0});

  factory JsonImage.fromJson(Map<String, dynamic> json) {
    return JsonImage(
      json['imageUrl'],
      Size(json['size']['width'], json['size']['height']),
      overlayText: json['displayText'] ?? '',
      verticalPadding: json["verticalPadding"] ?? 0,
      borderRadius: json["borderRadius"] ?? 0,
    );
  }

  Widget toWidget() {
    return Container(
      alignment: Alignment.bottomLeft,
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(imageUrl))),
      child: Text(overlayText),
    );
  }
}
