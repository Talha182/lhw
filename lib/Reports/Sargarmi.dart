import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sargarmi extends StatefulWidget {
  const Sargarmi({super.key});

  @override
  State<Sargarmi> createState() => _SargarmiState();
}

class _SargarmiState extends State<Sargarmi> {
  final DateTime _currentDate = DateTime.now();
  Set<DateTime> _selectedDates = {};

  @override
  void initState() {
    super.initState();
    _loadAttendance();
  }

  _loadAttendance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedDates = prefs.getStringList('attendanceDates') ?? [];
    setState(() {
      _selectedDates = storedDates.map((date) => DateTime.parse(date)).toSet();
      // Add today's date to the set and save
      _markAttendance(_currentDate);
    });
  }

  _markAttendance(DateTime date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedDates.add(date);
    prefs.setStringList('attendanceDates', _selectedDates.map((date) => date.toIso8601String()).toList());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: ListView(
              children: [
                const Text(
                  "سرگرمی کی تفصیلات",
                  style: TextStyle(fontFamily: "UrduType", fontSize: 18),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "سرگرمی کی تفصیلات",
                  style: TextStyle(fontFamily: "UrduType", fontSize: 18),
                ),
                const Text(
                  "دیکھیں کہ آپ نے لگاتار کتنے دن سیکھے ہیں۔",
                  style: TextStyle(
                      fontFamily: "UrduType",
                      fontSize: 16,
                      color: Color(0xff8B9DA0)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 470,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300)),
                          child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Stack(
                                children: <Widget>[
                                  IgnorePointer(
                                    child: CalendarCarousel(
                                      weekDayFormat: WeekdayFormat.short,
                                      headerTextStyle: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: "UrduType",
                                          fontSize: 20),
                                      iconColor: const Color(0xffE3E3E3),
                                      showOnlyCurrentMonthDate: true,

                                      weekdayTextStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      weekendTextStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      headerMargin: const EdgeInsets.only(bottom: 20),
                                      thisMonthDayBorderColor: Colors.grey,
                                      weekFormat: false,
                                      selectedDayTextStyle:
                                          const TextStyle(color: Colors.white),
                                      todayButtonColor: Colors.transparent,
                                      todayTextStyle:
                                          const TextStyle(color: Colors.white),
                                customDayBuilder: (
                                      bool isSelectable,
                                      int index,
                                      bool isSelectedDay,
                                      bool isToday,
                                      bool isPrevMonthDay,
                                      TextStyle textStyle,
                                      bool isNextMonthDay,
                                      bool isThisMonthDay,
                                      DateTime day,
                                      ) {
                                    if (!isThisMonthDay) return null;

                                    Color containerColor = const Color(0xffEDEFF1);
                                    Widget? child;

                                    if (_selectedDates.contains(day)) {
                                      containerColor = const Color(0xffFFCE51);
                                      child = Center(
                                        child: Image.asset(
                                          "assets/images/calender1.png",
                                          width: 18,
                                          height: 18,
                                          fit: BoxFit.contain,
                                        ),
                                      );
                                    } else if (isToday) {  // If the day is today, we'll display the icon
                                      containerColor = const Color(0xffFFCE51);  // or any other color you want for today
                                      child = Center(
                                        child: Image.asset(
                                          "assets/images/calender1.png",
                                          width: 18,
                                          height: 18,
                                          fit: BoxFit.contain,
                                        ),
                                      );
                                    }

                                    return Container(
                                      margin: const EdgeInsets.all(4.0),
                                      decoration: BoxDecoration(
                                        color: containerColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: child,
                                    );
                                },
                                    ),
                                  ),
                                Positioned(
                                    top: 40.0, // adjust as per your requirement
                                    left: 16.0,
                                    right: 16.0,
                                    child: Divider(
                                      color: Colors.black.withOpacity(
                                          0.1), // or any other color you want
                                      thickness: 1.0,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 20, top: 15),
                            child: Image.asset("assets/images/quotations.png")),
                        Text(
                          "${_selectedDates.length} دن کا سلسلہ جاری ہے! رفتار کو برقرار رکھیں۔",
                          style: const TextStyle(
                              fontFamily: "UrduType",
                              fontSize: 20,
                              color: Color(0xff81C588)),
                        )
                      ],
                    ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 450,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          " بات چیت گروپ میں شرکت",
                          style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                        ),
                        const Text(
                          "دیکھیں کہ آپ نے ہر یونٹ کے ٹیسٹ میں کس طرح حصہ لیا ",
                          style: TextStyle(
                              fontFamily: "UrduType",
                              fontSize: 15,
                              color: Color(0xff8B9DA0)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 103,
                              height: 135,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xffE5E5E5))),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(colors: [
                                          Color(0xffF4D6A9),
                                          Color(0xffEAAF58)
                                        ]),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                            "assets/images/message.png"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      "تبصرے",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 18),
                                    ),
                                    const Text(
                                      "100",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 103,
                              height: 135,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xffE5E5E5))),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(colors: [
                                          Color(0xffF4B9E1),
                                          Color(0xffED8DCE)
                                        ]),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                            "assets/images/add.png"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      "خطوط",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 18),
                                    ),
                                    const Text(
                                      "12",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 103,
                              height: 135,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xffE5E5E5))),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(colors: [
                                          Color(0xffE6ECF9),
                                          Color(0xff839EE2)
                                        ]),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                            "assets/images/like.png",color: Colors.black,),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      "پسند ",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 18),
                                    ),
                                    const Text(
                                      "12",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey.shade200,
                        ), const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "نمایاں پوسٹس/تبصرے۔",
                          style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/grad-message.png",
                              width: 30,
                              height: 30,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "پوسٹ: 'باب 9: غذائیت' بحث گروپ۔",
                                  style: TextStyle(
                                      fontFamily: "UrduType", fontSize: 18),
                                ),
                                Text(
                                  "Sep 6",
                                  style: TextStyle(
                                      fontFamily: "UrduType",
                                      fontSize: 15,
                                      color: Color(0xff8B9DA0)),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/profile_pic.png",
                              width: 30,
                              height: 30,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "پوسٹ: 'باب 9: غذائیت' بحث گروپ۔",
                                  style: TextStyle(
                                      fontFamily: "UrduType", fontSize: 18),
                                ),
                                Text(
                                  "Sep 6",
                                  style: TextStyle(
                                      fontFamily: "UrduType",
                                      fontSize: 15,
                                      color: Color(0xff8B9DA0)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
