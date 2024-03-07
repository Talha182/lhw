import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

import 'TopPerformers.dart';

class Achievements extends StatefulWidget {
  const Achievements({Key? key}) : super(key: key);

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: ListView(
              children: [
                const Text(
                  "کامیابیاں اور پہچان",
                  style: TextStyle(fontFamily: "UrduType", fontSize: 18),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 860,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "تمغے",
                          style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                        ),
                        const Text(
                          "اپنے کمائے ہوئے بیجز کا مجموعہ اور ان کی متعلقہ کامیابیاں دیکھیں",
                          style: TextStyle(
                              fontFamily: "UrduType",
                              fontSize: 14,
                              color: Color(0xff8B9DA0)),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 760,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xffE3E3E3)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Image.asset(
                                          "assets/images/badge1.png",
                                          scale: 0.8),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "سنہرے ساتھی",
                                                style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                "10/14", // Replace this with your desired text
                                                style: TextStyle(
                                                    fontFamily: "UrduType",
                                                    fontSize:
                                                        14, // Adjust this as needed
                                                    color: Color(0xff8B9DA0)),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          RightStartingProgressBar(
                                            width: 320,
                                            height: 10,
                                            targetProgress: 0.2,
                                            backgroundColor:
                                                const Color(0xffEBEBF0),
                                            strokeWidth: 10.0,
                                          ),
                                          const Text(
                                            "کامیابیاں اور خوشیاں ہمیشہ بانٹنی چاہئیں۔ سوشل میڈیا پر شیئر کریں اور جیتیں۔",
                                            style: TextStyle(
                                                fontFamily: "UrduType",
                                                color: Color(0xff8B9DA0)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Image.asset(
                                          "assets/images/badge2.png",
                                          scale: 0.8),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "دانش کے موتی",
                                                style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                "10/14", // Replace this with your desired text
                                                style: TextStyle(
                                                    fontFamily: "UrduType",
                                                    fontSize:
                                                        14, // Adjust this as needed
                                                    color: Color(0xff8B9DA0)),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          RightStartingProgressBar(
                                            width: 320,
                                            height: 10,
                                            targetProgress: 0.2,
                                            backgroundColor:
                                                const Color(0xffEBEBF0),
                                            strokeWidth: 10.0,
                                          ),
                                          const Text(
                                            "14کامیابیاں اور خوشیاں ہمیشہ بانٹنی چاہئیں۔ سوشل میڈیا پر شیئر کریں اور جیتیں۔",
                                            style: TextStyle(
                                                fontFamily: "UrduType",
                                                color: Color(0xff8B9DA0)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Image.asset(
                                          "assets/images/badge3.png",
                                          scale: 0.8),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "حاضر ستارے",
                                                style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                "10/14", // Replace this with your desired text
                                                style: TextStyle(
                                                    fontFamily: "UrduType",
                                                    fontSize:
                                                        14, // Adjust this as needed
                                                    color: Color(0xff8B9DA0)),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          RightStartingProgressBar(
                                            width: 320,
                                            height: 10,
                                            targetProgress: 0.2,
                                            backgroundColor:
                                                const Color(0xffEBEBF0),
                                            strokeWidth: 10.0,
                                          ),
                                          const Text(
                                            "ہر روز ایپ استعمال کریں اور یہ تمغہ جیتیں! یہ تمغہ دن میں کم از کم ایک دفعہ ایپ استعمال کرنے پر ملتا ہے۔",
                                            style: TextStyle(
                                                fontFamily: "UrduType",
                                                color: Color(0xff8B9DA0)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Image.asset(
                                          "assets/images/badge4.png",
                                          scale: 0.8),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "باغبان فہم",
                                                style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                "10/14", // Replace this with your desired text
                                                style: TextStyle(
                                                    fontFamily: "UrduType",
                                                    fontSize:
                                                        14, // Adjust this as needed
                                                    color: Color(0xff8B9DA0)),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          RightStartingProgressBar(
                                            width: 320,
                                            height: 10,
                                            targetProgress: 0.2,
                                            backgroundColor:
                                                const Color(0xffEBEBF0),
                                            strokeWidth: 10.0,
                                          ),
                                          const Text(
                                            "کسی بھی ذہین شخص کی پہچان اس کے سیکھنے کے عمل میں دلچسپی ہوتی ہے۔ سوالات پوچھیں اور یہ تمغہ حاصل کریں۔",
                                            style: TextStyle(
                                                fontFamily: "UrduType",
                                                color: Color(0xff8B9DA0)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Image.asset(
                                          "assets/images/badge5.png",
                                          scale: 0.8),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "ضامن",
                                                style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                "10/14", // Replace this with your desired text
                                                style: TextStyle(
                                                    fontFamily: "UrduType",
                                                    fontSize:
                                                        14, // Adjust this as needed
                                                    color: Color(0xff8B9DA0)),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          RightStartingProgressBar(
                                            width: 320,
                                            height: 10,
                                            targetProgress: 0.3,
                                            backgroundColor:
                                                const Color(0xffEBEBF0),
                                            strokeWidth: 10.0,
                                          ),
                                          const Text(
                                            "وسائل ڈاؤنلوڈ کریں اور جیتیں!",
                                            style: TextStyle(
                                                fontFamily: "UrduType",
                                                color: Color(0xff8B9DA0)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Image.asset(
                                          "assets/images/badge1.png",
                                          scale: 0.8),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "ماہر محنت",
                                                style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                "10/14", // Replace this with your desired text
                                                style: TextStyle(
                                                    fontFamily: "UrduType",
                                                    fontSize:
                                                        14, // Adjust this as needed
                                                    color: Color(0xff8B9DA0)),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          RightStartingProgressBar(
                                            width: 320,
                                            height: 10,
                                            targetProgress: 0.2,
                                            backgroundColor:
                                                const Color(0xffEBEBF0),
                                            strokeWidth: 10.0,
                                          ),
                                          const Text(
                                            "کسی بھی سبق میں اپنے نمبر دہرائی کے بعد بہتر کرنے پر آپ کو یہ تمغہ انعام کیا جائے گا۔ یہ تمغہ آپ کے حوصلے کو سراہتا ہے۔",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: "UrduType",
                                                color: Color(0xff8B9DA0)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Image.asset(
                                          "assets/images/badge1.png",
                                          scale: 0.8),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "نورِ چمن",
                                                style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                "10/14", // Replace this with your desired text
                                                style: TextStyle(
                                                    fontFamily: "UrduType",
                                                    fontSize:
                                                        14, // Adjust this as needed
                                                    color: Color(0xff8B9DA0)),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          RightStartingProgressBar(
                                            width: 320,
                                            height: 10,
                                            targetProgress: 0.2,
                                            backgroundColor:
                                                const Color(0xffEBEBF0),
                                            strokeWidth: 10.0,
                                          ),
                                          const Text(
                                            "یونٹ مکمل کیجئے اور جیتتے! یہ تمغہ آپ کے علم کے سفر میں اہم سنگِ میل ہے۔",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: "UrduType",
                                                color: Color(0xff8B9DA0)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffF0F0F0)),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Image.asset(
                          "assets/images/splash.png",
                          scale: 1.2,
                          color: const Color(0xffE0E0E0),
                        ),
                      ),
                      Positioned(
                          top: 105,
                          left: 35,
                          child: Image.asset(
                            "assets/images/star 2.png",
                            color: const Color(0xffE0E0E0),
                            scale: 0.9,
                          )),
                      Positioned(
                          top: 100,
                          left: 95,
                          child: Image.asset(
                            "assets/images/star 1.png",
                            color: const Color(0xffE0E0E0),
                            scale: 1.2,
                          )),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Image.asset(
                            "assets/images/Star 7.png",
                            color: const Color(0xffE0E0E0),
                            scale: 1,
                          )),
                      Positioned(
                          top: 45,
                          right: 50,
                          child: Image.asset(
                            color: const Color(0xffE0E0E0),
                            "assets/images/star 1.png",
                            scale: 1.5,
                          )),
                      Positioned(
                          top: 30,
                          right: 78,
                          child: Image.asset(
                            color: const Color(0xffE0E0E0),
                            "assets/images/star 2.png",
                            scale: 1.8,
                          )),
                      Positioned(
                          top: 65,
                          right: 55,
                          child: Image.asset(
                            color: const Color(0xffE0E0E0),
                            "assets/images/star 2.png",
                            scale: 1,
                          )),
                      const Positioned(
                          top: 10,
                          right: 10,
                          child: Text(
                            "نیشنل لیڈر بورڈ",
                            style:
                                TextStyle(fontFamily: "UrduType", fontSize: 18),
                          )),
                      const Positioned(
                          top: 35,
                          right: 10,
                          child: Text(
                            "یونٹ اور اسباق، تکمیل کی حیثیت اور آگے کیا ہے اس پر روشنی ڈالتے ہیں۔",
                            style: TextStyle(
                                fontFamily: "UrduType",
                                fontSize: 16,
                                color: Color(0xff8B9DA0)),
                          )),
                      Positioned(
                          top: 140,
                          right: 20,
                          child: Column(
                            children: [
                              Image.asset("assets/images/crown.png"),
                              Container(
                                width: 90,
                                height: 90,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Image.asset(
                                  "assets/images/person2.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          )),
                      Positioned(
                          top: 245,
                          right: 55,
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color(0xff8A8C93), width: 2)),
                            child: const Center(
                                child: Text(
                              "10",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            )),
                          )),
                      Positioned(
                          top: 150,
                          right: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "عیدین سمتھ",
                                style: TextStyle(
                                  fontFamily: "UrduType",
                                  fontSize: 20,
                                ),
                              ),
                              const Row(
                                children: [
                                  Text(
                                    "نمبر:",
                                    style: TextStyle(
                                        fontFamily: "UrduType",
                                        color: Color(0xff8B9DA0)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "100",
                                    style: TextStyle(
                                        fontFamily: "UrduType", fontSize: 19),
                                  )
                                ],
                              ),
                              Container(
                                width: 145,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: const Color(0xffFDCD4F),
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 5, top: 5),
                                  child: Text(
                                    "9ویں تک جانے کے لیے 150 پوائنٹس",
                                    style: TextStyle(
                                        fontFamily: "UrduType", fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _TabBarWithPages(), // Insert the tab bar with pages here
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabBarWithPages extends StatefulWidget {
  @override
  _TabBarWithPagesState createState() => _TabBarWithPagesState();
}

class _TabBarWithPagesState extends State<_TabBarWithPages>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Updated to 3
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tabBar(), // Custom tab bar integrated
        Container(
          height: 500,
          child: TabBarView(
            controller: _tabController,
            children: [
               Page2(),
               TopPerformers(),

            ],
          ),
        ),
      ],
    );
  }

  Widget _tabBar() {
    final GlobalKey _tabBarKey = GlobalKey();
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              ButtonsTabBar(
                key: _tabBarKey,
                controller: _tabController, // Added this line
                splashColor: Colors.transparent,
                height: 50,
                radius: 20,
                elevation: 1,
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
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
                  const Tab(text: "درجہ مہارت"),
                  const Tab(text: "ہونہار طلبہ"),
                ],
              ),
              
            ],
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
      ..strokeWidth = 1.7;

    const double maxRadius = 12;
    final double radius = (tabWidth > 2 * maxRadius) ? maxRadius : tabWidth / 2;

    final Path path = Path()
      ..moveTo(radius, size.height)
      ..lineTo(size.width - radius, size.height)
      ..arcToPoint(Offset(size.width, size.height - radius),
          radius: const Radius.circular(17), clockwise: false)
      ..moveTo(1, size.height - radius)
      ..arcToPoint(Offset(radius, size.height),
          radius: const Radius.circular(17), clockwise: false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class RightStartingProgressBar extends StatefulWidget {
  final double width;
  final double height;
  final double
      targetProgress; // Renamed to "targetProgress" to indicate final value after animation
  final Color backgroundColor;
  final double strokeWidth;

  RightStartingProgressBar({
    required this.width,
    required this.height,
    required this.targetProgress,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  _RightStartingProgressBarState createState() =>
      _RightStartingProgressBarState();
}

class _RightStartingProgressBarState extends State<RightStartingProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Animation duration
      vsync: this,
    );

    _animation =
        Tween<double>(begin: 0, end: widget.targetProgress).animate(_controller)
          ..addListener(() {
            setState(
                () {}); // Trigger a rebuild whenever the animation value changes
          });

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Clean up the controller when the widget is removed from the widget tree
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.strokeWidth / 2),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: (widget.height - widget.strokeWidth) / 2,
            child: Container(
              height: widget.strokeWidth,
              width: widget.width *
                  _animation.value, // Use the animation value here
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xffF4D6A9), Color(0xffEAAF58)]),
                borderRadius: BorderRadius.circular(widget.strokeWidth / 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
