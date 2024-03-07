import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/image_hotspot_model.dart';

class HorizontalImageHotspot extends StatefulWidget {
  final HorizontalImageHotspotModel horizontalImageHotspotModel;
  final VoidCallback? onCompleted;

  const HorizontalImageHotspot({
    Key? key,
    required this.horizontalImageHotspotModel,
    this.onCompleted,
  }) : super(key: key);

  @override
  _HorizontalImageHotspotState createState() => _HorizontalImageHotspotState();
}

class _HorizontalImageHotspotState extends State<HorizontalImageHotspot> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  void _showDialog(String dialogText) {
    showAnimatedDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dialog'),
          content: Text(dialogText),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  bool _areAllHotspotsTapped() {
    return widget.horizontalImageHotspotModel.images[_currentIndex].hotspots.every((hotspot) => hotspot.isTapped);
  }

  void _handleContinue() {
    if (_areAllHotspotsTapped()) {
      if (_currentIndex < widget.horizontalImageHotspotModel.images.length - 1) {
        setState(() => _currentIndex++);
      } else {
        widget.onCompleted?.call();
        Get.back(result: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildImageContainer(),
          Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.close, size: 30),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: _buildContinueButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageContainer() {
    final image = widget.horizontalImageHotspotModel.images[_currentIndex];
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image.imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: image.hotspots.map((hotspot) {
          return Positioned(
            left: hotspot.offset.dx,
            top: hotspot.offset.dy,
            child: GestureDetector(
              onTap: () {
                _showDialog(hotspot.dialogText);
                setState(() {
                  hotspot.isTapped = true;
                });
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(hotspot.isTapped ? 'assets/images/Hotspot---Green.png' : 'assets/images/Hotspot---Pink.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffFE8BD1),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: const Size(150, 37),
      ),
      onPressed: _areAllHotspotsTapped() ? _handleContinue : null,
      child: const Text(
        'جاری',
        style: TextStyle(
          fontFamily: 'UrduType',
          fontSize: 15,
          color: Colors.white,
        ),
      ),    );
  }
}


class HorizontalImageHotspotModel {
  final List<ImageWithHotspots> images;

  HorizontalImageHotspotModel({required this.images});

  factory HorizontalImageHotspotModel.fromJson(Map<String, dynamic> json) {
    return HorizontalImageHotspotModel(
      images: List<ImageWithHotspots>.from(json['images'].map((x) => ImageWithHotspots.fromJson(x))),
    );
  }
}

class ImageWithHotspots {
  final String imagePath;
  final List<HorizontalHotspotData> hotspots;

  ImageWithHotspots({required this.imagePath, required this.hotspots});

  factory ImageWithHotspots.fromJson(Map<String, dynamic> json) {
    return ImageWithHotspots(
      imagePath: json['imagePath'],
      hotspots: List<HorizontalHotspotData>.from(json['hotspots'].map((x) => HorizontalHotspotData.fromJson(x))),
    );
  }
}

class HorizontalHotspotData {
  final String dialogText;
  final Offset offset;
  bool isTapped = false;

  HorizontalHotspotData({required this.dialogText, required this.offset, this.isTapped = false});

  factory HorizontalHotspotData.fromJson(Map<String, dynamic> json) {
    return HorizontalHotspotData(
      dialogText: json['dialogText'],
      offset: Offset(json['offset']['dx'].toDouble(), json['offset']['dy'].toDouble()),
      isTapped: json['isTapped'] ?? false,
    );
  }
}
