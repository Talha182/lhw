import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lhw/FAB_Page/BottomModalSheet.dart';
import 'package:lhw/Mobile_HomePage/Courses_tabbar.dart';
import 'package:lhw/Reports/Reports_Learning.dart';
import 'package:lhw/notification/notifications_screen.dart';

import 'Discussion_Group/DiscussionGroups.dart';
import 'Mobile_HomePage/home_page.dart';

class Custom_NavBar extends StatefulWidget {
  const Custom_NavBar({super.key});

  @override
  State<Custom_NavBar> createState() => _Custom_NavBarState();
}

class _Custom_NavBarState extends State<Custom_NavBar> {
  int _currentIndex = 0;
  bool showSheet = false;
  final PageController _pageController = PageController();

  final List<Map<String, String>> imagesData = [
    {'path': 'assets/images/home.svg', 'label': 'گھر'},
    {'path': 'assets/images/courses.svg', 'label': 'کورسز'},
    {'path': 'assets/images/groups.svg', 'label': 'گروپس'},
    {'path': 'assets/images/report.svg', 'label': 'رپورٹ'},
  ];

  final List<Widget> pages = [
    const HomePage(),
    const CoursesPage_Tabbar(),
    const GroupsDiscussion(),
    const ReportsScreen(),
  ];

  void onTabTapped(int index) {
    _pageController.jumpToPage(index);
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: pages,
            onPageChanged: (index) {
              // Only update the state if the index actually changed.
              if (_currentIndex != index) {
                setState(() {
                  _currentIndex = index;
                });
              }
            },
          ),
          if (showSheet) ...[
            GestureDetector(
              onTap: () {
                setState(() {
                  showSheet = false;
                });
              },
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child:
                      const CustomBottomModalSheet(), // Replace 'Your Content Here' with your StatefulWidget
                ),
              ),
            ),
          ]
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffFE8BD1),
        child: showSheet
            ? const Icon(Icons.close, color: Colors.white)
            : Image.asset(
                'assets/images/floatingaction.png',
                width: 24,
                height: 24,
                color: Colors.white,
              ),
        onPressed: () {
          setState(() {
            showSheet = !showSheet;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Material(
        // elevation: 0.0, // Add this line for elevation
        child: BottomAppBar(
          elevation: 50.0,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          height: 70,
          shape: const CircularNotchedRectangle(),
          notchMargin: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: imagesData.map((iconData) {
                int index = imagesData.indexOf(iconData);
                bool isSelected = _currentIndex == index;

                // The widget for the navbar item
                Widget navBarItem = GestureDetector(
                  onTap: () => onTabTapped(index),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        iconData['path']!,
                        height: 18,
                        width: 18,
                        color: isSelected ? const Color(0xffFE8BD1) : null,
                      ),
                      Text(
                        iconData['label']!,
                        style: TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 16,
                          color: isSelected ? const Color(0xffFE8BD1) : null,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );

                // Adjust the padding based on the item's label
                if (iconData['label'] == 'کورسز') {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0), // move it to the left
                    child: navBarItem,
                  );
                } else if (iconData['label'] == 'گروپس') {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0), // move it to the right
                    child: navBarItem,
                  );
                } else {
                  return navBarItem;
                }
              }).toList(),
            )
        ),
      ),
    );
  }
}
