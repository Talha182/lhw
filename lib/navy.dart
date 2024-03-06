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

  final List<Widget> pages = [
    const HomePage(),
    const Courses_Tabbar(),
    const GroupsDiscussion(
      showAppBar: true,
    ),
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
      backgroundColor: Colors.white,
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
      bottomNavigationBar: Material(
        // elevation: 0.0, // Add this line for elevation
        child: BottomAppBar(
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

                  // The widget for the navbar item
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
                        SizedBox(
                          height: 4,
                        ),
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

                  // Adjust the padding based on the item's label
                  if (iconData['label'] == 'کورسز') {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0), // move it to the left
                      child: navBarItem,
                    );
                  } else if (iconData['label'] == 'گروپس') {
                    return Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0), // move it to the right
                      child: navBarItem,
                    );
                  } else {
                    return navBarItem;
                  }
                }).toList(),
              ),
            )),
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
        title: Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Current User ID: $_userId',
                style: TextStyle(fontSize: 20)),
            ElevatedButton(
              onPressed: () async {
                await UserService.logout();
                GlobalUser.clearUser(); // Clears the global user instance

                Navigator.of(context).pop(); // Assuming you go back to the login or home page
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
