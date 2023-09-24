import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lhw/custom_widgets/Line_chart.dart';
import '../custom_widgets/circular_progress_bar_with circle.dart';
import '../custom_widgets/gradient_circle.dart';
import '../custom_widgets/progress_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String dropdownvalue = 'اس ہفتے';

// List of items in our dropdown menu
var items = [
  'اس ہفتے',
  'Item 2',
];
String? selectedValue;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          elevation: 1.0,
          backgroundColor: Colors.white,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "ڈیش بورڈ",
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: SvgPicture.asset(
                          'assets/images/magnifier.svg',
                          color: Colors.black,
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        child: SvgPicture.asset(
                          'assets/images/bell.svg',
                          color: Colors.black,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: AnimationLimiter(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                1,
                    (int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 400),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'میرے کورسز',
                              style: TextStyle(
                                  fontFamily: 'UrduType',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 170,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xffDCEFDE),
                                        Color(0xff81C588)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 15, top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(Icons.check_circle_outline,
                                                size: 19,
                                                color: Color(0xff7A7D84)),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'مکمل کورس',
                                              style: TextStyle(
                                                  fontFamily: 'UrduType',
                                                  color: Color(0xff7A7D84),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: Text(
                                            "3",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 180,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xffF4B9E1),
                                        Color(0xffED8DCE)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            SvgPicture.asset(
                                              'assets/images/course.svg',
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Text(
                                              'باقی کورس',
                                              style: TextStyle(
                                                  fontFamily: 'UrduType',
                                                  color: Color(0xff7A7D84),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: Text(
                                            "12",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Material(
                              elevation: 1,
                              // Set your desired elevation value here
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: screenWidth - 40,
                                height: 450,
                                decoration: const BoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          const Text(
                                            "جاری کورس",
                                            style: TextStyle(
                                                fontFamily: 'UrduType',
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "کورس پر جائیں۔",
                                                  style: TextStyle(
                                                      fontFamily: 'UrduType',
                                                      fontSize: 15,
                                                      color: Color(0xffFE8BD1),
                                                      fontWeight: FontWeight
                                                          .w600),
                                                ),
                                                SizedBox(
                                                  width: 5, // space between Text and Icon
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Color(
                                                    0xffFE8BD1,
                                                  ),
                                                  size: 14,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          // Container with circular border containing an image
                                          Container(
                                            width: 180,
                                            height: 135,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(15),
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/team.png'),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          // Column containing three texts
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              const Text(
                                                'خاندانی منصوبہ بندی',
                                                style: TextStyle(
                                                    fontFamily: 'UrduType',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0.01),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: <Widget>[
                                                  SvgPicture.asset(
                                                      "assets/images/module.svg"),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Text(
                                                    '24 ماڈیولز',
                                                    style: TextStyle(
                                                        fontFamily: 'UrduType',
                                                        fontSize: 14,
                                                        fontWeight: FontWeight
                                                            .w600,
                                                        letterSpacing: 0.01),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    width: 5,
                                                    height: 5,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.black,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 6,
                                                  ),
                                                  SvgPicture.asset(
                                                      "assets/images/person_card.svg"),
                                                  const SizedBox(
                                                    width: 6,
                                                  ),
                                                  const Text("12 کوئز",
                                                      style: TextStyle(
                                                        fontFamily: 'UrduType',
                                                        fontSize: 14,
                                                        fontWeight: FontWeight
                                                            .w600,
                                                      ))
                                                ],
                                              ),
                                              const SizedBox(height: 25),
                                              Row(
                                                children: <Widget>[
                                                  const Text(
                                                    'پیش رفت',
                                                    style: TextStyle(
                                                        fontFamily: 'UrduType',
                                                        color: Color(
                                                            0xff7A7D84),
                                                        fontWeight: FontWeight
                                                            .w500),
                                                  ),
                                                  const SizedBox(
                                                    width: 80,
                                                  ),
                                                  Text(
                                                    '${(0.6 * 100).toInt()}%',
                                                    // The percentage value
                                                    style: const TextStyle(
                                                        fontFamily: 'UrduType',
                                                        fontSize: 14,
                                                        fontWeight: FontWeight
                                                            .w700),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 2),
                                              const ProgressBar(
                                                width: 140.0,
                                                height: 6.0,
                                                value: 0.6, // 60%
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5, top: 30),
                                          child: Container(
                                            width: 340,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(10),
                                              border: Border.all(
                                                color: const Color(0xffE5E5E5),
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  const GradientCircle(
                                                    width: 45,
                                                    height: 45,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xffF4D6A9),
                                                        Color(0xffEAAF58)
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment
                                                          .bottomRight,
                                                    ),
                                                    imagePath: 'assets/images/person_card.svg',
                                                    imageWidth: 18,
                                                    imageHeight: 18, // Replace with your image path
                                                  ),

                                                  const SizedBox(
                                                    width: 20,
                                                  ),

                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        const Text(
                                                            "کوئز 1 زیر التوا ہے۔ ",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontFamily: 'UrduType',
                                                                fontWeight: FontWeight
                                                                    .w500)),
                                                        RichText(
                                                          text: const TextSpan(
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                text: "آخری تاریخ: ",
                                                                style: TextStyle(
                                                                  fontFamily: 'UrduType',

                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey, // Set the color to gray
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: "25 جون 2023",
                                                                style: TextStyle(
                                                                  fontFamily: 'UrduType',

                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black, // Set the color to black
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  // Icon button on the right
                                                  GestureDetector(
                                                    child: const Icon(Icons
                                                        .arrow_forward_ios),
                                                    onTap: () {},
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5, top: 15),
                                          child: Container(
                                            width: 340,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(10),
                                              border: Border.all(
                                                color: const Color(0xffE5E5E5),
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  const GradientCircle(
                                                    width: 45,
                                                    height: 45,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xffF4B9E1),
                                                        Color(0xffED8DCE)
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment
                                                          .bottomRight,
                                                    ),
                                                    imagePath: 'assets/images/person_card.svg',
                                                    imageWidth: 18,
                                                    imageHeight: 18, // Replace with your image path
                                                  ),

                                                  const SizedBox(
                                                    width: 20,
                                                  ),

                                                  const Expanded(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                            "ماڈیولز مکمل ہو گئے۔ ",
                                                            style: TextStyle(
                                                                fontFamily: 'UrduType',
                                                                fontSize: 18,
                                                                fontWeight: FontWeight
                                                                    .w500)),
                                                        Text("12"),
                                                      ],
                                                    ),
                                                  ),
                                                  // Icon button on the right
                                                  GestureDetector(
                                                    child: const Icon(Icons
                                                        .arrow_forward_ios),
                                                    onTap: () {},
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ), const SizedBox(
                              height: 20,
                            ),
                            Material(
                              elevation:
                              1, // Set your desired elevation value here
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: screenWidth - 10,
                                height: 450,
                                decoration: const BoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            const Text(
                                              "مہارت کا درجہ",
                                              style: TextStyle(
                                                  fontFamily: 'UrduType',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton2<String>(
                                                isExpanded: true,
                                                hint: const Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'اس ہفتے',
                                                        style: TextStyle(
                                                          fontFamily:
                                                          'UrduType',
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                items: items
                                                    .map((String item) =>
                                                    DropdownMenuItem<
                                                        String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style:
                                                        const TextStyle(
                                                          fontFamily:
                                                          'UrduType',
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                        ),
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ))
                                                    .toList(),
                                                value: selectedValue,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    selectedValue = value;
                                                  });
                                                },
                                                buttonStyleData:
                                                ButtonStyleData(
                                                  height: 40,
                                                  width: 100,
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 14, right: 14),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        5),
                                                    border: Border.all(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                iconStyleData:
                                                const IconStyleData(
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                  ),
                                                  iconSize: 14,
                                                ),
                                                dropdownStyleData:
                                                DropdownStyleData(
                                                  maxHeight: 100,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        14),
                                                  ),
                                                  offset: const Offset(-20, 0),
                                                  scrollbarTheme:
                                                  ScrollbarThemeData(
                                                    radius:
                                                    const Radius.circular(
                                                        20),
                                                    thickness:
                                                    MaterialStateProperty
                                                        .all<double>(6),
                                                    thumbVisibility:
                                                    MaterialStateProperty
                                                        .all<bool>(true),
                                                  ),
                                                ),
                                                menuItemStyleData:
                                                const MenuItemStyleData(
                                                  height: 40,
                                                  padding: EdgeInsets.only(
                                                      left: 14, right: 14),
                                                ),
                                              ),
                                            ),
                                          ]),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Center(
                                          child:
                                          CircularProgressWithInnerCircle()),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          left: 34,
                                          top: 30,
                                        ),
                                        child: Row(
                                          children: [
                                            GradientCircle(
                                              width: 45,
                                              height: 45,
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xffD6C2FF),
                                                  Color(0xff9B6BFF)
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              imagePath:
                                              'assets/images/dots.svg',
                                              imageWidth: 22,
                                              imageHeight:
                                              22, // Replace with your image path
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '4380',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              width: 100,
                                            ),
                                            GradientCircle(
                                              width: 45,
                                              height: 45,
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xffF4D6A9),
                                                  Color(0xffEAAF58)
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              imagePath:
                                              'assets/images/badge.svg',
                                              imageWidth: 24,
                                              imageHeight:
                                              24, // Replace with your image path
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text('20/30',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18))
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Row(
                                        children: [
                                          SizedBox(
                                            width: 35,
                                          ),
                                          Text(
                                            'سکل پوائنٹس',
                                            style: TextStyle(
                                                fontFamily: 'UrduType',
                                                fontSize: 14,
                                                color: Color(0xff747474),
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 150,
                                          ),
                                          Text(
                                            'سکل بیج کا انعام',
                                            style: TextStyle(
                                                fontFamily: 'UrduType',
                                                fontSize: 14,
                                                color: Color(0xff747474),
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Material(
                              elevation:
                              1, // Set your desired elevation value here
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: screenWidth - 40,
                                height: 380,
                                decoration: const BoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            const Text(
                                              "سرگرمی",
                                              style: TextStyle(
                                                  fontFamily: 'UrduType',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton2<String>(
                                                isExpanded: true,
                                                hint: const Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'اس ہفتے',
                                                        style: TextStyle(
                                                          fontFamily:
                                                          'UrduType',
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                items: items
                                                    .map((String item) =>
                                                    DropdownMenuItem<
                                                        String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style:
                                                        const TextStyle(
                                                          fontFamily:
                                                          'UrduType',
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                        ),
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ))
                                                    .toList(),
                                                value: selectedValue,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    selectedValue = value;
                                                  });
                                                },
                                                buttonStyleData:
                                                ButtonStyleData(
                                                  height: 40,
                                                  width: 100,
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 14, right: 14),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        5),
                                                    border: Border.all(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                iconStyleData:
                                                const IconStyleData(
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                  ),
                                                  iconSize: 14,
                                                ),
                                                dropdownStyleData:
                                                DropdownStyleData(
                                                  maxHeight: 100,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        14),
                                                  ),
                                                  offset: const Offset(-20, 0),
                                                  scrollbarTheme:
                                                  ScrollbarThemeData(
                                                    radius:
                                                    const Radius.circular(
                                                        20),
                                                    thickness:
                                                    MaterialStateProperty
                                                        .all<double>(6),
                                                    thumbVisibility:
                                                    MaterialStateProperty
                                                        .all<bool>(true),
                                                  ),
                                                ),
                                                menuItemStyleData:
                                                const MenuItemStyleData(
                                                  height: 40,
                                                  padding: EdgeInsets.only(
                                                      left: 14, right: 14),
                                                ),
                                              ),
                                            ),
                                          ]),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      const LineChartSample2()
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 50,)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

            ),
          ),
        ),
      ),
    );
  }

}