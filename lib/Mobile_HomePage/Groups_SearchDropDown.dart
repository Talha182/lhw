import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class GroupsSearchDropDown extends StatefulWidget {
  const GroupsSearchDropDown({super.key});

  @override
  State<GroupsSearchDropDown> createState() => _GroupsSearchDropDownState();
}

class _GroupsSearchDropDownState extends State<GroupsSearchDropDown> {
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
                  color: Color(0xffE0E0E0).withOpacity(0.5)),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Image.asset("assets/images/group1.png"),
                      SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "خاندانی",
                                    style: TextStyle(
                                      fontFamily: "UrduType",
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " منصوبہ بندی",
                                    style: TextStyle(
                                      fontFamily: "UrduType",
                                      fontSize: 16,
                                      color: Colors.black,
                                      backgroundColor: Colors.yellow.shade200,  // Highlighted with yellow color
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text("Lorem ipsum dolor sit amet consectetur.",style: TextStyle(
                                color: Color(0xff7A7D84,),
                                fontFamily: "UrduType"
                            ),textDirection: TextDirection.ltr,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 75,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xffF7F7F7)),
                  color: Color(0xffE0E0E0).withOpacity(0.5)),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Image.asset("assets/images/group2.png"),
                      SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "خاندانی",
                                    style: TextStyle(
                                      fontFamily: "UrduType",
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " منصوبہ بندی",
                                    style: TextStyle(
                                      fontFamily: "UrduType",
                                      fontSize: 16,
                                      color: Colors.black,
                                      backgroundColor: Colors.yellow.shade200,  // Highlighted with yellow color
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text("Lorem ipsum dolor sit amet consectetur.",style: TextStyle(
                              color: Color(0xff7A7D84,),
                              fontFamily: "UrduType"
                            ),textDirection: TextDirection.ltr,)
                          ],
                        ),
                      )
                    ],
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
