import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDCD31),
      body: Stack(
        children: [
          Positioned(
              top: 0, left: 0, child: Image.asset("assets/images/splash.png",width: 200,height: 200,fit: BoxFit.contain,)),
          Positioned(
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
                        border: Border.all(color: Color(0xffC4C4C4))),
                    child: Image.asset(
                      "assets/images/person1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    "جیکسن",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                  ),
                  Text(
                    "08",
                    style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff3D3D3D)),
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
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        ),
                    child: Image.asset(
                      "assets/images/person2.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    "جیکسن",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                  ),
                  Text(
                    "10",
                    style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff3D3D3D)),
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
                        border: Border.all(color: Color(0xffC4C4C4))),
                    child: Image.asset(
                      "assets/images/person3.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    "ایما",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                  ),
                  Text(
                    "09",
                    style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff3D3D3D)),
                  ),
                ],
              )),

        ],
      ),
    );
  }
}
