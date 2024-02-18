import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../controllers/BookmarkController.dart';
import '../models/image_hotspot_model.dart';

class ImageHotspot extends StatefulWidget {
  final ImageHotspotModel imageHotspotModel;

  const ImageHotspot({
    Key? key,
    required this.imageHotspotModel,
  }) : super(key: key);

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

  void _showDialog(BuildContext context, String dialogText) {
    showAnimatedDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dialog'),
          content: Text(dialogText),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  bool _areAllHotspotsTapped() {
    return widget.imageHotspotModel.hotspots
        .every((hotspot) => hotspot.isTapped);
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
    return Expanded(
      child: Container(
        key: _imageKey, // Use the key here
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.imageHotspotModel.imagePath),
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
            ..._buildHotspots(context), // Use the spread operator here
          ],
        ),
      ),
    );
  }

  List<Widget> _buildHotspots(BuildContext context) {
    final containerRenderBox =
        _imageKey.currentContext?.findRenderObject() as RenderBox?;
    final containerSize = containerRenderBox?.size ?? Size.zero;

    return widget.imageHotspotModel.hotspots.map((hotspot) {
      final double relativeX = hotspot.offset.dx / containerSize.width;
      final double relativeY = hotspot.offset.dy / containerSize.height;

      return Positioned(
        left: _isFullScreen
            ? relativeX * MediaQuery.of(context).size.width
            : hotspot.offset.dx,
        top: _isFullScreen
            ? relativeY * MediaQuery.of(context).size.height
            : hotspot.offset.dy,
        child: GestureDetector(
          onTap: () {
            _showDialog(context, hotspot.dialogText);
            setState(() {
              hotspot.isTapped = true; // Update isTapped to true when tapped
            });
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(hotspot.isTapped
                    ? 'assets/images/2.png'
                    : 'assets/images/lesson_26.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildContinueButton() {
    bool allHotspotsTapped =
        _areAllHotspotsTapped(); // Check if all hotspots are tapped

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
          onPressed: allHotspotsTapped
              ? () => Get.back()
              : null, // Enable or disable based on allHotspotsTapped
          child: const Text(
            'جاری رہے',
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
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.imageHotspotModel.imagePath),
            fit: BoxFit.cover,
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
            ..._buildHotspots(context), // Use the spread operator here
          ],
        ),
      ),
    );
  }
}

class ArrowContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 35,
      child: CustomPaint(
        painter: ArrowPainter(),
        child: const Center(
          child: Text(
            'انٹرایکٹو عنصر دکھائیں۔',
            style: TextStyle(
                color: Colors.white, fontFamily: "UrduType", fontSize: 13),
          ),
        ),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    const double arrowWidth = 15.0; // width of the arrow (beak)
    const double arrowHeight = 15.0; // height of the arrow (beak)
    const double cornerRadius = 10.0; // radius for rounded corners

    final path = Path()
      ..moveTo(arrowWidth + cornerRadius, 0)
      ..lineTo(size.width - cornerRadius, 0)
      ..arcToPoint(Offset(size.width, cornerRadius),
          radius: const Radius.circular(cornerRadius), clockwise: true)
      ..lineTo(size.width, size.height - cornerRadius)
      ..arcToPoint(Offset(size.width - cornerRadius, size.height),
          radius: const Radius.circular(cornerRadius), clockwise: true)
      ..lineTo(arrowWidth + cornerRadius, size.height)
      ..arcToPoint(Offset(arrowWidth, size.height - cornerRadius),
          radius: const Radius.circular(cornerRadius), clockwise: true)
      ..lineTo(arrowWidth, size.height / 2 + arrowHeight / 2)
      ..lineTo(0, size.height / 2)
      ..lineTo(arrowWidth, size.height / 2 - arrowHeight / 2)
      ..lineTo(arrowWidth, cornerRadius)
      ..arcToPoint(const Offset(arrowWidth + cornerRadius, 0),
          radius: const Radius.circular(cornerRadius), clockwise: true)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
