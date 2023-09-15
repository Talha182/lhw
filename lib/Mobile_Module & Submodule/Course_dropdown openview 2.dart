import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Course_DropDown2 extends StatelessWidget {
  const Course_DropDown2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(0, -0.2),
                colors: [
                  const Color(0xff80B8FB).withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.close,
                          size: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          SizedBox(
                            height: 30,
                          ),
                          SvgPicture.asset(
                            'assets/images/cloud.svg',
                            width: 30,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                        ]),
                        SvgPicture.asset(
                          'assets/images/cloud.svg',
                          width: 30,
                          height: 30,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              left: 40,
              top: 140,
              child: SvgPicture.asset("assets/images/path2.svg")),
          Positioned(
              left: 50,
              top: 150,
              child: SvgPicture.asset("assets/images/path_dots2.svg")),
          Positioned(
              left: 55,
              top: 130,
              child: Row(
                children: [
                  Text(
                    "لیڈی ہیلتھ ورکر کے فرائض",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffD9D9D9)),
                        shape: BoxShape.circle,
                        color: Colors.white),
                    child: Center(
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffD1D7DC)),
                        child: Center(
                          child: SvgPicture.asset("assets/images/trophy.svg"),
                        ),
                      ),
                    ),
                  )
                ],
              )),
          Positioned(
              left: 25,
              top: 230,
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffD9D9D9)),
                        shape: BoxShape.circle,
                        color: Colors.white),
                    child: Center(
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffD1D7DC)),
                        child: Center(
                          child: SvgPicture.asset("assets/images/book.svg"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "بنیادی تعریفیں",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                  ),
                ],
              )),

          Positioned(
              bottom: 0, child: SvgPicture.asset("assets/images/build1.svg")),
          Positioned(
              bottom: 0,
              left: 80,
              child: SvgPicture.asset("assets/images/build2.svg")),
          Positioned(
              bottom: 0,
              left: 200,
              child: SvgPicture.asset("assets/images/build3.svg")),
          Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset("assets/images/build4.svg")),
          Positioned(
              bottom: 0, child: SvgPicture.asset("assets/images/bottom.svg")),
          Positioned(
              left: 70,
              bottom: 150,
              child: Row(
                children: [
                  Text(
                    "پاکستان میں غذائیت کی صورتحال",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffF5BCDF69).withOpacity(0.4)),
                        shape: BoxShape.circle,
                        color: Colors.white),
                    child: Center(
                      child: Material(
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xffFF6BC5)),
                          child: Center(
                            child: SvgPicture.asset("assets/images/tick.svg"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            Positioned(
              left: 270,
              top: 250,
              child: SvgPicture.asset("assets/images/flag.svg")
            )
        ],
      ),
    );
  }
}
