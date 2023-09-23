import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class Sargarmi extends StatefulWidget {
  const Sargarmi({super.key});

  @override
  State<Sargarmi> createState() => _SargarmiState();
}

class _SargarmiState extends State<Sargarmi> {
  DateTime _currentDate = DateTime.now();
  Set<DateTime> _selectedDates = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
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
              SizedBox(
                height: 10,
              ),
              Container(
                height: 470,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 350,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Stack(
                              children: <Widget>[
                                CalendarCarousel(
                                  weekDayFormat: WeekdayFormat.short,
                                  headerTextStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "UrduType",
                                      fontSize: 20),
                                  iconColor: Color(0xffE3E3E3),
                                  showOnlyCurrentMonthDate: true,
                                  onDayPressed: (date, _) {
                                    setState(() {
                                      // Toggle selection: If the date is already in the set, remove it, else add it
                                      if (_selectedDates.contains(date)) {
                                        _selectedDates.remove(date);
                                      } else {
                                        _selectedDates.add(date);
                                      }
                                    });
                                  },
                                  weekdayTextStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  weekendTextStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  headerMargin: EdgeInsets.only(bottom: 20),
                                  thisMonthDayBorderColor: Colors.grey,
                                  weekFormat: false,
                                  selectedDayTextStyle:
                                  TextStyle(color: Colors.white),
                                  todayButtonColor: Colors.transparent,
                                  todayTextStyle: TextStyle(color: Colors.white),
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
                                    if (!isThisMonthDay) return null; // If you only want the current month's days

                                    Color containerColor = Color(0xffEDEFF1);
                                    Widget? child;  // Made it nullable

                                    if (_selectedDates.contains(day)) {
                                      containerColor = Color(0xffFFCE51);
                                      child = Center(
                                        child: Image.asset("assets/images/calender1.png",width: 18,height: 18,fit: BoxFit.contain,), // Icon for the selected day
                                      );
                                    }

                                    return Container(
                                      margin: EdgeInsets.all(4.0),
                                      decoration: BoxDecoration(
                                        color: containerColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: child,
                                    );
                                  },
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
                      SizedBox(height: 20,),
                      Padding(
                        padding: EdgeInsets.only(right: 20,top: 15),
                          child: Image.asset("assets/images/quotations.png")),
                      Text("10 دن کا سلسلہ حاصل ہوا! رفتار کو جاری رکھیں",style: TextStyle(
                        fontFamily: "UrduType",fontSize: 20,
                        color: Color(0xff81C588)
                      ),)
                    ],

                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 450,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [

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