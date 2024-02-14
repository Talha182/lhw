import 'package:flutter/material.dart';

class ImageHotspotModel {
  final String imagePath;
  final List<HotspotData> hotspots;

  ImageHotspotModel({required this.imagePath, required this.hotspots});

  factory ImageHotspotModel.fromJson(Map<String, dynamic> json) {
    return ImageHotspotModel(
      imagePath: json['imagePath'],
      hotspots: List<HotspotData>.from(json['hotspots'].map((x) => HotspotData.fromJson(x))),
    );
  }
}

class HotspotData {
  final String dialogText;
  final Offset offset;

  HotspotData({required this.dialogText, required this.offset});

  factory HotspotData.fromJson(Map<String, dynamic> json) {
    double dx = (json['offset']['dx'] != null) ? json['offset']['dx'].toDouble() : 0.0;
    double dy = (json['offset']['dy'] != null) ? json['offset']['dy'].toDouble() : 0.0;

    return HotspotData(
      dialogText: json['dialogText'],
      offset: Offset(dx, dy),
    );
  }
}
