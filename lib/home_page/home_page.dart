import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/progress_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String dropdownvalue = 'اس ہفتے';

// List of items in our dropdown menu
var items = [
  'اس ہفتے',
  'Item 2',
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
                70.0), // Set to 80.0, change thisa to your desired height
            child: AppBar(
              elevation: 1.0,
              backgroundColor: Colors.white,
              flexibleSpace: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          "ڈیش بورڈ",
                          style: GoogleFonts.abhayaLibre(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Row(
                          children: [
                            InkWell(
                              child: Image.asset(
                                'assets/icons/magnifier.png',
                                color: Colors.black,
                              ),
                              onTap: () {},
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              child: Image.asset(
                                'assets/icons/bell.png',
                                color: Colors.black,
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'میرے کورسز',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 180,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [Color(0xffDCEFDE), Color(0xff81C588)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.check_circle_outline,
                                        size: 19, color: Color(0xff7A7D84)),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'مکمل کورس',
                                      style: TextStyle(
                                          color: Color(0xff7A7D84),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "3",
                                    style: GoogleFonts.raleway(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [Color(0xffF4B9E1), Color(0xffED8DCE)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.asset('assets/icons/courses.png'),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'باقی کورس',
                                      style: TextStyle(
                                          color: Color(0xff7A7D84),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "12",
                                    style: GoogleFonts.raleway(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      elevation: 1, // Set your desired elevation value here
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: screenWidth - 40,
                        height: 450,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "جاری کورس",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print("Button pressed");
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "کورس پر جائیں۔",
                                          style: TextStyle(
                                              color: Color(0xffFE8BD1),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width:
                                              5, // space between Text and Icon
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(
                                            0xffFE8BD1,
                                          ),
                                          size: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  // Container with circular border containing an image
                                  Container(
                                    width: 180,
                                    height: 135,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/team.png'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  // Column containing three texts
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'خاندانی منصوبہ بندی',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.01),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Image.asset("assets/icons/book.png"),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '24 ماڈیولز',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.01),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            width: 5,
                                            height: 5,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Image.asset('name'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Image.asset("assets/icons/book.png"),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text("12 کوئز",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.01))
                                        ],
                                      ),
                                      SizedBox(height: 25),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'پیش رفت',
                                            style: TextStyle(
                                                color: Color(0xff7A7D84),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 80,
                                          ),
                                          Text(
                                            '${(0.6 * 100).toInt()}%', // The percentage value
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2),
                                      ProgressBar(
                                        width: 160.0,
                                        height: 6.0,
                                        value: 0.6, // 60%
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 30),
                                  child: Container(
                                    width: 340,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Color(0xffE5E5E5),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // 3D looking circle container
                                          Container(
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xffF4D6A9),
                                                  Color(0xffEAAF58)
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                            ),
                                          ),

                                          SizedBox(
                                            width: 20,
                                          ),

                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("کوئز 1 زیر التوا ہے۔ ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                RichText(
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: "آخری تاریخ: ",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors
                                                              .grey, // Set the color to gray
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: "25 جون 2023",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors
                                                              .black, // Set the color to black
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Icon button on the right
                                          InkWell(
                                            child:
                                                Icon(Icons.arrow_forward_ios),
                                            onTap: () {},
                                          ),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 15),
                                  child: Container(
                                    width: 340,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Color(0xffE5E5E5),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // 3D looking circle container
                                          Container(
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xffF4B9E1),
                                                  Color(0xffED8DCE)
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),

                                          SizedBox(
                                            width: 20,
                                          ),

                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("ماڈیولز مکمل ہو گئے۔ ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text("12"),
                                              ],
                                            ),
                                          ),
                                          // Icon button on the right
                                          InkWell(
                                            child:
                                                Icon(Icons.arrow_forward_ios),
                                            onTap: () {},
                                          ),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      elevation: 1, // Set your desired elevation value here
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: screenWidth - 40,
                        height: 450,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "جاری کورس",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey, // Specify the border color
                                          width: 1.0,         // Specify the border width
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 12.0,), // Adjust the padding values to control the height
                                        child: DropdownButton<String>(
                                          icon: Icon(Icons.arrow_downward_sharp),
                                          value: dropdownvalue,
                                          items: items.map((String item) {
                                            return DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownvalue = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  // Container with circular border containing an image
                                  Container(
                                    width: 180,
                                    height: 135,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/team.png'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  // Column containing three texts
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'خاندانی منصوبہ بندی',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.01),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Image.asset("assets/icons/book.png"),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '24 ماڈیولز',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.01),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            width: 5,
                                            height: 5,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Image.asset('name'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Image.asset("assets/icons/book.png"),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text("12 کوئز",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.01))
                                        ],
                                      ),
                                      SizedBox(height: 25),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'پیش رفت',
                                            style: TextStyle(
                                                color: Color(0xff7A7D84),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 80,
                                          ),
                                          Text(
                                            '${(0.6 * 100).toInt()}%', // The percentage value
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2),
                                      ProgressBar(
                                        width: 160.0,
                                        height: 6.0,
                                        value: 0.6, // 60%
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 30),
                                  child: Container(
                                    width: 340,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Color(0xffE5E5E5),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // 3D looking circle container
                                          Container(
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xffF4D6A9),
                                                  Color(0xffEAAF58)
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                            ),
                                          ),

                                          SizedBox(
                                            width: 20,
                                          ),

                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("کوئز 1 زیر التوا ہے۔ ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                RichText(
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: "آخری تاریخ: ",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors
                                                              .grey, // Set the color to gray
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: "25 جون 2023",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors
                                                              .black, // Set the color to black
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Icon button on the right
                                          InkWell(
                                            child:
                                                Icon(Icons.arrow_forward_ios),
                                            onTap: () {},
                                          ),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 15),
                                  child: Container(
                                    width: 340,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Color(0xffE5E5E5),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // 3D looking circle container
                                          Container(
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xffF4B9E1),
                                                  Color(0xffED8DCE)
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),

                                          SizedBox(
                                            width: 20,
                                          ),

                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("ماڈیولز مکمل ہو گئے۔ ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text("12"),
                                              ],
                                            ),
                                          ),
                                          // Icon button on the right
                                          InkWell(
                                            child:
                                                Icon(Icons.arrow_forward_ios),
                                            onTap: () {},
                                          ),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}
