import 'package:flutter/material.dart';
import 'package:lhw/courses_page/tab_bar.dart';
import 'package:lhw/home_page/home_page.dart';

class Custom_NavBar extends StatefulWidget {
  const Custom_NavBar({super.key});

  @override
  State<Custom_NavBar> createState() => _Custom_NavBarState();
}

class _Custom_NavBarState extends State<Custom_NavBar> {
  int _currentIndex = 0;
  PageController _pageController = PageController();


  final List<Map<String, String>> iconsData = [
    {'path': 'assets/icons/home.png', 'label': 'گھر'},
    {'path': 'assets/icons/courses.png', 'label': 'کورسز'},
    {'path': 'assets/icons/groups.png', 'label': 'گروپس'},
    {'path': 'assets/icons/report.png', 'label': 'رپورٹ'},
  ];

  final List<Widget> pages = [
    HomePage(),
    CoursesPage(),
    HomePage(),
    HomePage(),
  ];

  void onTabTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffFE8BD1),
        onPressed: () {},
        child: Image.asset(
          'assets/icons/floatingaction.png',
          height: 40,
          width: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Material(
        // elevation: 0.0, // Add this line for elevation
        child: BottomAppBar(
          elevation: 50.0,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          height: 65,
          shape: const CircularNotchedRectangle(),
          notchMargin: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: iconsData.map((iconData) {
              int index = iconsData.indexOf(iconData);
              return GestureDetector(
                onTap: () => onTabTapped(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(iconData['path']!, height: 24, width: 24),
                    Text(
                      iconData['label']!,
                      style: TextStyle(
                          color: Color(0xff685F78),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
