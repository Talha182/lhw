import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Presentation extends StatefulWidget {
  const Presentation({super.key});

  @override
  State<Presentation> createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  bool isSelected = false;
  bool isAnswered = false;
  int _current = 0;
  int _totalSteps = 100;
  int questionIndex = 0;
  String selectedAnswer = '';
  int? selectedOptionIndex;

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
              Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(
                  'assets/images/cloud.svg',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
              Image.asset("assets/images/presentation.png"),
              Text(
                "عظیم کام! عظیم پیش رفت",
                style: TextStyle(fontFamily: "UrduType", fontSize: 22),
              ),
              Text(
                "آپ نے اس سبق میں کوئز مکمل کیا۔",
                style: TextStyle(
                    fontFamily: "UrduType",
                    fontSize: 16,
                    color: Color(0xff7A7D84)),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffFE8BD1),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "کورسز مکمل",
                          style: TextStyle(fontFamily: "UrduType"),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 5, right: 5, bottom: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "12",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff9AC9C2),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "ماڈیولز مکمل ہو گئے۔",
                          style: TextStyle(fontFamily: "UrduType"),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 5, right: 5, bottom: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "12",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF7DE8D),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "مجموعی سکور",
                          style: TextStyle(fontFamily: "UrduType"),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 5, right: 5, bottom: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "14",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffFFC6A6),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "سیکھنے کے اوقات",
                          style: TextStyle(fontFamily: "UrduType"),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 5, right: 5, bottom: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "120 گھنٹے",
                                  style: TextStyle(
                                      fontFamily: "UrduType", fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              InkWell(
                child: Text("لیڈر بورڈ دیکھیں",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 16,color: Color(0xffFE8BD1))),
                onTap: () {},
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
