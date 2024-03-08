import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import '../CourseTabbar/course_provider.dart';
import '../CustomWidgets/Row_Column_Padding.dart';
import '../JourneyMaps/JourneyMap.dart';
import '../JourneyMaps/JourneyMap2.dart';
import '../Mobile_Module & Submodule/module_dashboard_card.dart';
import '../course_models/courses_models.dart';
import '../models/user_model.dart';
import '../services/global_user.dart';

class ModuleScreen extends StatefulWidget {
  final Course course;

  const ModuleScreen({Key? key, required this.course}) : super(key: key);

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  bool _feedbackButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    Color startColor =
        Color(int.parse(widget.course.gradient[0].replaceAll('#', '0xff')));
    Color(int.parse(widget.course.gradient[0].replaceAll('#', '0xff')));
    Color endColor =
        Color(int.parse(widget.course.gradient[1].replaceAll('#', '0xff')));
    return Consumer<CoursesProvider>(builder: (context, provider, child) {
      final course = provider.findCourseById(widget.course.courseId);

      if (course == null) {
        return const Scaffold(body: Center(child: Text('Course not found')));
      }
      provider.fetchAllModulesProgress(course.courseId);

      // User? currentUser = GlobalUser.getCurrentUser;
      // if (currentUser != null) {
      //   print(currentUser.name);
      // }

      // Debugging: Print course progress
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1.0,
          backgroundColor: Colors.white,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: InkWell(
                    child: const Icon(Icons.more_vert),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    course.title,
                    style: const TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ).animate().fadeIn().scale(),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    child: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Container(
                height: 200,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      startColor,
                      endColor,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Image.asset(
                        course!.imagePath,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 20, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "یونٹ:",
                                style: TextStyle(
                                  fontFamily: 'UrduType',
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                ),
                              ),
                              Text(
                                course.title,
                                style: const TextStyle(
                                  fontFamily: 'UrduType',
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${(course.progress * 100).toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  fontFamily: 'UrduType',
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 2),
                              LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width * 0.4,
                                lineHeight: 5.0,
                                percent: course.progress,
                                backgroundColor: Colors.white,
                                barRadius: const Radius.circular(10),
                                progressColor: const Color(0xff9AC9C2),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/module.svg',
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${course.moduleCount} ٹیسٹ',
                                style: const TextStyle(
                                  fontFamily: 'UrduType',
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.circle,
                                  color: Colors.white, size: 6),
                              const SizedBox(width: 8),
                              SvgPicture.asset(
                                'assets/images/person_card.svg',
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${course.quizCount} اسباق',
                                style: const TextStyle(
                                  fontFamily: 'UrduType',
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          _feedbackButtonPressed
                              ? RatingBar.builder(
                                  initialRating: 0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    disabledForegroundColor:
                                        Colors.white.withOpacity(0.38),
                                    disabledBackgroundColor:
                                        Colors.white.withOpacity(0.12),
                                    side: const BorderSide(
                                        color: Colors.white, width: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _feedbackButtonPressed = true;
                                    });
                                  },
                                  child: const Text(
                                    "رائے فراہم کریں۔",
                                    style: TextStyle(
                                      fontFamily: 'UrduType',
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 12.0, right: 25.0, bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'یونٹ کا مواد',
                      style: TextStyle(
                          fontFamily: "UrduType",
                          color: Color(0xff1C1D1F),
                          letterSpacing: 1,
                          fontSize: 24),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ...rowPadded([
                          const Text(
                            'کل وقت: 5 گھنٹے 45 منٹ',
                            style: TextStyle(
                                fontFamily: "UrduType",
                                color: Color(0xff7A7D84),
                                letterSpacing: 1,
                                fontSize: 12),
                          ),
                          SvgPicture.asset('assets/images/person_card.svg'),
                          const Text(
                            '•',
                            style: TextStyle(
                                fontFamily: "UrduType",
                                color: Color(0xff232323),
                                fontSize: 12),
                          ),
                          Text(
                            '${course.moduleCount} ٹیسٹ',
                            style: const TextStyle(
                                fontFamily: "UrduType",
                                color: Color(0xff7A7D84),
                                letterSpacing: 1,
                                fontSize: 12),
                          ),
                          SvgPicture.asset('assets/images/person_card.svg'),
                          const Text(
                            '•',
                            style: TextStyle(
                                fontFamily: "UrduType",
                                color: Color(0xff232323),
                                fontSize: 12),
                          ),
                          Text(
                            '${course.quizCount} اسباق',
                            style: const TextStyle(
                                fontFamily: "UrduType",
                                color: Color(0xff7A7D84),
                                letterSpacing: 1,
                                fontSize: 12),
                          ),
                          SvgPicture.asset('assets/images/module.svg'),
                        ], 3)
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFE8BD1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Circular radius
                      ),
                      minimumSize: const Size(150, 40),
                    ),
                    onPressed: () {
                      // Add your action here
                    },
                    child: const Text(
                      'یونٹ جاری رکھیں',
                      style: TextStyle(
                        fontFamily: "UrduType",
                        fontSize: 14,
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      // Background color
                      side: const BorderSide(
                        color: Colors.black, // Border color
                        width: 1,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Circular radius
                      ),
                      minimumSize: const Size(200, 40),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Text(
                          'اس یونٹ کو ڈونلوڈ کریں',
                          style: TextStyle(
                              fontFamily: "UrduType",
                              color: Colors.black,
                              letterSpacing: 1,
                              fontSize: 14),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset('assets/images/download.svg'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: course.modules.length,
                  itemBuilder: (context, index) {
                    final module = course.modules[index];
                    double progressValue =
                        provider.getModuleProgress(module.moduleId);

                    return Module_Card(
                      progressValue: progressValue,
                      showProgressBar: module.isStart,
                      imagePath: module.imagePath,
                      moduleTitle: module.title,
                      onClick: () {
                        setState(() {
                          course.modules[index].isStart = true;
                        });
                        Get.to(
                          () => JourneyMapScreen(
                            module: module,
                            courseTitle: course.title,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [startColor, endColor],
                            ),
                            courseQuizCount: course.quizCount,
                            courseModuleCount: course.moduleCount,
                            imagePath: course.imagePath,
                            courseId: course.courseId,
                            moduleId: module.moduleId, course: widget.course,
                          ),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                      moduleCount: module.submoduleCount,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
