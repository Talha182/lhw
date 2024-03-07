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


  void showCustomDialog(BuildContext context, String dialogText,
      ) {
    showAnimatedDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(
                    top: 20, right: 60, bottom: 60, left: 60),
                child: ConstrainedBox(
                  constraints:
                  const BoxConstraints(maxHeight: 120, maxWidth: 150),
                  child: Text(dialogText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: "UrduType", fontSize: 20)),
                ),
              ),
              Positioned(
                bottom: -15,
                left: -55,
                child: Image.asset('assets/scripts/script11/2.png',
                    width: 180, height: 180),
              ),
              Positioned(
                top: -40,
                right: -50,
                child: Image.asset('assets/scripts/script11/1.png',
                    width: 180, height: 180),
              ),
              Positioned.fill(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 110,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(dialogContext).pop(); // Close the dialog
                  },
                  child: Container(
                    width: 90,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xffFE8BD1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "اگلے",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                showCustomDialog(context, hotspot.dialogText);
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