import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

import '../custom_widgets/Row_Column_Padding.dart';
import 'module_dashboard_card.dart';

class ModulePage extends StatefulWidget {
  const ModulePage({super.key});

  @override
  State<ModulePage> createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  bool _feedbackButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    double progressValue = 0.4; // Example variable to hold progress value

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: InkWell(
                    child: Icon(Icons.arrow_back),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "ڈیش بورڈ",
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: InkWell(
                    child: Icon(Icons.more_vert),
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
            Stack(
              children: [
                Container(
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff8E79FB), Color(0xffB09FFD)]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('نیوٹریشن کورس',
                            style: TextStyle(
                              fontFamily: 'UrduType',
                              color: Colors.white,
                              fontSize: 25,
                            )),
                        Row(
                          children: [
                            Text(
                              '${(progressValue * 100).toStringAsFixed(0)}%', // Displaying the progress as percentage
                              style: TextStyle(
                                fontFamily: 'UrduType',
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            AnimatedProgressBar(
                              height: 5,
                              value: progressValue,
                              duration: const Duration(seconds: 2),
                              color: Color(0xff9AC9C2),
                              backgroundColor: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/book.png',
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              '24 ماڈیولز',
                              style: TextStyle(
                                fontFamily: 'UrduType',
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Image.asset(
                              'assets/icons/book.png',
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              '12 کوئز',
                              style: TextStyle(
                                fontFamily: 'UrduType',
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        _feedbackButtonPressed
                            ? RatingBar.builder(
                          unratedColor: Color(0xffC8CCFE),
                          initialRating: 0,
                          itemSize: 35,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Color(0xffF7DE8D),
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  side:
                                      BorderSide(color: Colors.white, width: 2),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  minimumSize: Size(140, 40),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _feedbackButtonPressed = true;
                                  });
                                },
                                child: Text(
                                  'فیڈ بیک فراہم کریں۔',
                                  style: TextStyle(
                                    fontFamily: 'UrduType',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -15,
                  right: 0,
                  child: Image.asset(
                    'assets/icons/module.png', // replace with your image name
                    width: 180, // Set your width
                    height: 180,
                    fit: BoxFit.contain, // Set your height
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'کورس کا مواد',
              style: TextStyle(fontFamily: 'UrduType', fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                ...rowPadded([
                  Image.asset('assets/icons/book.png'),
                  Text(
                    '16 ماڈیولز',
                    style: TextStyle(
                        fontFamily: "UrduType",
                        color: Color(0xff7A7D84),
                        fontSize: 15),
                  ),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black87),
                  ),
                  Image.asset('assets/icons/person_card.png'),
                  Text(
                    '12 کوئز',
                    style: TextStyle(
                        fontFamily: "UrduType",
                        color: Color(0xff7A7D84),
                        fontSize: 15),
                  ),
                  Text(
                    '•',
                    style: TextStyle(
                        fontFamily: "UrduType",
                        color: Color(0xff232323),
                        fontSize: 18),
                  ),

                  Text(
                    '5h 45m کل لمبائی',
                    style: TextStyle(
                        fontFamily: "UrduType",
                        color: Color(0xff7A7D84),
                        fontSize: 15),
                  )
                ], 4)
              ],
            ),
            SizedBox(
              height: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent, // Background color
                    side: BorderSide(
                      color: Colors.black, // Border color
                      width: 1,
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Circular radius
                    ),
                    minimumSize: Size(200, 40),
                  ),
                  onPressed: () {
                    // Add your action here
                  },
                  child: Row(
                    children: [
                      Image.asset('assets/icons/download.png'),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'مواد ڈاؤن لوڈ کریں۔',
                        style: TextStyle(
                            fontFamily: "UrduType",
                            color: Colors.black,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFE8BD1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Circular radius
                    ),
                    minimumSize: Size(150, 40),
                  ),
                  onPressed: () {
                    // Add your action here
                  },
                  child: Text(
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
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                ...columnPadded([
                  Module_DashBoard_Card(
                    progressValue: progressValue,
                    imagePath: 'assets/icons/image 8.png',
                    cardText: 'غذائیت کا تعارف',
                    showProgressBar: true,
                  ),
                  Module_DashBoard_Card(
                    progressValue: progressValue,
                    imagePath: 'assets/icons/image9.png',
                    cardText:
                        'نوعمر لڑکیوں، حاملہ اور دودھ پلانے والی ماؤں کی غذائی ضروریات',
                    showProgressBar: false,
                  ),
                  Module_DashBoard_Card(
                    progressValue: progressValue,
                    imagePath: 'assets/icons/image10.png',
                    cardText: 'حمل کی غذائی ضروریات',
                    showProgressBar: false,
                  ),
                  Module_DashBoard_Card(
                    progressValue: progressValue,
                    imagePath: 'assets/icons/image11.png',
                    cardText: 'آئرن کی کمی/انیمیا',
                    showProgressBar: false,
                  ),
                  Module_DashBoard_Card(
                    progressValue: progressValue,
                    imagePath: 'assets/icons/image12.png',
                    cardText: 'وٹامن اے کی کمی',
                    showProgressBar: false,
                  ),
                  Module_DashBoard_Card(
                    progressValue: progressValue,
                    imagePath: 'assets/icons/image13.png',
                    cardText: 'آیوڈین کی کمی',
                    showProgressBar: false,
                  ),
                ], 8)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

