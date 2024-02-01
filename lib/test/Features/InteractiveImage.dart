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
      'longPressEnabled': true, // Ensure this is explicitly set for each image
      'longPressAction': 'showMessage',
    },
    {
      'image': 'assets/script11/Script11-02.jpg',
      'guide': 'See the sky? Tap it to learn more.',
      'touchArea': const Rect.fromLTWH(370, 310, 310, 80),
      'showDialog': true,
      'swipeEnabled': true,
      'swipeAction': 'nextImage',
      'dialogText': 'Click on the right side',

    },
    {
      'image': 'assets/test/3.jpg',
      'guide': 'Find the hidden bird and tap.',
      'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
      'showDialog': false,
      'swipeEnabled': false,
      'longPressAction': 'showMessage', // Custom action identifier
      'dialogText': 'Click on the right side',


    },{
      'image': 'assets/test/1.jpg',
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
    bool longPressEnabled = imagesInfo[currentIndex]['longPressEnabled'] ?? false;


    return Scaffold(
      body: GestureDetector(
        onTapUp: (TapUpDetails details) {
          // Tap action is allowed only if both swipe and long press are disabled
          if (!swipeEnabled && !longPressEnabled) {
            final Offset localPosition = details.localPosition;
            if (touchArea.contains(localPosition)) {
              if (imagesInfo[currentIndex].containsKey('showDialog') && imagesInfo[currentIndex]['showDialog']) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    content: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 300, minHeight: 100, maxHeight: 300),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.greenAccent),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  imagesInfo[currentIndex]['dialogText'] ?? 'You tapped on an interactive area!', // Handle null dialogText
                                  style: TextStyle(fontSize: 20, fontFamily: "UrduType"),
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                nextImage();
              }
            }
          }
        },

        onHorizontalDragEnd: (details) {
          if (!longPressEnabled && swipeEnabled ) { // Check if long press is not enabled
            // Since swipe is enabled for this image, handle the swipe action here
            final action = imagesInfo[currentIndex]['swipeAction'];
            if (action == 'nextImage') {
              nextImage();
            }
            // Add more conditions for different swipe actions if needed
          }
        },
        onLongPressStart: (LongPressStartDetails details) {
          final Offset localPosition = details.localPosition;
          if (longPressEnabled && touchArea.contains(localPosition)) { // Check if long press is enabled
            if (!swipeEnabled && longPressEnabled) {
              final action = imagesInfo[currentIndex]['longPressAction'];
              if (action == 'showMessage') {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(imagesInfo[currentIndex]['dialogText'] ?? 'You performed a long press in the area!'),
                  ),
                );
              }
              // Handle other long press actions as needed
            }
          }
        },

        // onLongPress: () {
        //   // Handle long press only if it's enabled and the press was within the touch area
        //   if (longPressEnabled) {
        //     final action = imagesInfo[currentIndex]['longPressAction'];
        //     if (action == 'showMessage') {
        //       // Perform the long press action, e.g., show a message or dialog
        //       showDialog(
        //         context: context,
        //         builder: (context) => AlertDialog(
        //           content: Text(imagesInfo[currentIndex]['dialogText'] ?? 'You performed a long press!'),
        //         ),
        //       );
        //     }
        //     // Add more conditions for different long press actions if needed
        //   }
        // },
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
                    style: const TextStyle(fontSize: 14, fontFamily: "UrduTyp"),
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
