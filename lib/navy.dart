import 'package:flutter/material.dart';
import 'package:lhw/FAB_Page/BottomModalSheet.dart';
import 'package:lhw/courses_page/tab_bar.dart';
import 'package:lhw/home_page/home_page.dart';

class Custom_NavBar extends StatefulWidget {
  const Custom_NavBar({super.key});

  @override
  State<Custom_NavBar> createState() => _Custom_NavBarState();
}

class _Custom_NavBarState extends State<Custom_NavBar> {
  int _currentIndex = 0;
  bool showSheet = false;
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
      curve: Curves.easeInOutCubic,
    );
    // You may or may not want to set state here, depending on your requirements.
    // In this case, the onPageChanged callback takes care of setting _currentIndex.
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child:
                      CustomBottomModalSheet(), // Replace 'Your Content Here' with your StatefulWidget
                ),
              ),
            ),
          ]
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffFE8BD1),
        child: showSheet
            ? Icon(Icons.close, color: Colors.white)
            : Image.asset(
                'assets/icons/floatingaction.png',
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
            children: iconsData.map((iconData) {
              int index = iconsData.indexOf(iconData);
              bool isSelected = _currentIndex == index;
              return GestureDetector(
                onTap: () => onTabTapped(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      iconData['path']!,
                      height: 24,
                      width: 24,
                      color: isSelected ? Color(0xffFE8BD1) : null,
                    ),
                    Text(
                      iconData['label']!,
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 16,
                        color: isSelected ? Color(0xffFE8BD1) : null,
                        fontWeight: FontWeight.w500,
                      ),
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
