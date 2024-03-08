import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../controllers/BookmarkController.dart';
import '../models/image_hotspot_model.dart';

class ImageHotspot extends StatefulWidget {
  final ImageHotspotModel imageHotspotModel;
  final VoidCallback? onCompleted; // Optional callback

  const ImageHotspot(
      {Key? key, required this.imageHotspotModel, this.onCompleted})
      : super(key: key);

  @override
  State<ImageHotspot> createState() => _ImageHotspotState();
}

class _ImageHotspotState extends State<ImageHotspot>
    with TickerProviderStateMixin {
  bool _isFullScreen = false;
  GlobalKey _imageKey = GlobalKey();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late AnimationController _cloudPumpAnimationController;
  late Animation<double> _cloudPumpAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
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
    _animationController.dispose();
    _cloudPumpAnimationController.dispose();

    super.dispose();
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      if (_isFullScreen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
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
  void _nextImage() {
    if (widget.imageHotspotModel.currentIndex <
        widget.imageHotspotModel.images.length - 1) {
      setState(() {
        widget.imageHotspotModel.currentIndex++;
      });
    } else {
      widget.onCompleted?.call();
      Get.back(result: true);
    }
  }

  bool _areAllHotspotsTapped() {
    final currentImage =
        widget.imageHotspotModel.images[widget.imageHotspotModel.currentIndex];
    return currentImage.hotspots.every((hotspot) => hotspot.isTapped);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _isFullScreen
            ? _buildFullScreenImage(context)
            : _buildNormalView(context),
      ),
    );
  }

  Widget _buildNormalView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(0, -0.2),
          colors: [
            const Color(0xff80B8FB).withOpacity(0.3),
            Colors.transparent,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 5),
        child: Column(
          children: [
            _buildTopBar(context),
            _buildImageContainer(context),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close, size: 30),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: LinearPercentIndicator(
                lineHeight: 8.0,
                percent: 1,
                backgroundColor: Colors.white,
                progressColor: const Color(0xffFE8BD1),
                barRadius: const Radius.circular(10),
              ),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.bookmark_outline),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
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
        const Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Text(
            "آپ ڈیلیوری کے بعد چوتھے دن ماں سے ملنے جاتے ہیں۔ وہ اچانک بھاری اندام نہانی خارج ہونے کی شکایت کرتی ہے۔",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "UrduType", fontSize: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer(BuildContext context) {
    // Access the current image data using the model's current index
    final currentImage =
        widget.imageHotspotModel.images[widget.imageHotspotModel.currentIndex];

    return Expanded(
      child: Container(
        key: _imageKey, // Use the key here
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                currentImage.imagePath), // Updated to use current image's path
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    // Define your onTap functionality here for the top left button
                    print("Top left button tapped");
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/touch.svg',
                        width: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    _toggleFullScreen();
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/full_screen.svg',
                        width: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ..._buildHotspots(
              context,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildHotspots(BuildContext context) {
    final currentImage = widget.imageHotspotModel.images[widget.imageHotspotModel.currentIndex];

    // Get the size of the screen for full-screen mode calculations
    final screenSize = MediaQuery.of(context).size;

    // Obtain the size of the container for normal mode calculations
    final containerRenderBox = _imageKey.currentContext?.findRenderObject() as RenderBox?;
    final containerSize = containerRenderBox?.size ?? Size.zero;

    return currentImage.hotspots.map((hotspot) {
      // Determine the dimensions to use based on the current screen mode
      final baseWidth = _isFullScreen ? screenSize.width : containerSize.width;
      final baseHeight = _isFullScreen ? screenSize.height : containerSize.height;

      // Calculate positions based on the dimensions used
      final double relativeX = hotspot.offset.dx / (baseWidth != 0 ? baseWidth : 1);
      final double relativeY = hotspot.offset.dy / (baseHeight != 0 ? baseHeight : 1);

      // Calculate the absolute positions for the hotspots
      final double absoluteX = relativeX * baseWidth;
      final double absoluteY = relativeY * baseHeight;

      return Positioned(
        left: absoluteX,
        top: absoluteY,
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
    }).toList();
  }

  Widget _buildContinueButton() {
    bool allHotspotsTapped = _areAllHotspotsTapped();

    return Column(
      children: [
        const Divider(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffFE8BD1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: const Size(150, 37),
          ),
          onPressed: allHotspotsTapped ? _nextImage : null,
          child: const Text(
            'جاری',
            style: TextStyle(
              fontFamily: 'UrduType',
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFullScreenImage(BuildContext context) {
    final currentImage = widget.imageHotspotModel.images[widget.imageHotspotModel.currentIndex];

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(currentImage.imagePath),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    print("Top left button tapped");
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/touch.svg',
                        width: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    _toggleFullScreen();
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/full_screen.svg', // Consider changing to exit full screen icon
                        width: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ..._buildHotspots(context), // Include hotspots over the full-screen image
          ],
        ),
      ),
    );
  }

}
