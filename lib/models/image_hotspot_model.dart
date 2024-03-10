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
  final String title;
  final List<HotspotData> hotspots;

  ImageData({required this.imagePath, required this.hotspots,required this.title});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      imagePath: json['imagePath'] ?? '',
      title: json['title'] ?? '',
      hotspots: List<HotspotData>.from(json['hotspots'].map((x) => HotspotData.fromJson(x))),
    );
  }
}

class HotspotData {
  final String title;
  final String dialogText;
  final Offset offset;
  bool isTapped;

  HotspotData({required this.dialogText,required this.title ,required this.offset, this.isTapped = false});

  factory HotspotData.fromJson(Map<String, dynamic> json) {
    double dx = json['offset']['dx']?.toDouble() ?? 0.0;
    double dy = json['offset']['dy']?.toDouble() ?? 0.0;
    return HotspotData(
      title: json['title'] ?? '',
      dialogText: json['dialogText'],
      offset: Offset(dx, dy),
      isTapped: json['isTapped'] ?? false,
    );
  }
}
