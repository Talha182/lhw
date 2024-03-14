import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lhw/Reports/Reports_Learning.dart';
import 'package:lhw/services/global_user.dart';
import 'package:lhw/services/user_service.dart';

import 'CourseTabbar/courses_tabbar.dart';
import 'DiscussionGroup/DiscussionGroups.dart';
import 'FABPage/BottomModalSheet.dart';
import 'MobileHomePage/home_page.dart';

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
    {'path': 'assets/images/home.svg', 'label': 'ٰھوم'},
    {'path': 'assets/images/courses.svg', 'label': 'میرےمضامین'},
    {'path': 'assets/images/groups.svg', 'label': 'بات چیت'},
    {'path': 'assets/images/report.svg', 'label': 'نتائج'},
  ];

  List<Widget> _pages() {
    return [
      Builder(
        builder: (context) {
          return HomePage(onSwitchTab: onTabTapped);
        },
      ),
      const Courses_Tabbar(),
      const GroupsDiscussion(showAppBar: true),
      const ReportsScreen(),
    ];
  }

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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: _pages(), // Use the method here
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
            ModalBarrier(
              color: Colors.black54,
              dismissible: true, // Allows dismissing the barrier by tapping on it
              onDismiss: () {
                setState(() {
                  showSheet = false;
                });
              },
            ),
          ],
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            bottom: showSheet ? 0 : -400, // Animates the bottom sheet in and out of view
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
                child: const CustomBottomModalSheet(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: const Color(0xffFE8BD1),
        child: showSheet
            ? const Icon(Icons.close, color: Colors.white)
            : Image.asset(
          'assets/images/floatingaction.png',
          width: 30,
          height: 30,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            showSheet = !showSheet;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomAppBar(),
    );
  }
  // Extracted BottomAppBar code into a method for clarity
  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      elevation: 0.0,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      height: 70,
      shape: const CircularNotchedRectangle(),
      notchMargin: 0.1,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: imagesData.map((iconData) {
            int index = imagesData.indexOf(iconData);
            bool isSelected = _currentIndex == index;

            Widget navBarItem = GestureDetector(
              onTap: () => onTabTapped(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    iconData['path']!,
                    height: 20,
                    width: 20,
                    color: isSelected ? const Color(0xffFE8BD1) : null,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    iconData['label']!,
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 12,
                      color: isSelected ? const Color(0xffFE8BD1) : null,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );

            // Adjust padding based on item's label
            return Padding(
              padding: iconData['label'] == 'کورسز'
                  ? const EdgeInsets.only(left: 0.0)
                  : const EdgeInsets.only(right: 0.0),
              child: navBarItem,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int _userId = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserId();
  }

  Future<void> _fetchUserId() async {
    int userId = await UserService.getCurrentUserId();
    setState(() {
      _userId = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Current User ID: $_userId', style: const TextStyle(fontSize: 20)),
                ElevatedButton(
                  onPressed: () async {
                    await UserService.logout();
                    GlobalUser.clearUser(); // Clears the global user instance

                    Navigator.of(context)
                        .pop(); // Assuming you go back to the login or home page
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
