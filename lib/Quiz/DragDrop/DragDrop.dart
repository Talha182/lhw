import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

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
  List<bool> isDragged = List.generate(8, (index) => false);  // assuming 8 buttons

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
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
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
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(
                          begin: 0, end: ((_current + 1) / 5 * _totalSteps)),
                      duration: const Duration(milliseconds: 400),
                      builder:
                          (BuildContext context, double value, Widget? child) {
                        return StepProgressIndicator(
                          totalSteps: _totalSteps,
                          currentStep: value.ceil(),
                          size: 8,
                          padding: 0,
                          selectedColor: const Color(0xffFE8BD1),
                          unselectedColor: Colors.white,
                          roundedEdges: const Radius.circular(10),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
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
                style: TextStyle(color: Colors.black87, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Draggable(
                    feedback: CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    child: isDragged[0]
                        ? Container()  // this makes the original place empty when dragging for button 0
                        : CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    childWhenDragging: Container(),  // display an empty container when dragging
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
                  ),

                  Draggable(
                    feedback: CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    child: isDragged[1]
                        ? Container()  // this makes the original place empty when dragging for button 0
                        : CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    childWhenDragging: Container(),  // display an empty container when dragging
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
                  ),

                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Draggable(
                    feedback: CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    child: isDragged[2]
                        ? Container()  // this makes the original place empty when dragging for button 0
                        : CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    childWhenDragging: Container(),  // display an empty container when dragging
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
                  ),

                  Draggable(
                    feedback: CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    child: isDragged[3]
                        ? Container()  // this makes the original place empty when dragging for button 0
                        : CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    childWhenDragging: Container(),  // display an empty container when dragging
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
                  ),

                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Draggable(
                    feedback: CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    child: isDragged[4]
                        ? Container()  // this makes the original place empty when dragging for button 0
                        : CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    childWhenDragging: Container(),  // display an empty container when dragging
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
                  ),

                  Draggable(
                    feedback: CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    child: isDragged[5]
                        ? Container()  // this makes the original place empty when dragging for button 0
                        : CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    childWhenDragging: Container(),  // display an empty container when dragging
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
                  ),

                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Draggable(
                    feedback: CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    child: isDragged[6]
                        ? Container()  // this makes the original place empty when dragging for button 0
                        : CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    childWhenDragging: Container(),  // display an empty container when dragging
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
                  ),

                  Draggable(
                    feedback: CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    child: isDragged[7]
                        ? Container()  // this makes the original place empty when dragging for button 0
                        : CustomGradientButton(
                      onTap: () {},
                      label: 'جواب کا اختیار 1',
                    ),
                    childWhenDragging: Container(),  // display an empty container when dragging
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
                  ),

                ],
              ),

              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                    color: Colors.black87.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Text("باکس ٹائٹل 1",style: TextStyle(fontFamily: "UrduType"),)
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                    color: Colors.black87.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Text("باکس ٹائٹل 1",style: TextStyle(fontFamily: "UrduType"),)
                  ],
                ),
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
                    const Text(
                      'آپ کا اسکور: 10 پوائنٹس',
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
                      child: const Expanded(
                        child: Text(
                          'جاری رہے',
                          style: TextStyle(
                            fontFamily: 'UrduType',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
