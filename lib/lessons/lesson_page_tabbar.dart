import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:lhw/courses_page/completed_courses.dart';
import 'package:lhw/courses_page/ongoing_courses.dart';
import 'package:lhw/courses_page/total_courses.dart';
import 'package:lhw/lessons/Jaiza.dart';

class LessonPageTabBar extends StatelessWidget {
  const LessonPageTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(
                70.0), // Set to 80.0, change thisa to your desired height
            child: AppBar(
              elevation: 1.0,
              backgroundColor: Colors.white,
              flexibleSpace: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.arrow_back,
                                size: 28,
                              ),
                              onTap: () {},
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
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
                        padding: EdgeInsets.only(right: 25, bottom: 6),
                        child: InkWell(
                          child: Icon(Icons.more_vert),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ButtonsTabBar(
                height: 50,
                radius: 20,
                elevation: 1,
                contentPadding: EdgeInsets.symmetric(horizontal: 42),
                backgroundColor: Colors.white,
                unselectedBackgroundColor: Color(0xffF0F0F0),
                unselectedLabelStyle: TextStyle(
                    fontFamily: 'UrduType',
                    color: Color(0xff685F78),
                    fontWeight: FontWeight.w600),
                labelStyle: TextStyle(
                    fontFamily: 'UrduType',
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                tabs: [
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
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Jaiza(),
                    CompletedCourses(),
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
