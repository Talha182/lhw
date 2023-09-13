import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:lhw/Mobile_HomePage/Courses_Completed.dart';
import 'package:lhw/Mobile_HomePage/Courses_Ongoing.dart';
import 'package:lhw/Mobile_HomePage/Courses_All Courses.dart';

import 'Lesson.dart';

class LessonPageTabBar extends StatelessWidget {
  const LessonPageTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(
                70.0), // Set to 80.0, change thisa to your desired height
            child: AppBar(
              elevation: 1.0,
              backgroundColor: Colors.white,
              flexibleSpace: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          InkWell(
                            child: const Icon(
                              Icons.arrow_back,
                              size: 28,
                            ),
                            onTap: () {},
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "ماڈیول 1",
                            style: TextStyle(
                              fontFamily: 'UrduFont',
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25, bottom: 6),
                      child: InkWell(
                        child: const Icon(Icons.more_vert),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ButtonsTabBar(
                height: 50,
                radius: 20,
                elevation: 1,
                contentPadding: const EdgeInsets.symmetric(horizontal: 42),
                backgroundColor: Colors.white,
                unselectedBackgroundColor: const Color(0xffF0F0F0),
                unselectedLabelStyle: const TextStyle(
                    fontFamily: 'UrduType',
                    color: Color(0xff685F78),
                    fontWeight: FontWeight.w600),
                labelStyle: const TextStyle(
                    fontFamily: 'UrduType',
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(
                    text: "جائزہ",
                  ),
                  Tab(
                    text: "گروپس",
                  ),
                  Tab(
                    text: "بک مارکس",
                  ),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Jaiza(),
                    Courses_Completed(),
                    TotalCourses(),
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
