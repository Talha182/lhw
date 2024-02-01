import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class InteractiveImages extends StatefulWidget {
  const InteractiveImages({Key? key}) : super(key: key);

  @override
  _InteractiveImagesState createState() => _InteractiveImagesState();
}

class _InteractiveImagesState extends State<InteractiveImages> {
  final List<Map<String, dynamic>> imagesInfo = [
    {
      'image': 'assets/script11/Script11-01.jpg',
      'guide': 'مریض کا منہ خالی ہونے کو یقینی بنانے کے لئے آئینے پر کلک کریں۔',
      'touchArea': const Rect.fromLTWH(460, 80, 130, 160),
      'showDialog': false,
      'dialogText': 'Click on the right side',
      'swipeEnabled': false,
      'longPressEnabled': false, // Ensure this is explicitly set for each image
      'longPressAction': '',
    },
    {
      'image': 'assets/script11/Script11-02.jpg',
      'guide': '',
      'touchArea': const Rect.fromLTWH(370, 310, 310, 80),
      'showDialog': true,
      'swipeEnabled': false,
      'swipeAction': 'nextImage',
      'dialogText':
          'بلغم کے نمونے جمع کرنے سے پہلے، اس بات کو یقینی بنائیں کہ مریض کے منہ میں کوئی کھانے کی چیز نہ  ہو ۔',
      'longPressEnabled': false,
      'longPressAction': '', // Custom action identifier
    },
    {
      'image': 'assets/script11/Script11-03.jpg',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressEnabled': true,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': '',
    },
    {
      'image': 'assets/script11/Script11-04.jpg',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': true,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',
    },
    {
      'image': 'assets/script11/Script11-05.jpg',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',
    },
    {
      'image': 'assets/script11/Script11-06.jpg',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',
    },
    {
      'image': 'assets/script11/Script11-10.jpg',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',
    },
    {
      'image': 'assets/script11/Script11-11.png',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',
    },
    {
      'image': 'assets/script11/Script11-13.jpg',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',
    },
    {
      'image': 'assets/script11/Script11-14.png',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',
    },
    {
      'image': 'assets/script11/Script11-16.jpg',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',
    },
    {
      'image': 'assets/script11/Script11-17.png',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',
    },
    {
      'image': 'assets/script11/Script11-19.jpg',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',
    },
    {
      'image': 'assets/script11/Script11-20.png',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',
    },
    {
      'image': 'assets/script11/Script11-22.jpg',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',
    },
    {
      'image': 'assets/script11/Script11-23.jpg',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',
    },
    {
      'image': 'assets/script11/Script11-25.jpg',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',
    },
    {
      'image': 'assets/script11/Script11-26.jpg',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',
    },
  ];

