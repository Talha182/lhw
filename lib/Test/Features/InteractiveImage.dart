import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../courses_test/test_model.dart';
import '../../models/interactive_images_model.dart';
import '../../controllers/feature_navigation.dart';

class InteractiveImages extends StatefulWidget {final Feature feature;

const InteractiveImages({Key? key, required this.feature}) : super(key: key);

  @override
  _InteractiveImagesState createState() => _InteractiveImagesState();
}

class _InteractiveImagesState extends State<InteractiveImages> {
  int currentIndex = 0; // Track the current image index
  bool hasBeenDroppedSuccessfully = false; // Add this line

  // final List<Map<String, dynamic>> imagesInfo = [
  //   {
  //     'image': 'assets/script11/Script11-01.jpg',
  //     'guide': 'مریض کا منہ خالی ہونے کو یقینی بنانے کے لئے آئینے پر کلک کریں۔',
  //     'touchArea': const Rect.fromLTWH(460, 80, 130, 160),
  //     'showDialog': false,
  //     'dialogText': 'Click on the right side',
  //     'swipeEnabled': false,
  //     'longPressEnabled': false, // Ensure this is explicitly set for each image
  //     'longPressAction': '',
  //     'dragDropEnabled': false, // Add this line for each image
  //   },
  //   {
  //     'image': 'assets/script11/Script11-02.jpg',
  //     'guide': '',
  //     'touchArea': const Rect.fromLTWH(370, 310, 310, 80),
  //     'showDialog': true,
  //     'swipeEnabled': false,
  //     'swipeAction': 'nextImage',
  //     'dialogText':
  //         'بلغم کے نمونے جمع کرنے سے پہلے، اس بات کو یقینی بنائیں کہ مریض کے منہ میں کوئی کھانے کی چیز نہ  ہو ۔',
  //     'longPressEnabled': false,
  //     'longPressAction': '', // Custom action identifier
  //     'dragDropEnabled': false, // Add this line for each image
  //   },
  //   {
  //     'image': 'assets/script11/Script11-03.jpg',
  //     'guide': 'شاور اور گرم مشروب کے آئیکن کو مریض کے پاس لایں۔',
  //     'touchArea': const Rect.fromLTWH(0, 0, 0, 0),
  //     'showDialog': false,
  //     'swipeEnabled': false,
  //     'longPressEnabled': true,
  //     'longPressAction': 'showMessage', // Custom action identifier
  //     'dialogText': '',
  //     'dragDropEnabled': true, // Add this line for each image
  //   },
  //   {
  //     'image': 'assets/script11/Script11-04.jpg',
  //     'guide': 'Find the hidden bird and tap.',
  //     'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
  //     'showDialog': true,
  //     'swipeEnabled': false,
  //     'longPressAction': 'showMessage', // Custom action identifier
  //     'dialogText':
  //         'تھوک کے نمونے جمع کرنے سے پہلے مریض کو گرم پانی سے نہا  لینے یا گرم مشروب پینے کی رہنمائی کریں۔ اس سے بلغم کو نکلنے میں مدد ملے گی۔',
  //     'dragDropEnabled': false, // Add this line for each image
  //   },
  //   {
  //     'image': 'assets/script11/Script11-05.jpg',
  //     'guide': 'Find the hidden bird and tap.',
  //     'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
  //     'showDialog': false,
  //     'swipeEnabled': false,
  //     'longPressEnabled': true,
  //     'longPressAction':
  //         'showTimer', // This is the custom action identifier// Make sure this is true for the action to work
  //     'dialogText': 'Click on the right side',
  //     'dragDropEnabled': false, // Add this line for each image
  //   },
  //   {
  //     'image': 'assets/script11/Script11-10.jpg',
  //     'guide': 'Find the hidden bird and tap.',
  //     'touchArea': const Rect.fromLTWH(0, 0, 0, 0),
  //     'showDialog': false,
  //     'swipeEnabled': false,
  //     'longPressAction': 'showMessage', // Custom action identifier
  //     'dialogText': 'Click on the right side',
  //     'dragDropEnabled': true, // Add this line for each image
  //   },
  //   {
  //     'image': 'assets/script11/Script11-13.jpg',
  //     'guide': 'Find the hidden bird and tap.',
  //     'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
  //     'showDialog': false,
  //     'swipeEnabled': false,
  //     'longPressAction': 'showMessage', // Custom action identifier
  //     'dialogText': 'Click on the right side',
  //     'dragDropEnabled': false, // Add this line for each image
  //   },
  //   {
  //     'image': 'assets/script11/Script11-16.jpg',
  //     'guide': 'گہری سانس شروع کرنے کے لئے مریض پر تھوڑی دیر تک کلک کیے رکھیں۔',
  //     'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
  //     'showDialog': true,
  //     'swipeEnabled': false,
  //     'longPressAction': 'showMessage', // Custom action identifier
  //     'dialogText':
  //         'مریض کو ایک گہری سانس لینے اور اسے 5 سیکنڈ کے لئے اپنے سینے میں رکھنے کے لئے کہیں۔.',
  //     'dragDropEnabled': false, // Add this line for each image
  //   },
  //   {
  //     'image': 'assets/script11/Script11-19.jpg',
  //     'guide':
  //         'ڈبی کو صاف کرنے کے لئے ٹشو کو لیں اور پھر اسے کوڑے میں پھینک دیں۔',
  //     'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
  //     'showDialog': false,
  //     'swipeEnabled': false,
  //     'longPressAction': 'showMessage', // Custom action identifier
  //     'dialogText': 'Click on the right side',
  //     'dragDropEnabled': false, // Add this line for each image
  //   },
  //   {
  //     'image': 'assets/script11/Script11-22.jpg',
  //     'guide': 'اس کی جانچ پڑتال کے لئے نمونے پر کلک کریں۔',
  //     'touchArea': const Rect.fromLTWH(50, 120, 80, 80),
  //     'showDialog': false,
  //     'swipeEnabled': false,
  //     'longPressAction': 'showMessage', // Custom action identifier
  //     'dialogText': 'Click on the right side',
  //     'dragDropEnabled': false, // Add this line for each image
  //   },
  //   {
  //     'image': 'assets/script11/Script11-23.jpg',
  //     'guide': 'Find the hidden bird and tap.',
  //     'touchArea': const Rect.fromLTWH(0, 0, 0, 0),
  //     'showDialog': true,
  //     'swipeEnabled': false,
  //     'longPressAction': 'showMessage', // Custom action identifier
  //     'dialogText':
  //         'نمونے کا جائزہ لیں اور اس بات کا یقین کریں کہ لیا گیا نمونہ بلغم ہی ہو، منہ یا ناک کی رطوبت نہ ہو۔',
  //     'dragDropEnabled': false, // Add this line for each image
  //   },
  //   {
  //     'image': 'assets/script11/Script11-25.jpg',
  //     'guide': 'Find the hidden bird and tap.',
  //     'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
  //     'showDialog': false,
  //     'swipeEnabled': false,
  //     'longPressAction': 'showMessage', // Custom action identifier
  //     'dialogText': 'Click on the right side',
  //     'dragDropEnabled': false, // Add this line for each image
  //   },
  //   {
  //     'image': 'assets/script11/Script11-26.jpg',
  //     'guide': 'Find the hidden bird and tap.',
  //     'touchArea': const Rect.fromLTWH(200, 100, 200, 200),
  //     'showDialog': false,
  //     'swipeEnabled': false,
  //     'longPressAction': 'showMessage', // Custom action identifier
  //     'dialogText': 'Click on the right side',
  //     'dragDropEnabled': false, // Add this line for each image
  //   },
  // ];
  List<InteractiveImageModel> get imagesInfo => widget.feature.relatedData;
  bool isMessageVisible = false;
  bool showTimerIcon = false;
  Timer? iconTimer;

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
    iconTimer?.cancel();

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
      // Check if the current index is less than the maximum index in the list
      if (currentIndex < imagesInfo.length - 1) {
        // Only increment currentIndex if it's not the last image
        currentIndex += 1;
      }
      // No else part needed; it just doesn't change the currentIndex if it's the last image

