import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhw/courses_test/test_model.dart';
import 'package:provider/provider.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import '../CourseTabbar/course_provider.dart';
import '../CustomWidgets/Row_Column_Padding.dart';
import '../JourneyMaps/JourneyMap.dart';
import '../JourneyMaps/JourneyMap2.dart';
import '../Mobile_Module & Submodule/module_dashboard_card.dart';

class ModuleScreen extends StatefulWidget {
  final Course course;

  const ModuleScreen({Key? key, required this.course}) : super(key: key);

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen>
    with WidgetsBindingObserver {
  bool _feedbackButtonPressed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Add observer
    updateModulesProgress();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<CoursesProvider>(context, listen: false)
        .addListener(_onProgressUpdated);
  }

  void updateModulesProgress() {
    widget.course.modules.forEach((module) {
      module.updateProgressValue(); // Calculate the progress
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    Provider.of<CoursesProvider>(context, listen: false)
        .removeListener(_onProgressUpdated);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Screen is back in focus
      updateModulesProgress();
    }
  }

  void _onProgressUpdated() {
    setState(() {
      // This empty setState is necessary to trigger a rebuild when progress updates
    });
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course; // Accessing the course from widget property
    double progressValue = course.progress;
    Color startColor =
        Color(int.parse(course.gradient['start']!.replaceAll('#', '0xff')));
    Color endColor =
        Color(int.parse(course.gradient['end']!.replaceAll('#', '0xff')));

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
                  child: const Icon(Icons.arrow_back),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: const Text(
                  "عنوان",
                  style: TextStyle(
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
                  child: const Icon(Icons.more_vert),
                  onTap: () {},
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
                    child: Image.asset(
                      course.imagePath,
                      scale: 0.9,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, top: 4, bottom: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: const TextStyle(
                            fontFamily: 'UrduType',
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${(progressValue * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontFamily: 'UrduType',
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            AnimatedProgressBar(
                              height: 5,
                              width: MediaQuery.of(context).size.width * 0.4,
                              value: progressValue,
                              duration: const Duration(seconds: 2),
                              color: const Color(0xff9AC9C2),
                              backgroundColor: Colors.white,
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
                              '${course.moduleCount} ماڈیولز',
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
                              '${course.quizCount} کوئز',
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
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
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
                                  primary: Colors.transparent,
                                  onSurface: Colors.white,
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
                                  'فیڈ بیک فراہم کریں',
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
              child: Row(
                children: [
                  ...rowPadded([
                    SvgPicture.asset('assets/images/module.svg'),
                    Text(
                      '${course.moduleCount} ماڈیولز',
                      style: const TextStyle(
                          fontFamily: "UrduType",
                          color: Color(0xff7A7D84),
                          letterSpacing: 1,
                          fontSize: 14),
                    ),
                    const Text(
                      '•',
                      style: TextStyle(
                          fontFamily: "UrduType",
                          color: Color(0xff232323),
                          fontSize: 18),
                    ),
                    SvgPicture.asset('assets/images/person_card.svg'),
                    Text(
                      '${course.quizCount} کوئز',
                      style: const TextStyle(
                          fontFamily: "UrduType",
                          color: Color(0xff7A7D84),
                          letterSpacing: 1,
                          fontSize: 14),
                    ),
                    const Text(
                      '•',
                      style: TextStyle(
                          fontFamily: "UrduType",
                          color: Color(0xff232323),
                          fontSize: 18),
                    ),
                    const Text(
                      '5h 45m کل لمبائی',
                      style: TextStyle(
                          fontFamily: "UrduType",
                          color: Color(0xff7A7D84),
                          letterSpacing: 1,
                          fontSize: 14),
                    )
                  ], 4)
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
                    'کورس جاری رکھیں',
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
                      SvgPicture.asset('assets/images/download.svg'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'مواد ڈاؤن لوڈ کریں۔',
                        style: TextStyle(
                            fontFamily: "UrduType",
                            color: Colors.black,
                            letterSpacing: 1,
                            fontSize: 14),
                      )
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
                  return Module_Card(
                    progressValue: module.progressValue,
                    showProgressBar: module.isStart,
                    imagePath: module.imagePath,
                    cardText: module.title,
                    onClick: () {
                      setState(() {
                        course.modules[index].isStart =
                            true; // Update the module's isStart to true
                      });
                      Get.to(
                        () => JourneyMapScreen(
                          module: module,
                          courseTitle: course.title,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              startColor,
                              endColor,
                            ],
                          ),
                          courseQuizCount: course.quizCount,
                          courseModuleCount: course.moduleCount,
                          imagePath: course.imagePath,
                          courseId: course.courseId,
                        ),
                        transition: Transition.fade,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                  );
                },
              ).animate().fade(duration: 400.ms),
            ),
          ],
        ),
      ),
    );
  }
}
