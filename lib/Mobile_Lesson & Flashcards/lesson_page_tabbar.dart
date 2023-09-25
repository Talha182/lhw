import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lhw/Mobile_HomePage/Courses_Completed.dart';
import 'package:lhw/Mobile_HomePage/Courses_Ongoing.dart';
import 'package:lhw/Mobile_HomePage/Courses_All Courses.dart';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
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
            padding: const EdgeInsets.only(right: 20),
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 38),
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
                  const Tab(text: "جائزہ"),
                  const Tab(text: "گروپس"),
                  const Tab(text: "بک مارکس"),
                ],
              ),
              Positioned(
                bottom: 4,
                left: 5,
                child: _curvedBorderContainer(Color(0xff9AC9C2), 92, 5.0),
              ),
              Positioned(
                bottom: 4,
                left: 107,
                child: _curvedBorderContainer(Color(0xffF7DE8D), 98, 5.0),
              ),
              Positioned(
                bottom: 4,
                left: 216,
                child: _curvedBorderContainer(Color(0xff826FE3), 110, 5.0),
              ),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: <Widget>[
                Lesson(),
                Courses_Completed(),
                TotalCourses(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _curvedBorderContainer(Color color, double width, double height) {
    return CustomPaint(
      size: Size(width, height),
      painter: CurvedEndsPainter(color, width),
    );
  }
}

class CurvedEndsPainter extends CustomPainter {
  final Color color;
  final double tabWidth;

  CurvedEndsPainter(this.color, this.tabWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    const double maxRadius = 15;
    final double radius = (tabWidth > 2 * maxRadius) ? maxRadius : tabWidth / 2;

    final Path path = Path()
      ..moveTo(radius, size.height)
      ..lineTo(size.width - radius, size.height)
      ..arcToPoint(Offset(size.width, size.height - radius),
          radius: const Radius.circular(15), clockwise: false)
      ..moveTo(1, size.height - radius)
      ..arcToPoint(Offset(radius, size.height),
          radius: const Radius.circular(15), clockwise: false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
