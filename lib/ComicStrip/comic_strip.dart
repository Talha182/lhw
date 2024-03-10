import 'dart:async';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';

import '../Database/database_helper.dart';
import '../Presentation/Presentation.dart';

class ComicStrip extends StatefulWidget {
  final List<ComicStripModel> comicStripsModel;
  final VoidCallback? onCompleted; // Optional callback
  final int featureId;

  const ComicStrip(
      {Key? key,
      required this.comicStripsModel,
      this.onCompleted,
      required this.featureId})
      : super(key: key);

  @override
  _ComicStripState createState() => _ComicStripState();
}

class _ComicStripState extends State<ComicStrip> with TickerProviderStateMixin {
  int _current = 0;
  double _progress = 0.0;
  late List<Widget> _carouselItems;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  bool _isLiked = false;
  bool _isDisliked = false;
  late AnimationController _cloudPumpAnimationController;
  late Animation<double> _cloudPumpAnimation;
  bool showMessage = true;
  double _fabYPosition = 600.0; // Default position


  @override
  void initState() {
    super.initState();
    _startMessageTimer();

    // Flatten all image pairs from all comic strip models into a single list
    List<ImagePair> allImagePairs =
        widget.comicStripsModel.expand((model) => model.imagePairs).toList();

    // Generate carousel items for each image pair
    _carouselItems = allImagePairs.map((imagePair) {
      return _buildSlide(imagePair.topImage, imagePair.bottomImage);
    }).toList();

    _progressController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this)
      ..addListener(() {
        setState(() {
          _progress = _progressAnimation.value;
        });
      });
    _cloudPumpAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _cloudPumpAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _cloudPumpAnimationController,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    _cloudPumpAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _progressController.dispose();
    _cloudPumpAnimationController.dispose();

