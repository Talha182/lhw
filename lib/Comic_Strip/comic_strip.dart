import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';

class ComicStrip extends StatefulWidget {
  final List<List<String>> imagePairs;

  const ComicStrip({
    Key? key,
    required this.imagePairs,
  }) : super(key: key);

  @override
  _ComicStripState createState() => _ComicStripState();
}

class _ComicStripState extends State<ComicStrip>
    with SingleTickerProviderStateMixin {
  int _current = 0;
  double _progress = 0.0;
  late List<Widget> _carouselItems;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  bool _isLiked = false;
  bool _isDisliked = false;
  @override
  void initState() {
    super.initState();

    _carouselItems = widget.imagePairs.map((pair) {
      return _buildSlide(pair[0], pair[1]);
    }).toList();

    _progressController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this)
      ..addListener(() {
        setState(() {
          _progress = _progressAnimation.value;
        });
      });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
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
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: PinchZoomReleaseUnzoomWidget(
          minScale: 0.8,
          maxScale: 4,
          resetDuration: const Duration(milliseconds: 200),
          boundaryMargin: const EdgeInsets.only(bottom: 0),
          clipBehavior: Clip.none,
          useOverlay: true,
          maxOverlayOpacity: 0.5,
          overlayColor: Colors.black,
          fingersRequiredToPinch: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
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
                        child: LinearPercentIndicator(
                          animation: false,
                          animationDuration: 400,
                          lineHeight: 10.0,
                          percent: _progress,
                          progressColor: const Color(0xffFE8BD1),
                          backgroundColor: Colors.white,
                          clipLinearGradient: true,
                          barRadius: const Radius.circular(20),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SvgPicture.asset(
                      'assets/images/cloud.svg',
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'آپ ڈیلیوری کے بعد چوتھے دن ماں سے ملنے جاتے ہیں۔ وہ اچانک بھاری اندام نہانی خارج ہونے کی شکایت کرتی ہے۔',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "UrduType", fontSize: 22),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: CarouselSlider.builder(
                      itemCount: _carouselItems.length,
                      itemBuilder: (context, index, realIdx) {
                        return _carouselItems[index];
                      },
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 600,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });

                          double endValue =
                              index / (widget.imagePairs.length - 1).toDouble();
                          _progressAnimation =
                              Tween<double>(begin: _progress, end: endValue)
                                  .animate(_progressController);

                          _progressController.forward(from: 0);
                        },
                      ),
                    ),
                  ),
                ),
                Row(
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
                            ? const Color(0xff9AC9C2)
                            : const Color.fromRGBO(0, 0, 0, 0.1),
                      ),
                    );
                  }).toList(),
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
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'جاری رہے',
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
                            imagePairs: widget.imagePairs,
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
        ],
      ),
    );
  }
}

class FullScreenComicStrip extends StatelessWidget {
  final List<List<String>> imagePairs;

  const FullScreenComicStrip({Key? key, required this.imagePairs})
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
          children: imagePairs
              .map((pair) => _buildComicStrip(pair[0], pair[1]))
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
