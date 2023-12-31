import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lhw/Bookmarks.dart';
import 'package:lhw/Discussion_Group/DiscussionGroups.dart';
import 'package:lhw/Mobile_HomePage/Courses_Completed.dart';
import 'package:lhw/Mobile_HomePage/Courses_All Courses.dart';
import 'package:lhw/Reports/Resources_Bookmark.dart';

import 'Lesson.dart';

class LessonPageTabBar extends StatefulWidget {
  const LessonPageTabBar({super.key});

  @override
  State<LessonPageTabBar> createState() => _LessonPageTabBarState();
}

class _LessonPageTabBarState extends State<LessonPageTabBar> {
  final GlobalKey _tabBarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 2,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 10),
            child: Icon(Icons.more_vert_rounded)),
        Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 7),
          child: Row(
            children: [
              GestureDetector(
                child: const Text(
                  "ماڈیول 1",
                  style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                ),
                onTap: () {},
              ),
              const SizedBox(width: 10),
              GestureDetector(
                child: const Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tabBar() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              ButtonsTabBar(
                key: _tabBarKey,
                splashColor: Colors.transparent,
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
                  Tab(text: "بک مارکس"),
                  Tab(text: "گروپس"),
                  Tab(text: "جائزہ"),
                ],
              ),

            ],
          ),
          const Expanded(
            child: TabBarView(
              children: <Widget>[
                Bookmarks(),
                GroupsDiscussion(),
                Lesson(),
              ],
            ),
          ),
        ],
      ),
    );
  }

}