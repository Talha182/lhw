import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lhw/Image_Hotspot/LessonOption26.dart';
import 'package:lhw/Presentation/Presentation.dart';

class Course_DropDown extends StatefulWidget {
  const Course_DropDown({super.key});

  @override
  State<Course_DropDown> createState() => _Course_DropDownState();
}

class _Course_DropDownState extends State<Course_DropDown> {
  int currentUnlockedLevel = 1; // By default, only the first level is unlocked

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 365,
              maxWidth: MediaQuery.of(context).size.width - 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "ماڈیول 1 - ذیلی ماڈل 1",
                        style: TextStyle(
                            fontFamily: "UrduType", color: Color(0xff685F78)),
                      ),
                      const Text(
                        "پاکستان میں غذائیت کی صورتحال",
                        style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          // Note: SvgPicture.asset requires the flutter_svg package.
                          // SvgPicture.asset("assets/images/person_card.svg",
                          //     color: const Color(0xff685F78)),
                          const SizedBox(width: 8),
                          const Text(
                            "12 کوئز",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "UrduType",
                                color: Color(0xff685F78)),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Color(0xff685F78)),
                          ),
                          const SizedBox(width: 8),
                          // SvgPicture.asset("assets/images/clock.svg",
                          //     color: const Color(0xff685F78)),
                          const SizedBox(width: 8),
                          const Text(
                            "01 گھنٹہ 30 منٹ",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "UrduType",
                                color: Color(0xff685F78)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "تفصیل",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 18, fontFamily: "UrduType"),
                      ),
                      const Text(
                        "Lorem ipsum dolor sit amet consectetur. بیٹھو arcu sit luctus potenti et ultricies cras. Condimentum nulla quisque et accumsan. Consectetur imperdiet non nunc magnis morbi tortor میں Dictum eget. Vulputate sapien sodales ullamcorper nec tempus viverra.",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            color: Color(0xff7A7D84),
                            height: 1.2),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
                const Divider(thickness: 1),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(150, 40),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text(
                          'منسوخ کریں۔',
                          style: TextStyle(
                              fontFamily: "UrduType",
                              color: Colors.black,
                              fontSize: 15),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFE8BD1),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(150, 40),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          Get.to(LessonOption26())!.then((value) {
                            // When returning from LessonOption26, unlock the next level
                            setState(() {
                              if (currentUnlockedLevel < 3) {
                                currentUnlockedLevel++;
                              }
                            });
                          });
                        },

                        child: const Text(
                          'کورس جاری رکھیں',
                          style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



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

          //Third button
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
                    onTap: currentUnlockedLevel >= 3 ? () => showCustomDialog(context) : null,
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
                          decoration:  BoxDecoration(
                              shape: BoxShape.circle,    color: currentUnlockedLevel >= 3 ? Color(0xffFF6BC5) : Color(0xffD1D7DC)),
                          child: Center(
                            child: SvgPicture.asset("assets/images/trophy.svg",   color: currentUnlockedLevel >= 3 ? Colors.white : null),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
          // Second button
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
                        decoration:  BoxDecoration(
                            shape: BoxShape.circle,    color: currentUnlockedLevel >= 2 ? Color(0xffFF6BC5) : Color(0xffD1D7DC)),
                        child: Center(
                          child: GestureDetector(
                              onTap: currentUnlockedLevel >= 2 ? () => showCustomDialog(context) : null,

                              child:
                                  SvgPicture.asset("assets/images/book.svg",   color: currentUnlockedLevel >= 2 ? Colors.white : null)),
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
                  // The pink means it is unlocked (First button)
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
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentUnlockedLevel >= 1
                                  ? Color(0xffFF6BC5)
                                  : Color(0xffD1D7DC)),
                          child: Center(
                            child: GestureDetector(
                                onTap: currentUnlockedLevel >= 1 ? () => showCustomDialog(context) : null,

                                child:
                                    SvgPicture.asset("assets/images/tick.svg",   color: currentUnlockedLevel >= 1 ? Colors.white :null)),
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
          Positioned(
              bottom: 60, // Adjust as needed
              right: 15, // Adjust as needed
              child: CircleAvatar(
                backgroundColor: Color(0xffF6B3D0),
                radius: 30,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: SvgPicture.asset(
                      "assets/images/samina_instructor.svg",
                      fit: BoxFit.fill,
                    )),
              )),
        ],
      ),
    );
  }
}
