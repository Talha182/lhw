import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../CourseTabbar/ModuleScreen/FeaturesListScreen.dart';
import '../controllers/feature_navigation.dart';
import '../courses_test/test_model.dart';

class JourneyMapScreen extends StatelessWidget {
  final Module module;
  final String courseTitle; // Add this line
  final Gradient gradient;
  final int courseQuizCount;
  final int courseModuleCount;
  final String imagePath;

  const JourneyMapScreen(
      {Key? key,
      required this.module,
      required this.courseTitle,
      required this.gradient,
      required this.courseQuizCount,
      required this.courseModuleCount,
      required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0, -0.2),
            colors: [
              const Color(0xff80B8FB).withOpacity(0.3),
              Colors.transparent
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 70,
              right: 30,
              child: SvgPicture.asset('assets/images/cloud.svg',
                  width: 30, height: 30),
            ),
            Positioned(
              top: 90,
              left: 30,
              child: SvgPicture.asset('assets/images/cloud.svg',
                  width: 30, height: 30),
            ),
            Positioned(
              left: 10,
              top: 180,
              child: SvgPicture.asset("assets/images/path.svg"),
            ),
            Positioned(
              left: 15,
              top: 190,
              child: SvgPicture.asset("assets/images/path_dots.svg"),
            ),
            Positioned(
              left: 10,
              top: 110,
              child: SvgPicture.asset("assets/images/pencil.svg"),
            ),
            Positioned(
              bottom: 0,
              child: SvgPicture.asset("assets/images/build1.svg"),
            ),
            Positioned(
              bottom: 0,
              left: 80,
              child: SvgPicture.asset("assets/images/build2.svg"),
            ),
            Positioned(
              bottom: 0,
              left: 200,
              child: SvgPicture.asset("assets/images/build3.svg"),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset("assets/images/build4.svg"),
            ),
            Positioned(
              bottom: 0,
              child: SvgPicture.asset("assets/images/bottom.svg"),
            ),
            Positioned(
              bottom: 60,
              right: 15,
              child: CircleAvatar(
                backgroundColor: const Color(0xffF6B3D0),
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: SvgPicture.asset("assets/images/samina_instructor.svg",
                      fit: BoxFit.fill),
                ),
              ),
            ),
            ...module.submodules.asMap().entries.map((entry) {
              int index = entry.key;
              Submodule submodule = module.submodules[index];
              bool isRightAligned = submodule.titleAlignment == 'right';

              Offset buttonPosition = Offset(
                submodule.buttonPosition['dx'] ?? 0.0, // Provide a default value in case the key doesn't exist
                submodule.buttonPosition['dy'] ?? 0.0,
              );

              return Positioned(
                left: buttonPosition.dx,
                top: buttonPosition.dy,
                child: isRightAligned
                    ? _buildRightAlignedRow(context, submodule)
                    : _buildLeftAlignedRow(context, submodule),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftAlignedRow(BuildContext context, Submodule submodule) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          submodule.title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: "UrduType", fontSize: 20),
        ),
        const SizedBox(width: 8),
        _buildIconButton(context, submodule),
      ],
    );
  }

  Widget _buildRightAlignedRow(BuildContext context, Submodule submodule) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconButton(context, submodule),
        const SizedBox(width: 8),
        Text(
          submodule.title,
          style: const TextStyle(fontFamily: "UrduType", fontSize: 20),
        ),
      ],
    );
  }

  Widget _buildIconButton(BuildContext context, Submodule submodule) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffD9D9D9)),
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: Container(
          width: 45,
          height: 45,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffFF6BC5),
          ),
          child: IconButton(
            onPressed: () => _showSubmoduleDialog(context, submodule),
            icon: SvgPicture.asset(
              submodule.iconPath,
              width: 24,
              height: 24,
            ),
            iconSize: 24,
          ),
        ),
      ),
    );
  }

  void _showSubmoduleDialog(BuildContext context, Submodule submodule) {
    final int quizzesCount = submodule.numberOfQuizzes;

    showAnimatedDialog(
      curve: Curves.decelerate,
      animationType: DialogTransitionType.sizeFade,
      duration: const Duration(seconds: 1),
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 365,
              maxWidth: MediaQuery.of(context).size.width - 50,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      submodule.title,
                      style: const TextStyle(
                          fontFamily: "UrduType",
                          color: Color(0xff685F78),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          "01 گھنٹہ 30 منٹ",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "UrduType",
                              color: Color(0xff685F78)),
                        ),
                        const Icon(
                          Icons.watch_later_outlined,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xff685F78)),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "$quizzesCount کوئز",
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "UrduType",
                              color: Color(0xff685F78)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      submodule.description,
                      style: const TextStyle(
                          fontFamily: "UrduType",
                          fontSize: 14,
                          color: Color(0xff7A7D84)),
                      textAlign: TextAlign.justify,
                    ),
                    const Spacer(),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: const Size(140, 40),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text(
                            'منسوخ کریں۔',
                            style: TextStyle(
                                fontFamily: "UrduType",
                                color: Colors.black,
                                fontSize: 15),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFE8BD1),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: const Size(140, 40),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            navigateToSubmoduleFeatures(submodule);
                          },
                          child: const Text(
                            'کورس جاری رکھیں',
                            style: TextStyle(
                              fontFamily: "UrduType",
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void navigateToSubmoduleFeatures(Submodule submodule) {
    Get.to(() => FeaturesListScreen(
          submodule: submodule,
          courseTitle: courseTitle,
          courseQuizCount: courseQuizCount,
          courseModuleCount: courseModuleCount,
          imagePath: imagePath,
          gradient: gradient, // Pass the course title here
        ));
  }
}
// void navigateToSubmoduleFeatures(BuildContext context, Submodule submodule) {
//   // Check if a controller already exists and reset it, or create a new one
//   if (Get.isRegistered<FeatureNavigationController>()) {
//     var existingController = Get.find<FeatureNavigationController>();
//     existingController.resetControllerWithNewCallbacks(submodule.navigateToFeatureCallbacks);
//   } else {
//     Get.put(FeatureNavigationController(
//       navigateToFeatureCallbacks: submodule.navigateToFeatureCallbacks,
//       navigateBackToJourneyMap: () => Get.back(),
//     )); // Optionally use a unique tag for each submodule if needed
//   }
//
//   // Navigate to the first feature callback
//   Get.find<FeatureNavigationController>().navigateToNextFeatureOrBack();
// }
