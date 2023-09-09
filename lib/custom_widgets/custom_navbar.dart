import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lhw/home_page/home_page.dart';

import '../courses_page/tab_bar.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> with TickerProviderStateMixin {
  var _bottomNavIndex = 0;
  bool showSheet = false;

  final iconList = [
    'assets/images/home.png',
    'assets/images/courses.png',
    'assets/images/groups.png',
    'assets/images/report.png',
  ];

  final List<Widget> pages = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];

  final textList = ['گھر', 'کورسز', 'گروپس', 'رپورٹ'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            child: pages[_bottomNavIndex],
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: showSheet ? 0.5 : 0.0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showSheet = false;
                });
              },
              child: Container(
                color: Colors.black,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: showSheet ? 28 : -300,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 350,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: const Center(child: Text('Your Content Here')),
              ),
            ),
          ),
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
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        height: 65,
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? const Color(0xffFE8BD1) : Colors.grey;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconList[index],
                width: 24,
                height: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  textList[index],
                  maxLines: 1,
                  style: TextStyle(color: color),
                ),
              ),
            ],
          );
        },
        backgroundColor: Colors.white,
        activeIndex: _bottomNavIndex,
        splashColor: const Color(0xffFE8BD1),
        notchAndCornersAnimation: null,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 12,
        rightCornerRadius: 12,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        shadow: const BoxShadow(
          offset: Offset(0, 2),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Colors.grey,
        ),
      ),
    );
  }
}
