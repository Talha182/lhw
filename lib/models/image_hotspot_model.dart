import 'package:flutter/material.dart';

class ImageHotspotModel {
  final String imagePath;
  final List<HotspotData> hotspots;

  ImageHotspotModel({required this.imagePath, required this.hotspots});
}

class HotspotData {
  final String dialogText;
  final Offset offset;

  HotspotData({required this.dialogText, required this.offset});
}