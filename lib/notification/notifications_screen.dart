import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          elevation: 1.0,
          backgroundColor: Colors.white,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0, bottom: 5),
                  child: GestureDetector(
                    child: Text(
                      "پڑھا ہوا نشان زد کریں۔",
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 20,
                        color: Color(0xffFE8BD1),
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection:
                          TextDirection.rtl, // Align text from the right
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, right: 40),
                  child: Text(
                    "اطلاعات",
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 20,
                      color: Color(0xff232323),
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection:
                        TextDirection.rtl, // Align text from the right
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    child: Icon(Icons.arrow_forward),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Text("آج",
                textDirection: TextDirection.rtl), // Align text from the right
          ],
        ),
      ),
    );
  }
}
