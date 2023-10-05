import "package:expandable/expandable.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

class MessageSettings extends StatelessWidget {
  const MessageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.5,
          backgroundColor: Colors.white,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40, // Added this to make the space equally spread
                  ),
                  const Text(
                    "ترتیبات",
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 20,
                      color: Color(0xff232323),
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  GestureDetector(
                    child: const Icon(Icons.arrow_forward, color: Colors.black),
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
      body: Padding(
        padding: EdgeInsets.only(top: 40, left: 15, right: 15),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                    child: Image.asset(
                  "assets/images/profile_pic.png",
                  fit: BoxFit.fill,
                )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "انیما اگ۔",
              style: TextStyle(fontFamily: "UrduType", fontSize: 20),
            ),
            Text(
              "9 منٹ پہلے فعال",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 14,
                  color: Color(0xff65676B)),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 35, right: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffE4E6EB)),
                        child: SvgPicture.asset(
                          "assets/images/magnifier.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Text(
                        "تلاش کریں۔",
                        style: TextStyle(fontFamily: "UrduType", fontSize: 15),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffE4E6EB)),
                        child: SvgPicture.asset(
                          "assets/images/bell.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Text(
                        "خاموش",
                        style: TextStyle(fontFamily: "UrduType", fontSize: 15),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffE4E6EB)),
                        child: SvgPicture.asset(
                          "assets/images/profile.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Text(
                        "خاموش",
                        style: TextStyle(fontFamily: "UrduType", fontSize: 15),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Directionality(
                textDirection: TextDirection.rtl,
                child:
                    _buildExpandablePanel("چیٹ کی معلومات", "چیٹ کی معلومات")),
            SizedBox(
              height: 15,
            ),
            Directionality(
                textDirection: TextDirection.rtl,
                child:
                    _buildExpandablePanel("چیٹ کو حسب ضرورت بنائیں", "چیٹ کی معلومات")),
            SizedBox(
              height: 15,
            ),
            Directionality(
                textDirection: TextDirection.rtl,
                child:
                    _buildExpandablePanel("میڈیا، فائلیں اور لنکس", "چیٹ کی معلومات")),
            SizedBox(
              height: 15,
            ),
            Directionality(
                textDirection: TextDirection.rtl,
                child:
                    _buildExpandablePanel("پرائیویسی اور سپورٹ", "چیٹ کی معلومات")),
          ],
        ),
      ),
    );
  }
}

Widget _buildExpandablePanel(String title, String content) {
  return ExpandableNotifier(
    //initialize the controller
    controller: ExpandableController(initialExpanded: false),
    child: ExpandablePanel(
      header: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Builder(
              builder: (context) {
                var controller = ExpandableController.of(context);
                return Icon(
                  controller!.expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 30,
                );
              },
            ),
          ],
        ),
      ),
      collapsed: Container(), // Empty Container
      expanded: Center(
        child: Text(
          content,
          style: TextStyle(
            fontFamily: "UrduType",
            fontSize: 18,
            color: Color(0xff414141),
          ),
        ),
      ),
      theme: const ExpandableThemeData(
        tapHeaderToExpand: true,
        tapBodyToCollapse: true,
        hasIcon: false,
      ),
    ),
  );
}
