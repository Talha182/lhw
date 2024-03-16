import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lhw/course_models/courses_models.dart';

import '../../Presentation/Presentation.dart';
import '../../models/interactive_images_model.dart';
import '../../controllers/feature_navigation.dart';

class InteractiveImages extends StatefulWidget {
  final List<InteractiveImageModel> imagesInfo;
  final VoidCallback? onCompleted; // Optional callback

  const InteractiveImages(
      {Key? key, required this.imagesInfo, this.onCompleted})
      : super(key: key);

  @override
  _InteractiveImagesState createState() => _InteractiveImagesState();
}

class _InteractiveImagesState extends State<InteractiveImages> {
  int currentIndex = 0;
  bool hasBeenDroppedSuccessfully = false;
  bool isMessageVisible = false;
  Timer? iconTimer;
  bool showTimerGif = false;
  bool showMessage = true;
  double _fabYPosition = 300.0; // Default position
  bool showRippleEffect = false;
  Offset? ripplePosition;
  Key guideTextKey = UniqueKey();



  @override
  void initState() {
    super.initState();
    _startMessageTimer();

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

  void _startMessageTimer({int durationInSeconds = 10}) {
    iconTimer
        ?.cancel(); // Ensure any existing timer is cancelled before starting a new one
    iconTimer = Timer(Duration(seconds: durationInSeconds), () {
      if (mounted) {
        setState(() {
          showMessage = false;
        });
      }
    });
  }

  void _showMessageAgain() {
    if (widget.imagesInfo[currentIndex].showGuideText) {
      setState(() {
        showMessage = true;
        guideTextKey = UniqueKey(); // Reset the guide text animation
      });
      _startMessageTimer(durationInSeconds: 10);
    }
  }

  void showMessageTemporarily() {
    setState(() => isMessageVisible = true);
    _startMessageTimer(
        durationInSeconds:
            10); // Use _startMessageTimer for consistency and to ensure any existing timer is cancelled
  }

  void nextImage() {
    if (currentIndex < widget.imagesInfo.length - 1) {
      setState(() {
        currentIndex += 1;
        guideTextKey = UniqueKey(); // Reset the guide text animation
        showMessage = widget.imagesInfo[currentIndex].showGuideText;
        isMessageVisible = false;
        iconTimer?.cancel();
        if (widget.imagesInfo[currentIndex].showGuideText) {
          _startMessageTimer();
        }
      });

      if (widget.imagesInfo[currentIndex].autoShowDialog) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            showCustomDialog(
                context,
                widget.imagesInfo[currentIndex].dialogText,
                widget.imagesInfo[currentIndex]);
          }
        });
      }
    } else if (widget.onCompleted != null) {
      widget.onCompleted!(); // Callback when all images have been shown
    }
  }

  final AudioPlayer audioPlayer = AudioPlayer();

  void playTapSound() async {
    await audioPlayer.play(AssetSource('assets/sounds/MouseClick.mp3'));
  }

  void playSwipeSound() async {
    await audioPlayer.play(AssetSource('assets/sounds/Swipe.mp3'));
  }

  void playLongPressSound() async {
    await audioPlayer.play(AssetSource('assets/sounds/ClickHold.mp3'));
  }

  void playDragDropSound() async {
    await audioPlayer.play(AssetSource('assets/sounds/DragDrop.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    final InteractiveImageModel currentImage = widget.imagesInfo[currentIndex];
    Rect touchArea = currentImage.touchArea;
    double left = touchArea.left;
    double top = touchArea.top;
    double width = touchArea.width;
    double height = touchArea.height;
    final screenHeight = MediaQuery.of(context).size.height;
    final fabHeight = 56.0; // Standard height of a FAB
    final topSafeArea = MediaQuery.of(context).padding.top;
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;

    String currentImagePath = currentImage.image;

    Widget draggableWidget(InteractiveImageModel currentImage) {
      // Assuming you know the original dimensions of the image or have a way to obtain them
      double originalWidth = 250; // Example original width
      double originalHeight = 350; // Example original height

      if (currentImage.draggableImage != null && !hasBeenDroppedSuccessfully) {
        return Positioned(
          left: currentImage.draggableImageInitialPosition?.dx ?? 0,
          top: currentImage.draggableImageInitialPosition?.dy ?? 0,
          child: Draggable(
            data: currentImage.image,
            feedback: Material(
              color: Colors.transparent,
              child: Transform.scale(
                scale: currentImage.draggableImageScale,
                child: Image.asset(
                  currentImage.draggableImage!,
                  width: originalWidth,
                  height: originalHeight,
                ),
              ),
            ),
            childWhenDragging: Container(),
            child: Transform.scale(
              scale: currentImage.draggableImageScale,
              child: Image.asset(
                currentImage.draggableImage!,
                width: originalWidth,
                height: originalHeight,
              ),
            ),
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
                width: currentImage.dragTargetWidth,
                height: currentImage.dragTargetHeight,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // border: Border.all(color: Colors.green, width: 2),
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
            if (currentImage.touchArea.contains(localPosition)) {
              playTapSound();

              // Check if the ripple effect should be shown
              if (currentImage.showRippleEffect) {
                setState(() {
                  showRippleEffect = true;
                  // Assuming you want the ripple to appear over the touched area
                  ripplePosition = Offset(
                      currentImage.touchArea.left, currentImage.touchArea.top);
                });

                // Use a delay matching your ripple animation duration before proceeding
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    showRippleEffect = false;
                  });

                  if (currentImage.showDialog) {
                    showCustomDialog(
                        context, currentImage.dialogText, currentImage);
                  }
                });
              } else if (currentImage.showDialog) {
                // If not showing ripple effect, but dialog is enabled
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
              if (!showTimerGif) {
                // Check to prevent restarting
                setState(() {
                  showTimerGif = true; // Show the GIF
                });
                iconTimer?.cancel(); // Cancel any previous timer
                iconTimer = Timer(const Duration(seconds: 7), () {
                  if (mounted) {
                    setState(() {
                      showTimerGif = false; // Hide the GIF after timer ends
                    });
                    nextImage(); // Navigate to the next image
                  }
                });
              }
            }
            // Implement additional long press actions as needed
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
                    Get.back(result: true);
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.black,
                )),
            draggableWidget(currentImage),
            dragTargetWidget(currentImage),
            if (showRippleEffect && ripplePosition != null)
              Positioned(
                left: ripplePosition!.dx,
                top: ripplePosition!.dy,
                child: Image.asset(
                  'assets/gifs/ripple.gif', // Path to your ripple GIF
                  fit: BoxFit.cover,
                  width: currentImage.touchArea.width, // Or some appropriate size
                  height: currentImage.touchArea.height, // Or some appropriate size
                ),
              ),
            if (showTimerGif)
              Positioned(
                bottom: 100, // Adjust as needed
                right: 200, // Adjust as needed
                child: Image.asset(
                  'assets/gifs/Stopwatch.gif', // Specify your GIF file path here
                  width: 150, // Adjust size as needed
                  height: 150, // Adjust size as needed
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
                child: Container(
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
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                              child: AnimatedTextKit(
                                key: guideTextKey, // Use the key here
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    currentImage.guide,
                                    textAlign: TextAlign.center,
                                    textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: "UrduType"),
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
                      const SizedBox(
                        width: 5,
                      ),
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
                    // Close the dialog immediately
                    Navigator.of(dialogContext).pop();

                    // Wait for two seconds before moving to the next image
                    Future.delayed(const Duration(seconds: 2), () {
                      // Ensure we only attempt to change the state if the widget is still mounted
                      if (mounted) {
                        nextImage(); // Move to the next image
                      }
                    });
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
