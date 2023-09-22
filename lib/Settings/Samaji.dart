import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SamajiScreen extends StatefulWidget {
  const SamajiScreen({super.key});

  @override
  State<SamajiScreen> createState() => _SamajiScreenState();
}

class _SamajiScreenState extends State<SamajiScreen> {
  bool firstState = false;
  bool secondState = false;
  bool thirdState = false;
  bool fourthState = false;
  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ListView(
          children: [
            const Text(
              "سوشل میڈیا کنکشنز",
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
              height: 15,
            ),
            const Text(
              "لنکڈن",
              style: TextStyle(fontFamily: "UrduType", fontSize: 17),
              textAlign: TextAlign.right, // Align text to the right
            ),
            TextField(
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: "URL درج کریں۔",
                hintStyle:
                    const TextStyle(fontFamily: "UrduType", color: Colors.black),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0), // Adjust vertical padding
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "فیس بک",
              style: TextStyle(fontFamily: "UrduType", fontSize: 17),
              textAlign: TextAlign.right, // Align text to the right
            ),
            TextField(
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: "URL درج کریں۔",
                hintStyle:
                    const TextStyle(fontFamily: "UrduType", color: Colors.black),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0), // Adjust vertical padding
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "انسٹاگرام",
              style: TextStyle(fontFamily: "UrduType", fontSize: 17),
              textAlign: TextAlign.right, // Align text to the right
            ),
            TextField(
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: "URL درج کریں۔",
                hintStyle:
                    const TextStyle(fontFamily: "UrduType", color: Colors.black),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0), // Adjust vertical padding
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "ٹویٹر",
              style: TextStyle(fontFamily: "UrduType", fontSize: 17),
              textAlign: TextAlign.right, // Align text to the right
            ),
            TextField(
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: "URL درج کریں۔",
                hintStyle:
                    const TextStyle(fontFamily: "UrduType", color: Colors.black),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0), // Adjust vertical padding
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              thickness: 1,
            ),
            const Text(
              "اشتراک کی ترتیبات",
              style: TextStyle(fontFamily: "UrduType", fontSize: 17),
              textAlign: TextAlign.right,
            ),
            const Text(
              "کورس کا مواد صرف وائی فائی سے منسلک ہونے پر ڈاؤن لوڈ ہوتا ہے۔",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 13,
                  color: Color(0xff8B9DA0)),
              textAlign: TextAlign.right, // Align text to the right
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
                        "وائی فائی صرف ڈاؤن لوڈز",
                        style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                      ),
                      Text(
                        "کورس کا مواد صرف وائی فائی سے منسلک ہونے پر ڈاؤن لوڈ ہوتا ہے۔",
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
              "اشتراک کی ترتیبات",
              style: TextStyle(fontFamily: "UrduType", fontSize: 17),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const Text(
              "فیصلہ کریں کہ کس چیز کا خود بخود اشتراک کیا جاتا ہے۔",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 13,
                  color: Color(0xff8B9DA0)),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const SizedBox(
              height: 15,
            ),
            Directionality(
              textDirection:
                  TextDirection.rtl, // Set the text direction to right-to-left
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "مکمل کورسز",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 17),
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
            ),const SizedBox(
              height: 15,
            ),
            Directionality(
              textDirection:
                  TextDirection.rtl, // Set the text direction to right-to-left
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "بیجز حاصل کئے ",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 17),
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
            ),const SizedBox(
              height: 15,
            ),
            Directionality(
              textDirection:
                  TextDirection.rtl, // Set the text direction to right-to-left
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "لیڈر بورڈ رینک ",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 17),
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
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