    super.dispose();
  }

  void _startMessageTimer() {
    Timer(const Duration(seconds: 8), () {
      setState(() {
        showMessage = false;
      });
    });
  }

  void _showMessageAgain() {
    setState(() {
      showMessage = true;
    });
    _startMessageTimer();
  }

  Widget _buildSlide(String imagePathTop, String imagePathBottom) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          _buildContainer(imagePathTop),
          const SizedBox(height: 20),
          _buildContainer(imagePathBottom),
        ],
      ),
    );
  }

  Widget _buildContainer(String imagePath) {
    return Expanded(
      // child: GestureDetector(
      //   onTap: () {
      //     Navigator.of(context).push(PageRouteBuilder(
      //       pageBuilder: (context, animation, secondaryAnimation) =>
      //           FadeTransition(
      //         opacity: animation,
      //         child: FullScreenImageView(imagePath: imagePath),
      //       ),
      //     ));
      //   },
      //   child: Container(
      //     decoration: BoxDecoration(
      //       color: Colors.transparent,
      //       borderRadius: BorderRadius.circular(20),
      //     ),
      //     child: PinchZoom(
      //       resetDuration: const Duration(milliseconds: 100),
      //       maxScale: 2.5,
      //       child: ClipRRect(
      //         borderRadius: BorderRadius.circular(20),
      //         child: Image.asset(imagePath, fit: BoxFit.fill),
      //       ),
      //     ),
      //   ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: PhotoView(
            imageProvider: AssetImage(imagePath),
            backgroundDecoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            maxScale: PhotoViewComputedScale.covered * 2.5,
            minScale: PhotoViewComputedScale.contained,
            initialScale: PhotoViewComputedScale.covered,
            basePosition: Alignment.center,
            tightMode: true,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fabHeight = 65.0; // Standard height of a FAB
    final topSafeArea = MediaQuery.of(context).padding.top;
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(0, -0.2),
                colors: [
                  const Color(0xff80B8FB).withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // Handle close button tap
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close,
                          size: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Transform(
                          alignment: Alignment.center, // Center the transformation
                          transform: Matrix4.identity()..scale(-1.0, 1.0), // Flip horizontally
                          child: LinearPercentIndicator(
                            animation: false,
                            animationDuration: 400,
                            lineHeight: 10.0,
                            percent: _progress,
                            backgroundColor: Colors.white,
                            clipLinearGradient: true,
                            barRadius: const Radius.circular(20),
                            // Flip the linear gradient to match the flipped indicator direction
                            linearGradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [const Color(0xffFE8BD1), const Color(0xffFE8BD1)],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, top: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ScaleTransition(
                      scale: _cloudPumpAnimation,
                      child: SvgPicture.asset(
                        'assets/images/cloud.svg',
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: Text(
                    widget.comicStripsModel.first.title,
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(fontFamily: "UrduType", fontSize: 22),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: CarouselSlider.builder(
                        itemCount: _carouselItems.length,
                        itemBuilder: (context, index, realIdx) {
                          return _carouselItems[index];
                        },
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: double.infinity,
                          enableInfiniteScroll:
                              false, // Disable infinite scrolling

                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });

                            if (_carouselItems.length > 1) {
                              double endValue = index /
                                  (_carouselItems.length - 1).toDouble();
                              _progressAnimation =
                                  Tween<double>(begin: _progress, end: endValue)
                                      .animate(_progressController);

                              _progressController.forward(from: 0);
                            } else {
                              // If there's only one item, set progress to full because there's nowhere to slide.
                              _progress = 1.0;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _carouselItems.map((url) {
                      int index = _carouselItems.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? const Color(0xffFE8BD1)
                              : const Color(0xffD1D7DC).withOpacity(0.3),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // const Spacer(),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black87.withOpacity(0.2),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 2),
                    backgroundColor: const Color(0xffFE8BD1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(150, 37),
                  ),
                  onPressed: _current == _carouselItems.length - 1
                      ? () async {
                          // Logic for handling completion when on the last slide.
                          // if (widget.onCompleted != null) {
                          //   await DatabaseHelper.instance
                          //       .markFeatureAsCompleted(widget.featureId);
                          //   widget.onCompleted
                          //       ?.call(); // Optionally call the completion callback if provided
                          // }
                          Get.back(result: true);
                        }
                      : null, // This button is disabled unless you're on the last slide
                  child: const Text(
                    'جاری',
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - (50 * 1.5),
            right: 10,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _isLiked = !_isLiked;
                        // Handle like button tap
                      });
                    },
                    icon: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? Colors.red : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black87.withOpacity(0.4),
                      shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _isDisliked = !_isDisliked;
                        // Handle dislike button tap
                      });
                    },
                    icon: Icon(
                      _isDisliked
                          ? Icons.thumb_down
                          : Icons.thumb_down_alt_outlined,
                      color: _isDisliked ? Colors.blue : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black87.withOpacity(0.4),
                      shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {
                      // Handle full screen tap
                      Get.to(() => FullScreenComicStrip(
                            comicStripsModel: widget.comicStripsModel,
                          ));
                    },
                    icon: const Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20, // Distance from right
            top: _fabYPosition,
            child: GestureDetector(
              onVerticalDragUpdate: (dragUpdateDetails) {
                setState(() {
                  _fabYPosition += dragUpdateDetails.delta.dy;

                  // Clamp the position to prevent the FAB from moving off the screen
                  // Consider top and bottom safe areas (like notches and navigation bars)
                  _fabYPosition = _fabYPosition.clamp(
                      topSafeArea, screenHeight - fabHeight - bottomSafeArea);
                });
              },
              child:Container(
                margin: const EdgeInsets.only(bottom: 72.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (showMessage)
                      GestureDetector(
                        onTap: _showMessageAgain,
                        child: CustomPaint(
                          painter: MenuBoxBackground(),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10, left: 10),
                            // width: screenWidth * 0.7,

                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'یہ چند صفحہ ہیں جن کو آپ نے مکمل پڑنا ہی۔\n اس میں اور کوئی کام نہیں۔ صرف پڑھا\n ہی کافی ہے۔',
                                  textAlign: TextAlign.center,
                                  textStyle: const TextStyle(fontSize: 18, color: Colors.white,fontFamily: "UrduType"),
                                  speed: const Duration(milliseconds: 50),
                                ),
                              ],
                              totalRepeatCount: 1,
                              pause: const Duration(milliseconds: 5000),
                              displayFullTextOnTap: true,
                              stopPauseOnTap: true,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: _showMessageAgain,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xffF6B3D0),
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: SvgPicture.asset(
                            "assets/images/samina_instructor.svg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class FullScreenComicStrip extends StatelessWidget {
  final List<ComicStripModel> comicStripsModel;

  const FullScreenComicStrip({Key? key, required this.comicStripsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp]);
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: comicStripsModel
              .expand((comicStripModel) => comicStripModel.imagePairs.map(
                    (imagePair) => _buildComicStrip(
                        imagePair.topImage, imagePair.bottomImage),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildComicStrip(String imagePathTop, String imagePathBottom) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContainer(imagePathTop),
          const SizedBox(width: 20),
          _buildContainer(imagePathBottom),
        ],
      ),
    );
  }

  Widget _buildContainer(String imagePath) {
    return Container(
      width: 320,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: PinchZoom(
        resetDuration: const Duration(milliseconds: 100),
        maxScale: 2.5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class ComicStripModel {
  final String title;
  final List<ImagePair> imagePairs;

  ComicStripModel({required this.title, required this.imagePairs});

  factory ComicStripModel.fromJson(Map<String, dynamic> json) {
    var imagePairsList = json['imagePairs'] as List;
    List<ImagePair> imagePairs =
        imagePairsList.map((i) => ImagePair.fromJson(i)).toList();
    return ComicStripModel(
      title: json['title'],
      imagePairs: imagePairs,
    );
  }
}

class ImagePair {
  final String topImage;
  final String bottomImage;

  ImagePair({required this.topImage, required this.bottomImage});

  factory ImagePair.fromJson(Map<String, dynamic> json) {
    return ImagePair(
      topImage: json['topImage'],
      bottomImage: json['bottomImage'],
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final String imagePath;

  const FullScreenImageView({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: PinchZoom(
              resetDuration: const Duration(milliseconds: 100),
              maxScale: 3.0,
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
          Positioned(
            top: 20,
            left: 30,
            child: IconButton(
              icon: const Icon(Icons.close, size: 30, color: Colors.black),
              onPressed: () {
                SystemChrome.setPreferredOrientations(
                    [DeviceOrientation.portraitUp]);
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
