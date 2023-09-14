import 'dart:ui';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:lhw/Mobile_HomePage/Courses_Completed.dart';
import 'package:lhw/Mobile_HomePage/Courses_Ongoing.dart';
import 'package:lhw/Mobile_HomePage/Courses_All Courses.dart';

class CoursesPage_Tabbar extends StatefulWidget {
  const CoursesPage_Tabbar({super.key});

  @override
  State<CoursesPage_Tabbar> createState() => _CoursesPage_TabbarState();
}

class _CoursesPage_TabbarState extends State<CoursesPage_Tabbar> {
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
                  child: Image.asset(
                    'assets/images/magnifier.png',
                    color: Colors.black,
                  ),
                  onTap: () {},
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  child: Image.asset(
                    'assets/images/bell.png',
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
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
                  const Tab(text: "جاری ہے۔"),
                  const Tab(text: "مکمل"),
                  const Tab(text: "تمام کورسز"),
                ],
              ),
              Positioned(
                bottom: 4,
                left: 95,
                child: _curvedBorderContainer(Color(0xffF7DE8D), 56, 5.0),
              ),
              Positioned(
                bottom: 4,
                left: 4,
                child: _curvedBorderContainer(Color(0xff9AC9C2), 80, 5.0),
              ),
              Positioned(
                bottom: 4,
                left: 160,
                child: _curvedBorderContainer(Color(0xff826FE3), 80, 5.0),
              ),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: <Widget>[
                OnGoingCourses(),
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
