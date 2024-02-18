import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../courses_test/test_model.dart';
import '../../models/interactive_images_model.dart';
import '../../controllers/feature_navigation.dart';

class InteractiveImages extends StatefulWidget {
  final Feature feature;

  const InteractiveImages({Key? key, required this.feature}) : super(key: key);

  @override
  _InteractiveImagesState createState() => _InteractiveImagesState();
}

class _InteractiveImagesState extends State<InteractiveImages> {
  int currentIndex = 0; // Track the current image index
  bool hasBeenDroppedSuccessfully = false; // Add this line
  List<InteractiveImageModel> get imagesInfo => widget.feature.relatedData;
  bool isMessageVisible = false;
  bool showTimerIcon = false;
  Timer? iconTimer;
  bool showTimerGif = false;

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

  void showGifTemporarily() {
    setState(() => showTimerGif = true);
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() => showTimerGif = false);
      }
    });
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

  @override
  Widget build(BuildContext context) {
    // Assuming you have already defined `currentIndex` somewhere in your code
    final InteractiveImageModel currentImage = imagesInfo[currentIndex];

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
                showCustomDialog(
                    context, currentImage.dialogText, currentImage);
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
                showTimerGif = true;
              });
              iconTimer?.cancel(); // Cancel any existing timer
              iconTimer = Timer(const Duration(seconds: 5), () {
                if (mounted) {
                  setState(() {
                    showTimerGif = false;
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
                  onPressed: () async {
                    await SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                      DeviceOrientation.portraitDown,
                    ]);
                    // Optionally wait for a short duration
                    await Future.delayed(const Duration(milliseconds: 100));
                    // Use Navigator.pop(context) if you're not using GetX
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
            draggableWidget(currentImage),
            dragTargetWidget(currentImage),
            if (showTimerGif)
              Positioned(
                bottom: 100, // Adjust as needed
                right: 100, // Adjust as needed
                child: Image.asset(
                  'assets/gifs/Stopwatch.gif', // Specify your GIF file path here
                  width: 100, // Adjust size as needed
                  height: 100, // Adjust size as needed
                ),
              ),
          ],
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context, String dialogText,
      InteractiveImageModel currentImage) {
    showAnimatedDialog(
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
                child: Image.asset('assets/script11/2.png',
                    width: 180, height: 180),
              ),
              Positioned(
                top: -40,
                right: -50,
                child: Image.asset('assets/script11/1.png',
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
                    nextImage(); // Then, move to the next image
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
}
