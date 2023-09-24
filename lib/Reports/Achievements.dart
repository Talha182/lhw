import 'package:flutter/material.dart';
import 'package:progresso/progresso.dart';

class Achievements extends StatefulWidget {
  const Achievements({Key? key}) : super(key: key);

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [
              const Text(
                "کامیابیاں اور پہچان",
                style: TextStyle(fontFamily: "UrduType", fontSize: 18),
              ),
              const SizedBox(height: 10),
              Container(
                height: 1030,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "اچیومنٹ بیجز",
                        style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                      ),
                      const Text(
                        "اپنے حاصل کردہ بیجز کا مجموعہ اور ان سے متعلقہ کامیابیاں دیکھیں",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 14,
                            color: Color(0xff8B9DA0)),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 920,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xffE3E3E3)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Image.asset(
                                        "assets/images/badge1.png",
                                        scale: 0.8),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Space between the new text and "روشن خیال"
                                            Text(
                                              "روشن خیال",
                                              style: TextStyle(
                                                fontFamily: "UrduType",
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              "10/14", // Replace this with your desired text
                                              style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize:
                                                      14, // Adjust this as needed
                                                  color: Color(0xff8B9DA0)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        RightStartingProgressBar(
                                          width: 320,
                                          height: 10,
                                          targetProgress: 0.2,
                                          backgroundColor:
                                              const Color(0xffEBEBF0),
                                          strokeWidth: 10.0,
                                        ),
                                        const Text(
                                          "14 دن کے سلسلے تک پہنچیں۔",
                                          style: TextStyle(
                                              fontFamily: "UrduType",
                                              color: Color(0xff8B9DA0)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Image.asset(
                                        "assets/images/badge2.png",
                                        scale: 0.8),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Space between the new text and "روشن خیال"
                                            Text(
                                              "روشن خیال",
                                              style: TextStyle(
                                                fontFamily: "UrduType",
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              "10/14", // Replace this with your desired text
                                              style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize:
                                                      14, // Adjust this as needed
                                                  color: Color(0xff8B9DA0)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        RightStartingProgressBar(
                                          width: 320,
                                          height: 10,
                                          targetProgress: 0.2,
                                          backgroundColor:
                                              const Color(0xffEBEBF0),
                                          strokeWidth: 10.0,
                                        ),
                                        const Text(
                                          "14 دن کے سلسلے تک پہنچیں۔",
                                          style: TextStyle(
                                              fontFamily: "UrduType",
                                              color: Color(0xff8B9DA0)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Image.asset(
                                        "assets/images/badge3.png",
                                        scale: 0.8),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Space between the new text and "روشن خیال"
                                            Text(
                                              "روشن خیال",
                                              style: TextStyle(
                                                fontFamily: "UrduType",
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              "10/14", // Replace this with your desired text
                                              style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize:
                                                      14, // Adjust this as needed
                                                  color: Color(0xff8B9DA0)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        RightStartingProgressBar(
                                          width: 320,
                                          height: 10,
                                          targetProgress: 0.2,
                                          backgroundColor:
                                              const Color(0xffEBEBF0),
                                          strokeWidth: 10.0,
                                        ),
                                        const Text(
                                          "14 دن کے سلسلے تک پہنچیں۔",
                                          style: TextStyle(
                                              fontFamily: "UrduType",
                                              color: Color(0xff8B9DA0)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Image.asset(
                                        "assets/images/badge4.png",
                                        scale: 0.8),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Space between the new text and "روشن خیال"
                                            Text(
                                              "روشن خیال",
                                              style: TextStyle(
                                                fontFamily: "UrduType",
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              "10/14", // Replace this with your desired text
                                              style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize:
                                                      14, // Adjust this as needed
                                                  color: Color(0xff8B9DA0)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        RightStartingProgressBar(
                                          width: 320,
                                          height: 10,
                                          targetProgress: 0.2,
                                          backgroundColor:
                                              const Color(0xffEBEBF0),
                                          strokeWidth: 10.0,
                                        ),
                                        const Text(
                                          "14 دن کے سلسلے تک پہنچیں۔",
                                          style: TextStyle(
                                              fontFamily: "UrduType",
                                              color: Color(0xff8B9DA0)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Image.asset(
                                        "assets/images/badge5.png",
                                        scale: 0.8),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Space between the new text and "روشن خیال"
                                            Text(
                                              "روشن خیال",
                                              style: TextStyle(
                                                fontFamily: "UrduType",
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              "10/14", // Replace this with your desired text
                                              style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize:
                                                      14, // Adjust this as needed
                                                  color: Color(0xff8B9DA0)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        RightStartingProgressBar(
                                          width: 320,
                                          height: 10,
                                          targetProgress: 0.2,
                                          backgroundColor:
                                              const Color(0xffEBEBF0),
                                          strokeWidth: 10.0,
                                        ),
                                        const Text(
                                          "14 دن کے سلسلے تک پہنچیں۔",
                                          style: TextStyle(
                                              fontFamily: "UrduType",
                                              color: Color(0xff8B9DA0)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Image.asset(
                                        "assets/images/badge1.png",
                                        scale: 0.8),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Space between the new text and "روشن خیال"
                                            Text(
                                              "روشن خیال",
                                              style: TextStyle(
                                                fontFamily: "UrduType",
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              "10/14", // Replace this with your desired text
                                              style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize:
                                                      14, // Adjust this as needed
                                                  color: Color(0xff8B9DA0)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        RightStartingProgressBar(
                                          width: 320,
                                          height: 10,
                                          targetProgress: 0.2,
                                          backgroundColor:
                                              const Color(0xffEBEBF0),
                                          strokeWidth: 10.0,
                                        ),
                                        const Text(
                                          "14 دن کے سلسلے تک پہنچیں۔",
                                          style: TextStyle(
                                              fontFamily: "UrduType",
                                              color: Color(0xff8B9DA0)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Image.asset(
                                        "assets/images/badge1.png",
                                        scale: 0.8),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Space between the new text and "روشن خیال"
                                            Text(
                                              "روشن خیال",
                                              style: TextStyle(
                                                fontFamily: "UrduType",
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              "10/14", // Replace this with your desired text
                                              style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize:
                                                      14, // Adjust this as needed
                                                  color: Color(0xff8B9DA0)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        RightStartingProgressBar(
                                          width: 320,
                                          height: 10,
                                          targetProgress: 0.2,
                                          backgroundColor:
                                              const Color(0xffEBEBF0),
                                          strokeWidth: 10.0,
                                        ),
                                        const Text(
                                          "14 دن کے سلسلے تک پہنچیں۔",
                                          style: TextStyle(
                                              fontFamily: "UrduType",
                                              color: Color(0xff8B9DA0)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RightStartingProgressBar extends StatefulWidget {
  final double width;
  final double height;
  final double
      targetProgress; // Renamed to "targetProgress" to indicate final value after animation
  final Color backgroundColor;
  final double strokeWidth;

  RightStartingProgressBar({
    required this.width,
    required this.height,
    required this.targetProgress,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  _RightStartingProgressBarState createState() =>
      _RightStartingProgressBarState();
}

class _RightStartingProgressBarState extends State<RightStartingProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Animation duration
      vsync: this,
    );

    _animation =
        Tween<double>(begin: 0, end: widget.targetProgress).animate(_controller)
          ..addListener(() {
            setState(
                () {}); // Trigger a rebuild whenever the animation value changes
          });

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Clean up the controller when the widget is removed from the widget tree
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.strokeWidth / 2),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: (widget.height - widget.strokeWidth) / 2,
            child: Container(
              height: widget.strokeWidth,
              width: widget.width *
                  _animation.value, // Use the animation value here
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xffF4D6A9), Color(0xffEAAF58)]),
                borderRadius: BorderRadius.circular(widget.strokeWidth / 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
