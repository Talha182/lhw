import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhw/Mobile_Lesson%20&%20Flashcards/lesson_page_tabbar.dart';
import 'package:lhw/custom_widgets/Line_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../Login_SignUp/Login.dart';
import '../custom_widgets/circular_progress_bar_with circle.dart';
import '../custom_widgets/gradient_circle.dart';
import '../notification/notifications_screen.dart';
import '../repositories/authentication_repository/authentication_repository.dart';
import '../utils/is_first_time_check.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String dropdownvalue = 'اس ہفتے';
bool _isSearching = false;
String _searchQuery = '';
double value = 0.5; // 50%

final List<String> _sampleData = [
  'Apple',
  'Banana',
  'Cherry',
  'Date',
  'Elderberry',
  'Fig',
  'Grape'
]; // Sample data for demonstration
List<String> _filteredData = [];

// List of items in our dropdown menu
var items = [
  'اس ہفتے',
  'Item 2',
];
String? selectedValue;

class _HomePageState extends State<HomePage> {
  bool showFirstMessage = false;
  bool showSecondMessage = false;



  @override
  void initState() {
    super.initState();

    // Show first message after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showFirstMessage = true;
        });

        // Hide first message after 5 seconds
        Future.delayed(const Duration(seconds: 7), () {
          if (mounted) {
            setState(() {
              showFirstMessage = false;
            });
          }
        });
      }
    });

    // Show second message after a minute
    Future.delayed(const Duration(minutes: 1), () {
      if (mounted) {
        setState(() {
          showSecondMessage = true;
        });

        // Hide second message after 5 seconds
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) {
            setState(() {
              showSecondMessage = false;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    FirstTimeCheck.checkFirstTimeAndShowDialog(
      'isFirstVisitHomePage',
      'Welcome to the Home Page! Discover our features and enjoy your journey.',
      'assets/images/home_page_image.png', // Make sure you have this image in your assets
    );

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            elevation: 1.0,
            backgroundColor: Colors.white,
            flexibleSpace:
                _isSearching ? _buildSearchAppBar() : _buildDefaultAppBar(),
          ),
        ),
        body: Stack(
          children: [
            Column(children: [
              if (_isSearching && _filteredData.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 0.0, left: 15, right: 15),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey[300]!, blurRadius: 5)
                    ],
                  ),
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height *
                        0.4, // Adjust this value as per requirement
                  ),
                  child: ListView.builder(
                    itemCount: _filteredData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredData[index]),
                      );
                    },
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: AnimationLimiter(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          1,
                          (int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 300),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      const Text(
                                        'میرے کورسز',
                                        style: TextStyle(
                                          fontFamily: 'UrduType',
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 170,
                                            height: 90,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                              padding: EdgeInsets.only(
                                                  right: 15, top: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Text(
                                                        'مکمل کورس',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'UrduType',
                                                            color: Color(
                                                                0xff7A7D84),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Icon(
                                                          Icons
                                                              .check_circle_outline,
                                                          size: 19,
                                                          color: Color(
                                                              0xff7A7D84)),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 20),
                                                    child: Text(
                                                      "3",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontFamily:
                                                              "UrduType"),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                                  right: 15, top: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      const Text(
                                                        'باقی کورس',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'UrduType',
                                                            color: Color(
                                                                0xff7A7D84),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      SvgPicture.asset(
                                                        'assets/images/course.svg',
                                                      ),
                                                    ],
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 20),
                                                    child: Text(
                                                      "12",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontFamily:
                                                              "UrduType"),
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
                                          width: screenWidth - 25,
                                          height: 450,
                                          decoration: const BoxDecoration(),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 5, right: 5),
                                            child: Column(
                                              children: <Widget>[
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      const Text(
                                                        "جاری کورس",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'UrduType',
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              () =>
                                                                  const LessonPageTabBar(),
                                                              transition:
                                                                  Transition
                                                                      .fade,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300));
                                                        },
                                                        child: const Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              "کورس پر جائیں۔",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'UrduType',
                                                                  fontSize: 15,
                                                                  color: Color(
                                                                      0xffFE8BD1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  5, // space between Text and Icon
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
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
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start, // Aligns children to the start of the Row.
                                                    children: [
                                                      Container(
                                                        width: 150,
                                                        height: 130,
                                                        decoration: BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Image.asset(
                                                          "assets/images/team.png",
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start, // Aligns children to the start of the Column.
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            child: Text(
                                                              'خاندانی منصوبہ بندی',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "UrduType",
                                                                  fontSize: 18),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 10),
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                  '12 کوئز',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "UrduType",
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                SvgPicture.asset(
                                                                    "assets/images/person_card.svg"),
                                                                // dot container
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Container(
                                                                  width: 4,
                                                                  height: 4,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),

                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                const Text(
                                                                  '12 کوئز',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "UrduType",
                                                                      fontSize:
                                                                          18),
                                                                ),

                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                SvgPicture.asset(
                                                                    "assets/images/bookOpen.svg"),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 12,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  "پیش رفت",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "UrduType",
                                                                      color: Color(
                                                                          0xff7A7D84)),
                                                                ),
                                                                const SizedBox(
                                                                  width: 100,
                                                                ),
                                                                Text(
                                                                  "${(value * 100).toStringAsFixed(1)}%",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        "UrduType",
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          LinearPercentIndicator(
                                                            isRTL: true,
                                                            barRadius:
                                                                const Radius
                                                                    .circular(
                                                                    10),
                                                            width: 200.0,
                                                            lineHeight: 6.0,
                                                            percent: value,
                                                            backgroundColor:
                                                                const Color(
                                                                    0xffEBEBF0),
                                                            progressColor:
                                                                const Color(
                                                                    0xff9AC9C2),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5,
                                                            right: 5,
                                                            top: 20),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 80,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: const Color(
                                                              0xffE5E5E5),
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 20),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const GradientCircle(
                                                              width: 45,
                                                              height: 45,
                                                              gradient:
                                                                  LinearGradient(
                                                                colors: [
                                                                  Color(
                                                                      0xffF4D6A9),
                                                                  Color(
                                                                      0xffEAAF58)
                                                                ],
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                              ),
                                                              imagePath:
                                                                  'assets/images/person_card.svg',
                                                              imageWidth: 18,
                                                              imageHeight:
                                                                  18, // Replace with your image path
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Text(
                                                                      "کوئز 1 زیر التوا ہے۔ ",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontFamily:
                                                                              'UrduType',
                                                                          fontWeight:
                                                                              FontWeight.w500)),
                                                                  RichText(
                                                                    text:
                                                                        const TextSpan(
                                                                      children: <TextSpan>[
                                                                        TextSpan(
                                                                          text:
                                                                              "آخری تاریخ: ",
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'UrduType',

                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.grey, // Set the color to gray
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              "25 جون 2023",
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'UrduType',

                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.black, // Set the color to black
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              child: const Icon(
                                                                  Icons
                                                                      .arrow_forward_ios),
                                                              onTap: () async {
                                                                await AuthenticationRepository
                                                                    .instance
                                                                    .Logout();
                                                                // Redirect to the login page after logging out.
                                                                Get.offAll(() =>
                                                                    const LoginScreen());
                                                              },
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5,
                                                            right: 5,
                                                            top: 15),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 80,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: const Color(
                                                              0xffE5E5E5),
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 20),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const GradientCircle(
                                                              width: 45,
                                                              height: 45,
                                                              gradient:
                                                                  LinearGradient(
                                                                colors: [
                                                                  Color(
                                                                      0xffF4B9E1),
                                                                  Color(
                                                                      0xffED8DCE)
                                                                ],
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                              ),
                                                              imagePath:
                                                                  'assets/images/person_card.svg',
                                                              imageWidth: 18,
                                                              imageHeight:
                                                                  18, // Replace with your image path
                                                            ),

                                                            const SizedBox(
                                                              width: 20,
                                                            ),

                                                            const Expanded(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "ماڈیولز مکمل ہو گئے۔ ",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'UrduType',
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w500)),
                                                                  Text(
                                                                    "12",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "UrduType"),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // Icon button on the right
                                                            GestureDetector(
                                                              child: const Icon(
                                                                  Icons
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
                                      ),
                                      const SizedBox(
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
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        const Text(
                                                          "مہارت کا درجہ",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'UrduType',
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
                                                                  String>(
                                                            isExpanded: true,
                                                            hint: const Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    'اس ہفتے',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'UrduType',
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            items: items
                                                                .map((String
                                                                        item) =>
                                                                    DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          item,
                                                                      child:
                                                                          Text(
                                                                        item,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontFamily:
                                                                              'UrduType',
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ))
                                                                .toList(),
                                                            value:
                                                                selectedValue,
                                                            onChanged: (String?
                                                                value) {
                                                              setState(() {
                                                                selectedValue =
                                                                    value;
                                                              });
                                                            },
                                                            buttonStyleData:
                                                                ButtonStyleData(
                                                              height: 40,
                                                              width: 100,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black),
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            14),
                                                              ),
                                                              offset:
                                                                  const Offset(
                                                                      -20, 0),
                                                              scrollbarTheme:
                                                                  ScrollbarThemeData(
                                                                radius:
                                                                    const Radius
                                                                        .circular(
                                                                        20),
                                                                thickness:
                                                                    MaterialStateProperty
                                                                        .all<double>(
                                                                            6),
                                                                thumbVisibility:
                                                                    MaterialStateProperty
                                                                        .all<bool>(
                                                                            true),
                                                              ),
                                                            ),
                                                            menuItemStyleData:
                                                                const MenuItemStyleData(
                                                              height: 40,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                ),
                                                const SizedBox(
                                                  height: 50,
                                                ),
                                                const Center(
                                                    child:
                                                        CircularProgressWithInnerCircle(
                                                  percentage: 0.7,
                                                )),
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
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color(0xffD6C2FF),
                                                            Color(0xff9B6BFF)
                                                          ],
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
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
                                                            fontFamily:
                                                                "UrduType",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18),
                                                      ),
                                                      SizedBox(
                                                        width: 100,
                                                      ),
                                                      GradientCircle(
                                                        width: 45,
                                                        height: 45,
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color(0xffF4D6A9),
                                                            Color(0xffEAAF58)
                                                          ],
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
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
                                                              fontFamily:
                                                                  "UrduType",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                                          fontFamily:
                                                              'UrduType',
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff747474),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      width: 150,
                                                    ),
                                                    Text(
                                                      'سکل بیج کا انعام',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'UrduType',
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff747474),
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        const Text(
                                                          "سرگرمی",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'UrduType',
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
                                                                  String>(
                                                            isExpanded: true,
                                                            hint: const Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    'اس ہفتے',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'UrduType',
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            items: items
                                                                .map((String
                                                                        item) =>
                                                                    DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          item,
                                                                      child:
                                                                          Text(
                                                                        item,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontFamily:
                                                                              'UrduType',
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ))
                                                                .toList(),
                                                            value:
                                                                selectedValue,
                                                            onChanged: (String?
                                                                value) {
                                                              setState(() {
                                                                selectedValue =
                                                                    value;
                                                              });
                                                            },
                                                            buttonStyleData:
                                                                ButtonStyleData(
                                                              height: 40,
                                                              width: 90,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black),
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            14),
                                                              ),
                                                              offset:
                                                                  const Offset(
                                                                      -20, 0),
                                                              scrollbarTheme:
                                                                  ScrollbarThemeData(
                                                                radius:
                                                                    const Radius
                                                                        .circular(
                                                                        20),
                                                                thickness:
                                                                    MaterialStateProperty
                                                                        .all<double>(
                                                                            6),
                                                                thumbVisibility:
                                                                    MaterialStateProperty
                                                                        .all<bool>(
                                                                            true),
                                                              ),
                                                            ),
                                                            menuItemStyleData:
                                                                const MenuItemStyleData(
                                                              height: 40,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                const LineChartSample2()
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      )
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
              )
            ]),
            // Circle at bottom left
            Positioned(
                bottom: 80, // Adjust as needed
                right: 20, // Adjust as needed
                child: CircleAvatar(
                  backgroundColor: const Color(0xffF6B3D0),
                  radius: 30,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: SvgPicture.asset(
                        "assets/images/samina_instructor.svg",
                        fit: BoxFit.fill,
                      )),
                )),
            if (showFirstMessage)
              Positioned(
                bottom: 115, // adjust as needed
                right: 85, // adjust as needed
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Text(
                    'Hello! Need any help?',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

            // If `showSecondMessage` is true, show the second message
            if (showSecondMessage)
              Positioned(
                bottom: 150, // adjust as needed
                right: 70, // adjust as needed
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Text(
                    'Still here? Let me know if you need assistance!',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ));
  }

  Widget _buildDefaultAppBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 16.0, bottom: 20.0),
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
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  GestureDetector(
                    child: SvgPicture.asset(
                      'assets/images/magnifier.svg',
                      color: Colors.black,
                    ),
                    onTap: () {
                      setState(() {
                        _isSearching = true;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    child: SvgPicture.asset(
                      'assets/images/bell.svg',
                      color: Colors.black,
                    ),
                    onTap: () {
                      Get.to(() => const NotificationScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAppBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Icon(Icons.close, color: Color(0xff685F78)),
            ),
            onTap: () {
              setState(() {
                _isSearching = false;
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: TextField(
                onChanged: (value) {
                  _filterData(value);
                  setState(() {
                    _searchQuery = value;
                  });
                },
                autofocus: true,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search here...",
                    hintStyle: TextStyle(
                        fontFamily: "UrduType",
                        color: Color(0xff7A7D84),
                        fontSize: 18)),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(
                "assets/images/magnifier.svg",
                color: const Color(0xff7A7D84),
              ))
        ],
      ),
    );
  }

  void _filterData(String query) {
    setState(() {
      _filteredData = _sampleData
          .where(
              (element) => element.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
