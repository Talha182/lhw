import 'package:flutter/material.dart';

class ImageHotspotModel {
  final List<ImageData> images;
  int currentIndex;

  ImageHotspotModel({required this.images, this.currentIndex = 0});

  factory ImageHotspotModel.fromJson(Map<String, dynamic> json) {
    return ImageHotspotModel(
      images: List<ImageData>.from(json['images'].map((x) => ImageData.fromJson(x))),
      currentIndex: json['currentIndex'] ?? 0,
    );
  }
}

class ImageData {
  final String imagePath;
  final List<HotspotData> hotspots;

  ImageData({required this.imagePath, required this.hotspots});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      imagePath: json['imagePath'],
      hotspots: List<HotspotData>.from(json['hotspots'].map((x) => HotspotData.fromJson(x))),
    );
  }
}

class HotspotData {
  final String dialogText;
  final Offset offset;
  bool isTapped;

  HotspotData({required this.dialogText, required this.offset, this.isTapped = false});

  factory HotspotData.fromJson(Map<String, dynamic> json) {
    double dx = json['offset']['dx']?.toDouble() ?? 0.0;
    double dy = json['offset']['dy']?.toDouble() ?? 0.0;
    return HotspotData(
      dialogText: json['dialogText'],
      offset: Offset(dx, dy),
      isTapped: json['isTapped'] ?? false,
    );
  }
}