  int currentIndex = 0;
  bool isMessageVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => showMessageTemporarily());
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

  void showMessageTemporarily() {
    setState(() => isMessageVisible = true);
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() => isMessageVisible = false);
      }
    });
  }

  void nextImage() {
    setState(() {
      currentIndex = (currentIndex + 1) % imagesInfo.length;
      isMessageVisible = false;
    });
    showMessageTemporarily();
  }

  @override
  Widget build(BuildContext context) {
    // Extracting the touch area properties for the current image
    Rect touchArea = imagesInfo[currentIndex]['touchArea'];
    double left = touchArea.left;
    double top = touchArea.top;
    double width = touchArea.width;
    double height = touchArea.height;
    bool swipeEnabled = imagesInfo[currentIndex]['swipeEnabled'] ?? false;
    bool longPressEnabled =
        imagesInfo[currentIndex]['longPressEnabled'] ?? false;

    return Scaffold(
      body: GestureDetector(
        onTapUp: (TapUpDetails details) {
          // Tap action is allowed only if both swipe and long press are disabled
          if (!swipeEnabled && !longPressEnabled) {
            final Offset localPosition = details.localPosition;
            if (touchArea.contains(localPosition)) {
              if (imagesInfo[currentIndex].containsKey('showDialog') &&
                  imagesInfo[currentIndex]['showDialog']) {
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.zero, // This removes border radius
                          ),
                          child: Stack(
                            clipBehavior: Clip
                                .none, // Allows overflow of children outside the box
                            children: <Widget>[
                              // Dialog main content
                              Container(
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(
                                    top: 20,
                                    right: 60,
                                    bottom: 60,
                                    left: 60), // Adjust margins for image space
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxHeight: 120,
                                    maxWidth:
                                        150, // Set a maximum width for the text content
                                  ),
                                  child: Text(
                                    imagesInfo[currentIndex]['dialogText'] ??
                                        'You tapped on an interactive area!',
                                    textAlign: TextAlign
                                        .center, // Ensures text is centered if short
                                    style: const TextStyle(
                                        fontFamily: "UrduType", fontSize: 20),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom:
                                    -15, // Adjusted to fit within the dialog, below the green border
                                left:
                                    -55, // Adjusted to fit within the dialog, below the green border
                                child: Image.asset(
                                  'assets/script11/2.png', // Replace with your image path
                                  width: 180, // Adjust the size as needed
                                  height: 180, // Adjust the size as needed
                                ),
                              ),
                              // Top-right Image (Second Image)
                              Positioned(
                                top:
                                    -40, // Adjusted to fit within the dialog, above the green border
                                right:
                                    -50, // Adjusted to fit within the dialog, above the green border
                                child: Image.asset(
                                  'assets/script11/1.png', // Replace with your image path
                                  width: 180, // Adjust the size as needed
                                  height: 180, // Adjust the size as needed
                                ),
                              ),
                              // Green border Container (Overlaying Images)
                              Positioned.fill(
                                // This ensures the container fills the dialog but respects the margin
                                child: Container(
                                  margin: const EdgeInsets.all(
                                      5), // Margin from the edge of the dialog
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.green,
                                        width: 2), // Green border
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
              } else {
                nextImage();
              }
            }
          }
        },
        onHorizontalDragEnd: (details) {
          if (!longPressEnabled && swipeEnabled) {
            // Check if long press is not enabled
            // Since swipe is enabled for this image, handle the swipe action here
            final action = imagesInfo[currentIndex]['swipeAction'];
            if (action == 'nextImage') {
              nextImage();
            }
            // Add more conditions for different swipe actions if needed
          }
        },
        onLongPress: () {
          // Handle long press action only if longPressEnabled is true
          if (longPressEnabled) {
            final action = imagesInfo[currentIndex]['longPressAction'];
            if (action == 'showMessage') {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(imagesInfo[currentIndex]['dialogText'] ??
                      'You performed a long press in the area!'),
                ),
              );
            }
            // Add any additional long press actions here...
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagesInfo[currentIndex]['image']),
                  fit: BoxFit.cover, // This will fill the screen with the image
                ),
              ),
            ),
            if (isMessageVisible)
              Positioned(
                bottom: 150,
                right: 40,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    imagesInfo[currentIndex]['guide'],
                    style:
                        const TextStyle(fontSize: 14, fontFamily: "UrduType"),
                  ),
                ),
              ),
            Positioned(
              left: left,
              top: top,
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.red
                      .withOpacity(0.3), // Semi-transparent red container
                  border: Border.all(
                    color: Colors.red, // Red border to clearly define the area
                    width: 2,
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 80, // Adjust as needed
                right: 20, // Adjust as needed
                child: GestureDetector(
                  onTap: showMessageTemporarily,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xffF6B3D0),
                    radius: 30,
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: SvgPicture.asset(
                          "assets/images/samina_instructor.svg",
                          fit: BoxFit.fill,
                        )),
                  ),
                )),
            Positioned(
                bottom: 20,
                left: 20,
                child: GestureDetector(
                  onTap: nextImage,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Next Image",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
