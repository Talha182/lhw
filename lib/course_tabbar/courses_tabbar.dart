import 'dart:ui';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'completed_courses.dart';
import 'ongoing_courses.dart';
import 'total_courses.dart';

class Courses_Tabbar extends StatefulWidget {
  const Courses_Tabbar({super.key});

  @override
  State<Courses_Tabbar> createState() => _Courses_TabbarState();
}

class _Courses_TabbarState extends State<Courses_Tabbar> {
  final GlobalKey _tabBarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 2,
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              elevation: 1.0,
              backgroundColor: Colors.white,
              flexibleSpace: Align(
                alignment: Alignment.bottomCenter,
                child: _appBar(),
              ),
            )),
        body: _tabBar(),
      ),
    );
  }

  Widget _appBar() {
    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Text(
                "کورسز",
                style: TextStyle(
                  fontFamily: 'UrduFont',
                  fontSize: 18,
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
                    onTap: () {},
                  ),
                  const SizedBox(width: 20),
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
    );
  }


  Widget _tabBar() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Stack(
            children: [
              ButtonsTabBar(
                key: _tabBarKey,
                splashColor: Colors.transparent,
                height: 50,
                radius: 20,
                elevation: 1,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
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


                  Tab(text: "تمام کورسز"),
                  Tab(text: "مکمل"),

                  Tab(text: "جاری ہے۔"),

                ],
              ),

            ],
          ),
           Expanded(
            child: TabBarView(
              children: <Widget>[

                Total(),
                CompleteCoursesScreen(),

                OnGoing(),

              ],
            ),
          ),
        ],
      ),
    );
  }


}