      isMessageVisible = false;
    });
    showMessageTemporarily();
  }

  final AudioPlayer audioPlayer = AudioPlayer();

  void playTapSound() async {
    await audioPlayer.play(AssetSource('sounds/ClickHold.mp3'));
  }

  void playSwipeSound() async {
    await audioPlayer.play(AssetSource('sounds/Swipe.mp3'));
  }

  void playLongPressSound() async {
    await audioPlayer.play(AssetSource('sounds/ClickHold.mp3'));
  }

  void playDragDropSound() async {
    await audioPlayer.play(AssetSource('sounds/DragDrop.mp3'));
  }

  // final navigationController = Get.find<FeatureNavigationController>();

  @override
  Widget build(BuildContext context) {
    // Assuming you have already defined `currentIndex` somewhere in your code
    final InteractiveImageModel currentImage = imagesInfo[currentIndex];

// Directly access properties from currentImage
    Rect touchArea = currentImage.touchArea;
    double left = touchArea.left;
    double top = touchArea.top;
    double width = touchArea.width;
    double height = touchArea.height;
    bool swipeEnabled = currentImage.swipeEnabled;
    bool longPressEnabled = currentImage.longPressEnabled;
    bool dragDropEnabled = currentImage.dragDropEnabled;
    String currentImagePath = currentImage.image;

    // Widget to represent the draggable image
    Widget draggableWidget(InteractiveImageModel currentImage) {
      if (currentImage.draggableImage != null &&
          currentImage.draggableImageInitialPosition != null &&
          !hasBeenDroppedSuccessfully) {
        return Positioned(
          left: currentImage.draggableImageInitialPosition!.dx,
          top: currentImage.draggableImageInitialPosition!.dy,
          child: Draggable(
            data: currentImage.image,
            feedback: Material(
              color: Colors.transparent,
              child: Opacity(
                opacity: 0.7,
                child: Image.asset(currentImage.draggableImage!, width: 100),
              ),
            ),
            childWhenDragging: Container(),
            child: Image.asset(currentImage.draggableImage!, width: 100),
          ),
        );
      }
      return Container();
    }

    // Widget to represent the drag target
    Widget dragTargetWidget(InteractiveImageModel currentImage) {
      if (currentImage.dragTargetPosition != null &&
          currentImage.dragDropEnabled) {
        return Positioned(
          left: currentImage.dragTargetPosition!.dx,
          top: currentImage.dragTargetPosition!.dy,
          child: DragTarget<String>(
            onAccept: (data) {
              setState(() {
                // Check if we need to update the draggable image
                if (currentImage.newDraggableImage != null) {
                  currentImage.draggableImage = currentImage.newDraggableImage;
                }

                // Check if we need to update the background image
                if (currentImage.newBackgroundImage != null) {
                  currentImage.image = currentImage.newBackgroundImage!;
                }

                // Check if we need to move to the next image
                if (currentImage.moveToNextOnDrop) {
                  nextImage();
                } else {
                  // Any other specific action can be handled here
                  hasBeenDroppedSuccessfully = true;
                }
              });
            },
            builder: (BuildContext context, List<dynamic> accepted,
                List<dynamic> rejected) {
              return Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: Center(
                    child: Text(
                        hasBeenDroppedSuccessfully ? "Dropped!" : "Drop Here")),
              );
            },
          ),
        );
      }
      return Container();
    }

    return Scaffold(
      body: GestureDetector(
        onTapUp: (TapUpDetails details) {
          // Direct access to properties instead of using containsKey and []
          if (!currentImage.dragDropEnabled &&
              !currentImage.swipeEnabled &&
              !currentImage.longPressEnabled) {
            final Offset localPosition = details.localPosition;
            if (touchArea.contains(localPosition)) {
              playTapSound(); // Play tap sound
              if (currentImage.showDialog) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        buildDialog(currentImage.dialogText, currentImage));
              } else {
                nextImage();
              }
            }
          }
        },
        onHorizontalDragEnd: (details) {
          if (!currentImage.dragDropEnabled &&
              !currentImage.longPressEnabled &&
              currentImage.swipeEnabled) {
            playSwipeSound(); // Play swipe sound
            // Handling swipe action directly
            if (currentImage.swipeAction == 'nextImage') {
              nextImage();
            }
            // Add more conditions for different swipe actions if needed
          }
        },
        onLongPress: () {
          if (!currentImage.dragDropEnabled && currentImage.longPressEnabled) {
            playLongPressSound(); // Play long press sound
            // Handling long press action directly
            if (currentImage.longPressAction == 'showMessage') {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(currentImage.dialogText.isNotEmpty
                      ? currentImage.dialogText
                      : 'You performed a long press in the area!'),
                ),
              );
            } else if (currentImage.longPressAction == 'showTimer') {
              setState(() {
                showTimerIcon = true;
              });
              iconTimer?.cancel(); // Cancel any existing timer
              iconTimer = Timer(const Duration(seconds: 5), () {
                if (mounted) {
                  setState(() {
                    showTimerIcon = false;
                  });
                }
              });
            }
            // Add any additional long press actions here...
          }
        },
        child: Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(
                  milliseconds: 500), // Customize animation duration
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Container(
                key: ValueKey<String>(
                    currentImagePath), // Unique key for animation
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(currentImagePath),
                    fit: BoxFit.cover,
                  ),
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
                    currentImage.guide, // Direct access
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
                left: 10,
                top: 20,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.black,
                )),
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
            draggableWidget(currentImage),
            dragTargetWidget(currentImage),
            if (showTimerIcon)
              const Positioned(
                bottom: 100,
                right: 100,
                child: Icon(
                  Icons.timer, // You can choose an appropriate icon
                  size: 60,
                  color: Colors.blue,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildDialog(String dialogText, InteractiveImageModel currentImage) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // This removes border radius
      ),
      child: Stack(
        clipBehavior: Clip.none, // Allows overflow of children outside the box
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
                maxWidth: 150, // Set a maximum width for the text content
              ),
              child: Text(
                currentImage.dialogText, // Direct access

                textAlign:
                    TextAlign.center, // Ensures text is centered if short
                style: const TextStyle(fontFamily: "UrduType", fontSize: 20),
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
              margin:
                  const EdgeInsets.all(5), // Margin from the edge of the dialog
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: Colors.green, width: 2), // Green border
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// if (dragDropEnabled && currentIndex == 2)
//   Positioned(
//     bottom: 50, // Adjust based on your UI needs
//     left: 200, // Adjust based on your UI needs
//     child: draggableImageScript11_03,
//   ),
// if (dragDropEnabled && currentIndex == 2)
//   Positioned(
//     bottom: 50, // Adjust based on your UI needs
//     right: 50, // Adjust based on your UI needs
//     child: dragTargetScript11_03,
//   ),
// if (dragDropEnabled && currentIndex == 5)
//   Positioned(
//     bottom: 30, // Adjust based on your UI needs
//     left: -10, // Adjust based on your UI needs
//     child: draggableImageScript11_10,
//   ),
// if (dragDropEnabled && currentIndex == 5)
//   Positioned(
//     bottom: 50, // Adjust based on your UI needs
//     right: 50, // Adjust based on your UI needs
//     child: dragTargetScript11_10,
//   ),
// // Inside your Stack widget...
// var draggableImage = hasBeenDroppedSuccessfully
//     ? Image.asset('assets/script11/Script11-14.png',
//     width: 700) // New image after successful drop
//     : Image.asset('assets/script11/Script11-11.png',
//     width: 700); // Original image before drop

// // Correctly configured draggable and drag target widgets for Script11-03.jpg
// var draggableImageScript11_03 = Draggable<String>(
//   data: 'Script11-03',
//   feedback: Material(
//     elevation: 4.0,
//     borderRadius: BorderRadius.circular(
//         0), // Ensure the material widget has no border radius
//     color: Colors.transparent,
//     child: Opacity(
//       opacity: 0.7,
//       child: Image.asset('assets/script11/Script11-03.jpg', width: 100),
//     ), // Make the material widget's background color transparent
//   ),
//   childWhenDragging: Container(
//     // You can leave this as an empty container or use a placeholder
//     width: 100, // Match the width of the original child to maintain layout
//     color: Colors.transparent, // Optional: make the container transparent
//   ),
//   child: Image.asset('assets/script11/Script11-03.jpg', width: 100),
// );
//
// // Drag target for Script11-03.jpg
// var dragTargetScript11_03 = DragTarget<String>(
//   onAccept: (data) {
//     if (data == 'Script11-03') {
//       playDragDropSound(); // Play drag drop sound
//
//       // Perform the action for Script11-03.jpg here
//       nextImage();
//     }
//   },
//   builder: (
//     BuildContext context,
//     List<dynamic> accepted,
//     List<dynamic> rejected,
//   ) {
//     return Container(
//       width: 200,
//       height: 200,
//       decoration: BoxDecoration(
//         color: Colors.green
//             .withOpacity(0.5), // Adjust the color to differentiate targets
//         border: Border.all(color: Colors.green, width: 2),
//       ),
//       child: const Center(child: Text("Drop Script11-03 Here")),
//     );
//   },
// );
//
// // Correctly configured draggable and drag target widgets for Script11-11.png
// var draggableImageScript11_10 = Draggable<String>(
//   data: 'Script11-11',
//   feedback: Material(
//     elevation: 0.0,
//     color: Colors.transparent,
//     child: Opacity(
//       opacity: 0.7,
//       child: draggableImage, // Use the variable here
//     ),
//     borderRadius: BorderRadius.zero,
//   ),
//   childWhenDragging: Opacity(
//     opacity: 0.0,
//     child: draggableImage, // Use the variable here
//   ),
//   child: draggableImage, // Use the variable here
// );
//
// // Drag target for Script11-11.png
// var dragTargetScript11_10 = DragTarget<String>(
//   onAccept: (data) {
//     if (data == 'Script11-11') {
//       playDragDropSound(); // Play drag drop sound
//
//       setState(() {
//         hasBeenDroppedSuccessfully =
//             true; // Update the state to change the image
//       });
//       nextImage(); // Assuming nextImage() navigates to the next image or updates view
//     }
//   },
//   builder: (
//     BuildContext context,
//     List<dynamic> accepted,
//     List<dynamic> rejected,
//   ) {
//     return Container(
//       width: 200,
//       height: 200,
//       decoration: BoxDecoration(
//         color: Colors.green.withOpacity(0.5),
//         border: Border.all(color: Colors.green, width: 2),
//       ),
//       child: const Center(child: Text("Drop Script11-11 Here")),
//     );
//   },
// );
