import 'dart:async';
import 'dart:ui';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lhw/home_page/home_page.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> with TickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0;
  OverlayEntry? _overlayEntry;


  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;

  final iconList = <String>[
    'assets/icons/home.png',
    'assets/icons/courses.png',
    'assets/icons/groups.png',
    'assets/icons/report.png',
  ];

  // List of pages
  final List<Widget> pages = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];

  // Different words for each icon
  final textList = <String>['گھر', 'کورسز', 'گروپس', 'رپورٹ  '];

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    fabAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _fabAnimationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _borderRadiusAnimationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    Future.delayed(
      Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  void _toggleOverlay(bool show) {
    if (show) {
      _overlayEntry = OverlayEntry(builder: (context) {
        return Stack(
          children: [
            // Darkens only the main body background, but not the navbar and FAB
            Positioned(
              top: 0,
              bottom: 65,  // Leaving space for the navbar
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _fabAnimationController,
                builder: (BuildContext context, _) {
                  return GestureDetector(
                    onTap: () => _toggleOverlay(false),
                    child: Container(
                      color: Colors.black.withOpacity(0.5 * _fabAnimationController.value),
                    ),
                  );
                },
              ),
            ),
            // Animated container below the FAB and navbar
            AnimatedBuilder(
              animation: _fabAnimationController,
              builder: (BuildContext context, _) {
                return Positioned(
                  bottom: 65,  // Start position at the navbar's top
                  left: 0,
                  right: 0,
                  child: Transform.translate(
                    offset: Offset(0, 200 * (1 - _fabAnimationController.value)), // height of the container is 200
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        height: 200,
                        color: Colors.white,
                        child: Center(
                          child: Text("Hello"),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      });

      Overlay.of(context)!.insert(_overlayEntry!);
      _fabAnimationController.forward();
    } else {
      _fabAnimationController.reverse().then((_) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
    }
  }


  @override
  void dispose() {
    _fabAnimationController.dispose();
    _borderRadiusAnimationController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: NotificationListener<ScrollNotification>(
        child: pages[_bottomNavIndex], // Navigate to the respective page
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffFE8BD1),
        child: Image.asset(
          'assets/icons/floatingaction.png',
          width: 24,
          height: 24,
          color: Colors.white,
        ),
        onPressed: () {
          if (_overlayEntry == null) {
            _toggleOverlay(true);
          } else {
            _toggleOverlay(false);
          }
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        height: 65,
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Color(0xffFE8BD1) : Colors.grey;
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
                child: AutoSizeText(
                  textList[index], // Different word for each icon
                  maxLines: 1,
                  style: TextStyle(color: color),
                  group: autoSizeGroup,
                ),
              ),
            ],
          );
        },
        backgroundColor: Colors.white,
        activeIndex: _bottomNavIndex,
        splashColor: Color(0xffFE8BD1),
        notchAndCornersAnimation: borderRadiusAnimation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 12,
        rightCornerRadius: 12,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        shadow: BoxShadow(
          offset: Offset(0, 2),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Colors.grey,
        ),
      ),
    );
  }
}
