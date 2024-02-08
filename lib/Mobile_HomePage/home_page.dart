import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhw/Mobile_Lesson%20&%20Flashcards/lesson_page_tabbar.dart';
import 'package:lhw/custom_widgets/Line_chart.dart';
import 'package:lhw/loading_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../Login_SignUp/Login.dart';
import '../models/course_model.dart';
import '../course_tabbar/course_provider.dart';
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
    // Accessing the CoursesProvider
    final provider = Provider.of<CoursesProvider>(context);
    final lastVisitedCourse = provider.lastVisitedCourse;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if (provider.isLoading) {
      return const Scaffold(
        body: Center(
          child: LoadingScreen(), // Show a loading indicator
        ),
      );
    }
    return Scaffold(
        backgroundColor: const Color(0xFFF1F1F1),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 72.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  width: screenWidth * 0.7,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    showFirstMessage
                        ? 'Hello! Need any help?'
                        : showSecondMessage
                            ? "Still here? Let me know if you need assistance!"
                            : "",
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 16),
                  )),
              CircleAvatar(
                backgroundColor: const Color(0xffF6B3D0),
                radius: 30,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: SvgPicture.asset(
                      "assets/images/samina_instructor.svg",
                      fit: BoxFit.fill,
                    )),
              ),
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.09),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            flexibleSpace:
                _isSearching ? _buildSearchAppBar() : _buildDefaultAppBar(),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              // Adjust the height of the bottom border
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: const Color(
                    0xFFDCDBDB), // Set the color of the bottom border
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
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
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: AnimationLimiter(
                child: Column(
                  children: List.generate(
                    1,
                    (int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 800),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 24, bottom: 16, right: 8),
                                  child: Text(
                                    'میرے کورسز',
                                    style: TextStyle(
                                        fontFamily: 'UrduType',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: screenHeight * 0.12,
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
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15, top: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    'مکمل کورس',
                                                    style: TextStyle(
                                                        fontFamily: 'UrduType',
                                                        color:
                                                            Color(0xff464646),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Icon(
                                                      Icons
                                                          .check_circle_outline,
                                                      size: 24,
                                                      color: Color(0xff7A7D84)),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: screenWidth / 6,
                                                    top: 16),
                                                child: const Text(
                                                  "3",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: ""),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: screenHeight * 0.12,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xffeaa3d8),
                                              Color(0xffED8DCE)
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15, top: 8),
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
                                                        fontFamily: 'UrduType',
                                                        color:
                                                            Color(0xff464646),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: SvgPicture.asset(
                                                      'assets/images/course.svg',
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: screenWidth / 6,
                                                    top: 16),
                                                child: const Text(
                                                  "12",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: ""),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 8),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 8,
                                              bottom: 36),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                      () =>
                                                          const LessonPageTabBar(),
                                                      transition:
                                                          Transition.fade,
                                                      duration: const Duration(
                                                          milliseconds: 300));
                                                },
                                                child: const Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Icon(
                                                        Icons.arrow_back_ios,
                                                        color: Color(
                                                          0xffFE8BD1,
                                                        ),
                                                        size: 14,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          5, // space between Text and Icon
                                                    ),
                                                    Text(
                                                      "کورس پر جائیں",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'UrduType',
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xffFE8BD1),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Text(
                                                "جاری کورس",
                                                style: TextStyle(
                                                    fontFamily: 'UrduType',
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // Aligns children to the start of the Row.
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                // Aligns children to the start of the Column.
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 10,
                                                      bottom: 16,
                                                    ),
                                                    child: Text(
                                                      lastVisitedCourse!.title,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "UrduType",
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        SvgPicture.asset(
                                                            "assets/images/person_card.svg"),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          '${lastVisitedCourse.moduleCount}  ماڈیول',
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  "UrduType",
                                                              fontSize: 12),
                                                          textDirection:
                                                              TextDirection.rtl,
                                                        ),

                                                        // dot container
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Container(
                                                          width: 4,
                                                          height: 4,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.black,
                                                          ),
                                                        ),

                                                        const SizedBox(
                                                          width: 8,
                                                        ),

                                                        SvgPicture.asset(
                                                            "assets/images/bookOpen.svg"),

                                                        const SizedBox(
                                                          width: 5,
                                                        ),

                                                        const Text(
                                                          '12 کوئز',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "UrduType",
                                                              fontSize: 12),
                                                          textDirection:
                                                              TextDirection.rtl,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 16,
                                                            left: 16),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${(value * 100).toStringAsFixed(1)}%",
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                "UrduType",
                                                          ),
                                                        ),
                                                        const Text(
                                                          "پیش رفت",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "UrduType",
                                                              color: Color(
                                                                  0xff7A7D84)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0),
                                                    child:
                                                        LinearPercentIndicator(
                                                      isRTL: true,
                                                      barRadius:
                                                          const Radius.circular(
                                                              10),
                                                      lineHeight: 6.0,
                                                      percent: value,
                                                      backgroundColor:
                                                          const Color(
                                                              0xffEBEBF0),
                                                      progressColor:
                                                          const Color(
                                                              0xff9AC9C2),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: Container(
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade200),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Image.asset(
                                                  lastVisitedCourse!.imagePath,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5, top: 20),
                                            child: Container(
                                              width: double.infinity,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xffE5E5E5),
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
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
                                                        begin:
                                                            Alignment.topLeft,
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
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'UrduType',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
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
                                                                        12,
                                                                    color: Colors
                                                                        .grey, // Set the color to gray
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      "25  جون  2023",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'UrduType',

                                                                    fontSize:
                                                                        12,
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
                                                    GestureDetector(
                                                      child: const Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 14,
                                                      ),
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
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5, top: 15),
                                            child: Container(
                                              width: double.infinity,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xffE5E5E5),
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
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
                                                        begin:
                                                            Alignment.topLeft,
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
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
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
                                                        Icons.arrow_forward_ios,
                                                        size: 14,
                                                      ),
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
                                const SizedBox(
                                  height: 20,
                                ),
                                Material(
                                  elevation: 1,
                                  // Set your desired elevation value here
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
                                            textDirection: TextDirection.rtl,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  const Text(
                                                    "مہارت کا درجہ",
                                                    style: TextStyle(
                                                        fontFamily: 'UrduType',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  DropdownButtonHideUnderline(
                                                    child:
                                                        DropdownButton2<String>(
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
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
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
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ))
                                                          .toList(),
                                                      value: selectedValue,
                                                      onChanged:
                                                          (String? value) {
                                                        setState(() {
                                                          selectedValue = value;
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
                                                                right: 14),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
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
                                                                  .circular(14),
                                                        ),
                                                        offset: const Offset(
                                                            -20, 0),
                                                        scrollbarTheme:
                                                            ScrollbarThemeData(
                                                          radius: const Radius
                                                              .circular(20),
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
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 14,
                                                                right: 14),
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
                                                      fontFamily: "UrduType",
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
                                                        fontFamily: "UrduType",
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                  elevation: 1,
                                  // Set your desired elevation value here
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
                                            textDirection: TextDirection.rtl,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  const Text(
                                                    "سرگرمی",
                                                    style: TextStyle(
                                                        fontFamily: 'UrduType',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  DropdownButtonHideUnderline(
                                                    child:
                                                        DropdownButton2<String>(
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
                                                              ))
                                                          .toList(),
                                                      value: selectedValue,
                                                      onChanged:
                                                          (String? value) {
                                                        setState(() {
                                                          selectedValue = value;
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
                                                                right: 14),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
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
                                                                  .circular(14),
                                                        ),
                                                        offset: const Offset(
                                                            -20, 0),
                                                        scrollbarTheme:
                                                            ScrollbarThemeData(
                                                          radius: const Radius
                                                              .circular(20),
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
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 14,
                                                                right: 14),
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
            )
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
