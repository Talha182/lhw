import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CoursesSearchDropDown extends StatefulWidget {
  const CoursesSearchDropDown({super.key});

  @override
  State<CoursesSearchDropDown> createState() => _CoursesSearchDropDownState();
}

class _CoursesSearchDropDownState extends State<CoursesSearchDropDown> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 20),
        child: ListView(
          children: [
            Container(
              height: 75,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xffF7F7F7)),
                  color: Color(0xffE0E0E0).withOpacity(0.5)
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Image.asset("assets/images/image 8.png"),
                      SizedBox(width: 15,),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "غذائیت کا ",
                              style: TextStyle(
                                fontFamily: "UrduType",
                                fontSize: 16,
                                color: Color(0xff7A7D84),
                              ),
                            ),
                            TextSpan(
                              text: "تعارف",
                              style: TextStyle(
                                fontFamily: "UrduType",
                                fontSize: 16,
                                color: Color(0xff7A7D84),
                                backgroundColor: Colors.yellow.shade200,  // Highlighted with yellow color
                              ),
                            ),
                          ],
                        ),
                      )],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20  ,
            ),

            Container(
              height: 75,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xffF7F7F7)),
                  color: Color(0xffE0E0E0).withOpacity(0.5)
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Image.asset("assets/images/image 8.png"),
                      SizedBox(width: 15,),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "نوعمر لڑکیوں، حاملہ اور دودھ پلانے والی ماؤں کی غذائی",
                              style: TextStyle(
                                fontFamily: "UrduType",
                                fontSize: 16,
                                color: Color(0xff7A7D84),
                              ),
                            ),
                            TextSpan(
                              text: " ضروریات",
                              style: TextStyle(
                                fontFamily: "UrduType",
                                fontSize: 16,
                                color: Color(0xff7A7D84),
                                backgroundColor: Colors.yellow.shade200,  // Highlighted with yellow color
                              ),
                            ),
                          ],
                        ),
                      )],

                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

