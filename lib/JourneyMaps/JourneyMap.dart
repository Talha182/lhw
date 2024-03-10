import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lhw/CourseTabbar/course_provider.dart';
import 'package:lhw/ModuleScreen/ModuleScreen.dart';
import 'package:provider/provider.dart';
import '../CourseTabbar/FeaturesListScreen.dart';
import '../controllers/feature_navigation.dart';
import '../course_models/courses_models.dart';

class JourneyMapScreen extends StatefulWidget {
  final Course course;
  final Module module;
  final String courseTitle; // Add this line
  final Gradient gradient;
  final int courseQuizCount;
  final int moduleId;
  final int courseModuleCount;
  final String imagePath;
  final int courseId;

  const JourneyMapScreen(
      {Key? key,
      required this.module,
      required this.course,
      required this.courseTitle,
      required this.gradient,
      required this.courseQuizCount,
      required this.courseModuleCount,
      required this.courseId,
      required this.moduleId,
      required this.imagePath})
      : super(key: key);

  @override
  State<JourneyMapScreen> createState() => _JourneyMapScreenState();
}

class _JourneyMapScreenState extends State<JourneyMapScreen>
    with TickerProviderStateMixin {
  late AnimationController _cloudAnimationController1;
  Animation<double>? _cloudAnimation1;
  late AnimationController _cloudAnimationController2;
  Animation<double>? _cloudAnimation2;
  late AnimationController _pathAnimationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late AnimationController _avatarAnimationController;
  late Animation<double> _bounceAnimation;
  late ScrollController _scrollController;
  late double _bottomPadding;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _scrollController = ScrollController();
    _bottomPadding = 100.0; // Start with 100.0 padding from the bottom
    // Listener to detect scroll events
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 0) {
        // User has started scrolling, reduce padding to 0 to allow scrolling to the bottom
        setState(() {
          _bottomPadding = 0.0;
        });
      }
    });
    _pathAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _pathAnimationController, curve: Curves.ease));
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_pathAnimationController);
    _pathAnimationController.forward();

    _avatarAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
        lowerBound: 0.0,
        upperBound: 0.1)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _avatarAnimationController.stop();
        } else if (status == AnimationStatus.dismissed) {
          _avatarAnimationController.forward();
        }
      });
    _bounceAnimation = CurvedAnimation(
        parent: _avatarAnimationController, curve: Curves.elasticOut);

    _avatarAnimationController.forward();

    // Initialize with a default duration, but without using MediaQuery.
    _cloudAnimationController1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _cloudAnimationController2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      // Initialize the animations here
      _setupAnimations(screenWidth);
    });
  }

  void _setupAnimations(double screenWidth) {
    _cloudAnimation1 = Tween(begin: -50.0, end: screenWidth)
        .animate(_cloudAnimationController1)
      ..addListener(() {
        setState(() {}); // Call setState if needed
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _cloudAnimationController1.repeat();
        }
      });
    _cloudAnimationController1.forward();

    _cloudAnimation2 = Tween(begin: -30.0, end: screenWidth)
        .animate(_cloudAnimationController2)
      ..addListener(() {
        setState(() {}); // Same here
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _cloudAnimationController2.repeat();
        }
      });
    _cloudAnimationController2.forward();
  }

  @override
  void dispose() {
    _cloudAnimationController1.dispose();
    _cloudAnimationController2.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Row(
            children: [
              Text(
                widget.module.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "UrduType"),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.black),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Container(
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
          width: double.infinity,
          height: MediaQuery.of(context)
              .size
              .height, // Ensure the container fills the screen height
          child: Stack(
            children: [
              Positioned(
                top: 70,
                right: _cloudAnimation1?.value ?? 0, // Use null-aware access
                child: SvgPicture.asset('assets/images/cloud.svg',
                    width: 30, height: 30),
              ),
              Positioned(
                top: 90,
                left: _cloudAnimation2?.value ?? 0, // Use null-aware access
                child: SvgPicture.asset('assets/images/cloud.svg',
                    width: 30, height: 30),
              ),
              Positioned(
                bottom: 0,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: SvgPicture.asset("assets/images/build1.svg"),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 80,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: SvgPicture.asset("assets/images/build2.svg"),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 200,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: SvgPicture.asset("assets/images/build3.svg"),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: SvgPicture.asset("assets/images/build4.svg"),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: SvgPicture.asset("assets/images/bottom.svg"),
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                right: 15,
                child: ScaleTransition(
                  scale: _bounceAnimation,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xffF6B3D0),
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: SvgPicture.asset(
                          "assets/images/samina_instructor.svg",
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
              // Your existing stepper code as one layer
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller:
                            _scrollController, // Use the scroll controller here
                        padding: EdgeInsets.only(
                            bottom:
                                _bottomPadding), // Dynamic padding based on scrolling
                        itemCount: widget.module.submodules.length,
                        reverse: true, // The list is visually reversed.
                        itemBuilder: (BuildContext context, int index) {
                          Submodule submodule = widget.module.submodules[index];
                          bool isVisualLast = index == 0;
                          bool isVisualFirst =
                              index == widget.module.submodules.length - 1;

                          return StepperTile(
                            submodule: submodule,
                            onTap: () =>
                                _showSubmoduleDialog(context, submodule),
                            isFirst: isVisualFirst,
                            isLast: isVisualLast,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Position your images at the bottom of the screen
            ],
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    submodule.title,
                    style: const TextStyle(
                        fontFamily: "UrduType",
                        color: Color(0xff000000),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        "assets/images/person_card.svg",
                        color: const Color(0xff685F78),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        "$quizzesCount ٹیسٹ",
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "UrduType",
                            color: Color(0xff685F78)),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff685F78)),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.watch_later_outlined,
                        size: 16,
                      ),
                      const Text(
                        "01 گھنٹہ 30 منٹ",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "UrduType",
                            color: Color(0xff685F78)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "تفصیل",
                    style: TextStyle(
                        fontFamily: "UrduType",
                        color: Color(0xff000000),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    submodule.description,
                    style: const TextStyle(
                        fontFamily: "UrduType",
                        fontSize: 14,
                        color: Color(0xff7A7D84)),
                    textAlign: TextAlign.end,
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
                          'واپس',
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
                          'سبق جاری',
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
        );
      },
    );
  }

  void navigateToSubmoduleFeatures(Submodule submodule) {
    Get.to(() => FeaturesListScreen(
          submodule: submodule,
          moduleId: widget.moduleId,
          courseTitle: widget.courseTitle,
          courseQuizCount: widget.courseQuizCount,
          courseModuleCount: widget.courseModuleCount,
          imagePath: widget.imagePath,
          gradient: widget.gradient,
          courseId: widget.courseId, module: widget.module, course: widget.course, // Pass the course title here
        ));
  }
}

class StepperTile extends StatefulWidget {
  final Submodule submodule;
  final VoidCallback onTap;
  final bool isFirst;
  final bool isLast;

  const StepperTile({
    Key? key,
    required this.submodule,
    required this.onTap,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  @override
  _StepperTileState createState() => _StepperTileState();
}
class _StepperTileState extends State<StepperTile> {
  bool isSubmoduleCompleted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkSubmoduleCompletion();
  }

  void checkSubmoduleCompletion() async {
    bool completed = await Provider.of<CoursesProvider>(context)
        .isSubmoduleCompleted(widget.submodule.submoduleId);
    if (mounted) {
      setState(() {
        isSubmoduleCompleted = completed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xffFBE4F2), width: 2.0),
            ),
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Color(0xffFE8BD1), shape: BoxShape.circle),
              child: Center(
                child: Icon(
                  isSubmoduleCompleted ? Icons.check : Icons.start,
                  color: isSubmoduleCompleted ? Colors.green : Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Text(
              widget.submodule.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "UrduType",
                fontSize: 20,
              ),
            ),
          ),
          if (!widget.isLast)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomPaint(
                painter: DottedLinePainter(),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final Color color;
  final double height;
  final double width;

  DottedLinePainter(
      {this.color = Colors.grey, this.height = 1, this.width = 10});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = height;

    double dashWidth = width;
    double dashSpace = width;
    double startX = 0;
    while (startX < size.height) {
      canvas.drawLine(Offset(size.width / 2, startX),
          Offset(size.width / 2, startX + dashWidth), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
