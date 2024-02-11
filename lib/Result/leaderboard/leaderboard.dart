import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../CustomWidgets/Row_Column_Padding.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffFDCD31),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/splash.png",
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              )),
          const Positioned(
              top: 20,
              left: 70,
              child: Text(
                "لیڈر بورڈ",
                style: TextStyle(fontFamily: "UrduType", fontSize: 22),
              )),
          Positioned(
              top: 20,
              right: 20,
              child: Image.asset(
                "assets/images/star 1.png",
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              )),
          Positioned(
              top: 50,
              right: 70,
              child: Image.asset(
                "assets/images/star 2.png",
                width: 70,
                height: 70,
                fit: BoxFit.contain,
              )),
          Positioned(
              top: 160,
              left: 40,
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffC4C4C4))),
                    child: Image.asset(
                      "assets/images/person1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    "جیکسن",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                  ),
                  Text(
                    "08",
                    style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff3D3D3D)),
                  ),
                ],
              )),
          Positioned(
              top: 90,
              left: 140,
              child: Column(
                children: [
                  Image.asset("assets/images/crown.png"),
                  Container(
                    width: 110,
                    height: 110,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      "assets/images/person2.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    "جیکسن",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                  ),
                  Text(
                    "10",
                    style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff3D3D3D)),
                  ),
                ],
              )),
          Positioned(
              top: 160,
              left: 270,
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffC4C4C4))),
                    child: Image.asset(
                      "assets/images/person3.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    "ایما",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                  ),
                  Text(
                    "09",
                    style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff3D3D3D)),
                  ),
                ],
              )),
          Positioned(
            top: 0.4 * screenHeight, // This will
            child: Container(
              width: screenWidth,
              height: 0.6 *
                  screenHeight, // This ensures the container stretches till the bottom
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "سرور",
                            style: TextStyle(
                                fontFamily: "UrduType",
                                color: Color(0xff7A7D84),
                                fontSize: 16),
                          ),
                          Text(
                            "درست جوابات",
                            style: TextStyle(
                                fontFamily: "UrduType",
                                color: Color(0xff7A7D84),
                                fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...columnPadded([
                            const Leaderboard_Card(name: 'ٹم ہڈسن', number: '5',),
                            const Leaderboard_Card(number: '6', name: 'کیتھرین مرفی',),
                            const Leaderboard_Card(name: 'بروکلین سیمنز', number: '7',),
                            const Leaderboard_Card(name: 'Name', number: '8',),
                          ], 10)
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              width: 1, // the thickness
                              color: Colors.black // the color of the border
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(150, 37),
                        ),
                        onPressed: () {

                        },
                        child: const Text(
                          'منسوخ کریں۔',
                          style: TextStyle(
                            fontFamily: 'UrduType',
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class Leaderboard_Card extends StatelessWidget {
  final String name;
  final String number;
  const Leaderboard_Card({
    super.key,
    required this.name, required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          number,
          style: GoogleFonts.raleway(
              color: const Color(0xff7A7D84),
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Container(
            height: 65,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          "assets/images/person1.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                            fontFamily: "UrduType",
                            color: Color(0xff7A7D84),
                            fontSize: 17),
                      ),
                    ],
                  ),
                  Text(
                    "3",
                    style: GoogleFonts.raleway(
                        fontSize: 20,
                        color: const Color(0xff7A7D84),
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
