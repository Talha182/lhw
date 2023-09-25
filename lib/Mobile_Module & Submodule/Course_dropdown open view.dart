import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lhw/Presentation/Presentation.dart';

class Course_DropDown extends StatelessWidget {
  const Course_DropDown({super.key});

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
              padding: const EdgeInsets.all(20),
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
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          const SizedBox(
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
              left: 10,
              top: 180,
              child: SvgPicture.asset("assets/images/path.svg")),
          Positioned(
              left: 15,
              top: 190,
              child: SvgPicture.asset("assets/images/path_dots.svg")),
          Positioned(
              left: 10,
              top: 110,
              child: SvgPicture.asset("assets/images/pencil.svg")),
          Positioned(
              left: 70,
              top: 220,
              child: Row(
                children: [
                  const Text(
                    "لیڈی ہیلتھ ورکر کے فرائض",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Presentation()),
                      );
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffD9D9D9)),
                          shape: BoxShape.circle,
                          color: Colors.white),
                      child: Center(
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xffD1D7DC)),
                          child: Center(
                            child: SvgPicture.asset("assets/images/trophy.svg"),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
          Positioned(
              left: 115,
              top: 330,
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffD9D9D9)),
                        shape: BoxShape.circle,
                        color: Colors.white),
                    child: Center(
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffD1D7DC)),
                        child: Center(
                          child: SvgPicture.asset("assets/images/book.svg"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "بنیادی تعریفیں",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                  ),
                ],
              )),
          Positioned(
              left: 80,
              top: 530,
              child: Row(
                children: [
                  const Text(
                    "پاکستان میں غذائیت کی صورتحال",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffF5BCDF69).withOpacity(0.4)),
                        shape: BoxShape.circle,
                        color: Colors.white),
                    child: Center(
                      child: Material(
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
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
        ],
      ),
    );
  }
}
