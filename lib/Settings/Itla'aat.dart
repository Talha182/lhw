import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItlaatScreen extends StatefulWidget {
  const ItlaatScreen({super.key});

  @override
  State<ItlaatScreen> createState() => _ItlaatScreenState();
}

class _ItlaatScreenState extends State<ItlaatScreen> {

  bool firstState = false;
  bool secondState = false;
  bool thirdState = false;
  bool fourthState = false;
  bool fifthState = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ListView(
          children: [
            const Text(
              "منتخب کریں کہ کب اور کیسے مطلع کیا جائے۔",
              style: TextStyle(fontFamily: "UrduType", fontSize: 17),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const Text(
              "پش اور ای میل اطلاعات کو منتخب کریں جو آپ وصول کرنا چاہتے ہیں۔",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 13,
                  color: Color(0xff8B9DA0)),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "مخصوص نوٹیفکیشن کنٹرول",
              style: TextStyle(fontFamily: "UrduType", fontSize: 17),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const Text(
              "اپنے موبائل اور ڈیسک ٹاپ اطلاعات کا نظم کریں۔  ",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 13,
                  color: Color(0xff8B9DA0)),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const SizedBox(
              height: 10,
            ),
            Directionality(
              textDirection:
                  TextDirection.rtl, // Set the text direction to right-to-left
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "کورس کی یاددہانی",
                        style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                      ),
                      Text(
                        "کسی بھی شروع شدہ کورسز میں میری پیشرفت کے بارے میں مجھے مطلع کریں۔",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 13,
                            color: Color(0xff8B9DA0)),
                        textAlign: TextAlign.right, // Align text to the right
                      ),
                    ],
                  ),
                  CupertinoSwitch(
                    activeColor: const Color(0xff72C391),
                    value: firstState,
                    onChanged: (value) {
                      setState(() {
                        firstState = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Directionality(
              textDirection:
                  TextDirection.rtl, // Set the text direction to right-to-left
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "اچیومنٹ اپڈیٹس",
                        style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                      ),
                      Text(
                        "جب میں اپنے سیکھنے کے سفر میں اہم سنگ میل یا بیجز حاصل کروں تو مجھے مطلع کریں۔",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 13,
                            color: Color(0xff8B9DA0)),
                        textAlign: TextAlign.right, // Align text to the right
                      ),
                    ],
                  ),
                  CupertinoSwitch(
                    activeColor: const Color(0xff72C391),
                    value: secondState,
                    onChanged: (value) {
                      setState(() {
                        secondState = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Directionality(
              textDirection:
                  TextDirection.rtl, // Set the text direction to right-to-left
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "لیڈر بورڈ تبدیلیاں",
                        style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                      ),
                      Text(
                        "مجھے میری لیڈر بورڈ پوزیشن اور متعلقہ واقعات میں تبدیلیوں کے بارے میں مطلع کریں۔",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 13,
                            color: Color(0xff8B9DA0)),
                        textAlign: TextAlign.right, // Align text to the right
                      ),
                    ],
                  ),
                  CupertinoSwitch(
                    activeColor: const Color(0xff72C391),
                    value: thirdState,
                    onChanged: (value) {
                      setState(() {
                        thirdState = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Directionality(
              textDirection:
                  TextDirection.rtl, // Set the text direction to right-to-left
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "تاثرات کی یاد دہانیاں",
                        style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                      ),
                      Text(
                        "جب کورس کے مواد یا پلیٹ فارم کی خصوصیات کے لیے تاثرات درکار ہوں تو مجھے مطلع کریں۔",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 13,
                            color: Color(0xff8B9DA0)),
                        textAlign: TextAlign.right, // Align text to the right
                      ),
                    ],
                  ),
                  CupertinoSwitch(
                    activeColor: const Color(0xff72C391),
                    value: fourthState,
                    onChanged: (value) {
                      setState(() {
                        fourthState = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Directionality(
              textDirection:
                  TextDirection.rtl, // Set the text direction to right-to-left
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "ڈسکشن گروپس",
                        style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                      ),
                      Text(
                        "ڈسکشن گروپس میں کسی بھی سرگرمی یا شناخت کے بارے میں مجھے مطلع کریں۔",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 13,
                            color: Color(0xff8B9DA0)),
                        textAlign: TextAlign.right, // Align text to the right
                      ),
                    ],
                  ),
                  CupertinoSwitch(
                    activeColor: const Color(0xff72C391),
                    value: fifthState,
                    onChanged: (value) {
                      setState(() {
                        fifthState = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "اطلاع کی آواز",
              style: TextStyle(fontFamily: "UrduType", fontSize: 17),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const Text(
              "وہ زبان منتخب کریں جس میں آپ دیکھنا چاہتے ہیں۔ ",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 13,
                  color: Color(0xff8B9DA0)),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xffCDD1E0))),
              child: const Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "کمپن کے ساتھ خاموش",
                          style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                          textAlign: TextAlign.right, // Align text to the right
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),

            const Text(
              "اطلاع کی تعدد",
              style: TextStyle(fontFamily: "UrduType", fontSize: 17),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const Text(
              "وہ زبان منتخب کریں جس میں آپ دیکھنا چاہتے ہیں۔ ",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 13,
                  color: Color(0xff8B9DA0)),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xffCDD1E0))),
              child: const Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "فوری طور پر",
                          style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                          textAlign: TextAlign.right, // Align text to the right
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
