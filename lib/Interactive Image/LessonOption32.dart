import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LessonOption32 extends StatefulWidget {
  const LessonOption32({super.key});

  @override
  State<LessonOption32> createState() => _LessonOption32State();
}

class _LessonOption32State extends State<LessonOption32> {
  bool isSelected = false;
  bool isAnswered = false;
  int questionIndex = 0;
  String selectedAnswer = '';
  int? selectedOptionIndex;
  List<bool> _isDragSuccessful = [
    false,
    false,
    false,
    false
  ]; // one for each container

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0, -0.2),
            colors: [
              const Color(0xff80B8FB).withOpacity(0.3),
              Colors.transparent,
            ],
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(
                              context); // This will navigate back when tapped
                        },
                        child: const Icon(
                          Icons.close,
                          size: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: 2.2),
                            duration: const Duration(milliseconds: 400),
                            builder: (BuildContext context, double value,
                                Widget? child) {
                              return LinearPercentIndicator(
                                lineHeight: 8.0,
                                percent: 1,
                                backgroundColor: Colors.white,
                                progressColor: const Color(0xffFE8BD1),
                                barRadius: const Radius.circular(10),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                        'assets/images/cloud.svg',
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: DragTarget<int>(
                              onWillAccept: (data) {
                                // Accept only dd1 and dd3
                                return data == 0 || data == 2;
                              },
                              onAccept: (data) {
                                setState(() {
                                  _isDragSuccessful[data] = true;
                                });
                              },
                              builder: (context, candidateData, rejectedData) {
                                return Image.asset(
                                  'assets/images/drag_drop.png',
                                  scale: 1,
                                );
                              },
                            ),
                          ),
                        ),
                        // Draggable Widget 1
                      ],
                    ),
                  ),
                  const Spacer(),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black87.withOpacity(0.1),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFE8BD1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(150, 37),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'جاری رہے',
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            if (!_isDragSuccessful[0])
              Positioned(
                bottom: 140,
                left: 80,
                child: Draggable<int>(
                  data: 0,
                  feedback: DraggableContainer(
                    image: Image.asset(
                      "assets/images/dd1.png",
                      fit: BoxFit.scaleDown,
                      width: 60,
                      height: 60,
                    ),
                  ),
                  childWhenDragging: Container(),
                  onDragEnd: (details) {
                    setState(() {
                      _isDragSuccessful[0] = true;
                    });
                  },
                  child: DraggableContainer(
                    image: Image.asset(
                      "assets/images/dd1.png",
                      fit: BoxFit.scaleDown,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
              ),

            // Draggable Widget 2
            if (!_isDragSuccessful[1])
              Positioned(
                bottom: 260,
                left: 80,
                child: Draggable<int>(
                  data: 1,
                  feedback: DraggableContainer(
                    image: Image.asset(
                      "assets/images/dd2.png",
                      fit: BoxFit.scaleDown,
                      width: 60,
                      height: 60,
                    ),
                  ),
                  childWhenDragging: Container(),
                  onDraggableCanceled: (velocity, offset) {
                    setState(() {
                      _isDragSuccessful[1] = false; // For dd2
                    });
                  },
                  child: DraggableContainer(
                    image: Image.asset(
                      "assets/images/dd2.png",
                      fit: BoxFit.scaleDown,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
              ),

            // Draggable Widget 3
            if (!_isDragSuccessful[2])
              Positioned(
                bottom: 260,
                left: 220,
                child: Draggable<int>(
                  data: 2,
                  feedback: DraggableContainer(
                    image: Image.asset(
                      "assets/images/dd3.png",
                      fit: BoxFit.scaleDown,
                      width: 60,
                      height: 60,
                    ),
                  ),
                  childWhenDragging: Container(),
                  onDragEnd: (details) {
                    setState(() {
                      _isDragSuccessful[2] = true;
                    });
                  },
                  child: DraggableContainer(
                    image: Image.asset(
                      "assets/images/dd3.png",
                      fit: BoxFit.scaleDown,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
              ),

            // Draggable Widget 4
            if (!_isDragSuccessful[3])
              Positioned(
                bottom: 140,
                left: 220,
                child: Draggable<int>(
                  data: 3,
                  feedback: DraggableContainer(
                    image: Image.asset(
                      "assets/images/dd4.png",
                      fit: BoxFit.scaleDown,
                      width: 60,
                      height: 60,
                    ),
                  ),
                  childWhenDragging: Container(),
                  onDraggableCanceled: (velocity, offset) {
                    setState(() {
                      _isDragSuccessful[3] = false; // For dd4
                    });
                  },
                  child: DraggableContainer(
                    image: Image.asset(
                      "assets/images/dd4.png",
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DraggableContainer extends StatelessWidget {
  final Image image;
  const DraggableContainer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffEAF9F0),
        border: Border.all(color: Color(0xffB6E1C6), width: 2),
      ),
      child: Center(
        child: ClipOval(child: image),
      ),
    );
  }
}
