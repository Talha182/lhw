  import 'package:flutter/material.dart';
  import 'package:flutter_svg/svg.dart';
  import 'package:percent_indicator/linear_percent_indicator.dart';

  class DragDrop extends StatefulWidget {
    const DragDrop({super.key});

    @override
    State<DragDrop> createState() => _DragDropState();
  }

  class _DragDropState extends State<DragDrop> {
    bool isSelected = false;
    bool isAnswered = false;
    int _current = 0;
    int _totalSteps = 100;
    int questionIndex = 0;
    String selectedAnswer = '';
    int? selectedOptionIndex;
    List<bool> isDragged =
        List.generate(8, (index) => false); // assuming 8 buttons
    List<String> box1Answers = [];
    List<String> box2Answers = [];

    List<bool> isInTarget =
        List.generate(8, (index) => false); // assuming 8 buttons
    Map<String, String> buttonLabels = {
      'button1': 'Lactic acid',
      'button2': 'Sodium hydroxide',
      'button3': 'Acetic acid',
      'button4': 'Hydrochloric acid',
      'button5': 'Barium hydroxide',
      'button6': 'Nitric acid',
      'button7': 'Sodium carbonate',
      'button8': 'Calcium hydroxide',
    };
    Map<String, List<String>> correctAnswers = {
      'Acids': ['Lactic acid', 'Acetic acid', 'Hydrochloric acid', 'Nitric acid'],
      'Bases': ['Sodium hydroxide', 'Barium hydroxide', 'Sodium carbonate', 'Calcium hydroxide'],
    };
    int score = 0;
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
        body: Stack(
          children: [
            Container(
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
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Column(children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
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
                    padding: const EdgeInsets.only(bottom: 10),
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
                  const Text(
                    "Lorem ipsum dolor sit amet consectetur. Ut cras velit sagittis massa donc amet.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16, fontFamily: "UrduType", height: 1.3),
                  ),
                  const Spacer(),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black87.withOpacity(0.1),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                            'آپ کا اسکور: $score پوائنٹس',
                            style: TextStyle(
                                fontFamily: "UrduType", color: Color(0xff8E79FB)),
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
                                child: Text(
                                  'جاری رہے',
                                  style: TextStyle(
                                    fontFamily: 'UrduType',
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),)
                        ]),
                  )
                ]),
              ),
            ),
            Positioned(
              top: 130,
              left: 20,
              child: Draggable<String>(
                data: 'button1',
                feedback: CustomGradientButton(
                  onTap: () {},
                  label: 'Lactic acid',
                ),
                childWhenDragging:
                    Container(), // display an empty container when dragging
                onDragStarted: () {
                  setState(() {
                    isDragged[0] = true;
                  });
                },
                onDragEnd: (details) {
                  setState(() {
                    isDragged[0] = false;
                  });
                },
                child: isInTarget[0]
                    ? Container() // this makes the original place empty when dragging for button 0
                    : CustomGradientButton(
                        onTap: () {},
                        label: 'Lactic acid',
                      ),
              ),
            ),
            Positioned(
              top: 130,
              right: 20,
              child: Draggable<String>(
                data: 'button2',

                feedback: CustomGradientButton(
                  onTap: () {},
                  label: 'Sodium hydroxide',
                ),
                childWhenDragging:
                    Container(), // display an empty container when dragging
                onDragStarted: () {
                  setState(() {
                    isDragged[1] = true;
                  });
                },
                onDragEnd: (details) {
                  setState(() {
                    isDragged[1] = false;
                  });
                },
                child: isInTarget[1]
                    ? Container() // this makes the original place empty when dragging for button 0
                    : CustomGradientButton(
                        onTap: () {},
                        label: 'Sodium hydroxide',
                      ),
              ),
            ),
            Positioned(
              top: 180,
              left: 20,
              child: Draggable<String>(
                data: 'button3',

                feedback: CustomGradientButton(
                  onTap: () {},
                  label: 'Acetic acid',
                ),
                childWhenDragging:
                    Container(), // display an empty container when dragging
                onDragStarted: () {
                  setState(() {
                    isDragged[2] = true;
                  });
                },
                onDragEnd: (details) {
                  setState(() {
                    isDragged[2] = false;
                  });
                },
                child: isInTarget[2]
                    ? Container() // this makes the original place empty when dragging for button 0
                    : CustomGradientButton(
                        onTap: () {},
                        label: 'Acetic acid',
                      ),
              ),
            ),
            Positioned(
              top: 180,
              right: 20,
              child: Draggable<String>(
                data: 'button4',

                feedback: CustomGradientButton(
                  onTap: () {},
                  label: 'Hydrochloric acid',
                ),
                childWhenDragging:
                    Container(), // display an empty container when dragging
                onDragStarted: () {
                  setState(() {
                    isDragged[3] = true;
                  });
                },
                onDragEnd: (details) {
                  setState(() {
                    isDragged[3] = false;
                  });
                },
                child: isInTarget[3]
                    ? Container() // this makes the original place empty when dragging for button 0
                    : CustomGradientButton(
                        onTap: () {},
                        label: 'Hydrochloric acid',
                      ),
              ),
            ),
            Positioned(
              top: 230,
              left: 20,
              child: Draggable<String>(
                data: 'button5',

                feedback: CustomGradientButton(
                  onTap: () {},
                  label: 'Barium hydroxide',
                ),
                childWhenDragging:
                    Container(), // display an empty container when dragging
                onDragStarted: () {
                  setState(() {
                    isDragged[4] = true;
                  });
                },
                onDragEnd: (details) {
                  setState(() {
                    isDragged[4] = false;
                  });
                },
                child: isInTarget[4]
                    ? Container() // this makes the original place empty when dragging for button 0
                    : CustomGradientButton(
                        onTap: () {},
                        label: 'Barium hydroxide',
                      ),
              ),
            ),
            Positioned(
              top: 230,
              right: 20,
              child: Draggable<String>(
                data: 'button6',

                feedback: CustomGradientButton(
                  onTap: () {},
                  label: 'Nitric acid',
                ),
                childWhenDragging:
                    Container(), // display an empty container when dragging
                onDragStarted: () {
                  setState(() {
                    isDragged[5] = true;
                  });
                },
                onDragEnd: (details) {
                  setState(() {
                    isDragged[5] = false;
                  });
                },
                child: isInTarget[5]
                    ? Container() // this makes the original place empty when dragging for button 0
                    : CustomGradientButton(
                        onTap: () {},
                        label: 'Nitric acid',
                      ),
              ),
            ),
            Positioned(
              top: 280,
              left: 20,
              child: Draggable<String>(
                data: 'button7',

                feedback: CustomGradientButton(
                  onTap: () {},
                  label: 'Sodium carbonate',
                ),
                childWhenDragging:
                    Container(), // display an empty container when dragging
                onDragStarted: () {
                  setState(() {
                    isDragged[6] = true;
                  });
                },
                onDragEnd: (details) {
                  setState(() {
                    isDragged[6] = false;
                  });
                },
                child: isInTarget[6]
                    ? Container() // this makes the original place empty when dragging for button 0
                    : CustomGradientButton(
                        onTap: () {},
                        label: 'Sodium carbonate',
                      ),
              ),
            ),
            Positioned(
              top: 280,
              right: 20,
              child: Draggable<String>(
                data: 'button8',

                feedback: CustomGradientButton(
                  onTap: () {},
                  label: 'Calcium hydroxide',
                ),
                childWhenDragging:
                    Container(), // display an empty container when dragging
                onDragStarted: () {
                  setState(() {
                    isDragged[7] = true;
                  });
                },
                onDragEnd: (details) {
                  setState(() {
                    isDragged[7] = false;
                  });
                },
                child: isInTarget[7]
                    ? Container() // this makes the original place empty when dragging for button 0
                    : CustomGradientButton(
                        onTap: () {},
                        label: 'Calcium hydroxide',
                      ),
              ),
            ),
            Positioned(
              top: 330,
              left: 10,
              right: 10,
              child: DragTarget<String>(
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text("Acids",
                              style: TextStyle(fontFamily: "UrduType")),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 10, // space between the buttons
                            runSpacing: 10, // space between the lines
                            children: box1Answers.map((answer) {
                              if (answer != null) {
                                return CustomGradientButton(
                                  onTap: () {},
                                  label: answer,
                                );
                              }
                              return const SizedBox.shrink();
                            }).toList(),

                          ),

                        ],
                      ),
                    ),
                  );
                },
                onWillAccept: (data) =>
                    data != null && box1Answers.indexOf(data) == -1,
                onAccept: (data) {
                  setState(() {
                    String label = buttonLabels[data] ?? '';
                    if (correctAnswers['Acids']!.contains(label)) {
                      score += 1;
                    }
                    box1Answers.add(label);
                    int index = box2Answers.indexOf(data);
                    if (index != -1) {
                      box2Answers.removeAt(index);
                    }
                    int buttonIndex = int.parse(data.substring(6)) - 1;
                    isInTarget[buttonIndex] = true;
                  });
                },

              ),
            ),
            Positioned(
              top: 500,
              left: 10,
              right: 10,
              child: DragTarget<String>(
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text("Bases",
                              style: TextStyle(fontFamily: "UrduType")),
                         Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 10, // space between the buttons
                            runSpacing: 10, // space between the lines
                           children: box2Answers.map((answer) {
                             if (answer != null) {
                               return CustomGradientButton(
                                 onTap: () {},
                                 label: answer,
                               );
                             }
                             return const SizedBox.shrink();
                           }).toList(),


                         ),

                        ],
                      ),
                    ),
                  );
                },
                onWillAccept: (data) => data != null,
                onAccept: (data) {
                  setState(() {
                    String label = buttonLabels[data] ?? '';
                    if (correctAnswers['Bases']!.contains(label)) {
                      score += 1;
                    }
                    box2Answers.add(label);
                    int index = box1Answers.indexOf(data);
                    if (index != -1) {
                      box1Answers.removeAt(index);
                    }
                    int buttonIndex = int.parse(data.substring(6)) - 1;
                    isInTarget[buttonIndex] = true;
                  });
                },

              ),
            )
          ],
        ),
      );
    }
  }

  class CustomGradientButton extends StatelessWidget {
    final VoidCallback onTap;
    final String label;

    CustomGradientButton({required this.onTap, required this.label});

    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 160,
          height: 37,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xff18A3C8),
                Color(0xff89E4FE),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'UrduType',
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }
  }
