import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:lhw/Mobile_HomePage/Courses_SearchDropDown.dart';
import 'package:lhw/Mobile_HomePage/Groups_SearchDropDown.dart';

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
            Positioned(
              bottom: 4,
              left: 4,
              child: _curvedBorderContainer(Color(0xff9AC9C2), 170, 5.0),
            ),
            Positioned(
              bottom: 4,
              left: 185,
              child: _curvedBorderContainer(Color(0xffF7DE8D), 173, 5.0),
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

Widget _curvedBorderContainer(Color color, double width, double height) {
  return CustomPaint(
    size: Size(width, height),
    painter: CurvedEndsPainter(color, width),
  );
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
