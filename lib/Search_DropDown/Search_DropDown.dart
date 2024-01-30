import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:lhw/Search_DropDown/Courses_SearchDropDown.dart';
import 'package:lhw/Search_DropDown/Groups_SearchDropDown.dart';

import '../Reports/Resources_Bookmark.dart';
import '../Reports/Resources_Pdf.dart';

class SearchDropdown extends StatefulWidget {
  const SearchDropdown({super.key});

  @override
  State<SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  final GlobalKey _tabBarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            flexibleSpace: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 50, // Added this to make the space equally spread
                    ),
                    const Text(
                      "تلاش کریں۔",
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 20,
                        color: Color(0xff232323),
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    GestureDetector(
                      child:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      onTap: () {
                        // Add your navigation logic here
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: _tabBar(),
      ),
    );
  }
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
              // key: _tabBarKey,
              splashColor: Colors.transparent,
              height: 50,
              radius: 20,
              elevation: 1,
              contentPadding: const EdgeInsets.symmetric(horizontal: 50),
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
              tabs: [
                const Tab(text: "        گروپس           "),
                const Tab(text: "             کورسز        "),
              ],
            ),

          ],
        ),
        const Expanded(
          child: TabBarView(
            children: <Widget>[
              GroupsSearchDropDown(),
              CoursesSearchDropDown(),
            ],
          ),
        ),
      ],
    ),
  );
}

