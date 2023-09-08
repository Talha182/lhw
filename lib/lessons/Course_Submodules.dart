import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/Row_Column_Padding.dart';
import '../custom_widgets/progress_bar.dart';

class CourseSubModules extends StatelessWidget {
  const CourseSubModules({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: Row(
                        children: [
                          InkWell(
                            child: Icon(
                              Icons.arrow_back,
                              size: 25,
                            ),
                            onTap: () {},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "ماڈیول 1",
                            style: TextStyle(
                              fontFamily: 'UrduFont',
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 25, bottom: 6),
                      child: InkWell(
                        child: Icon(Icons.more_vert),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  width: 400,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff8E79FB), Color(0xffB09FFD)]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 5),
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
                            ...rowPadded([
                              Image.asset(
                                'assets/icons/book.png',
                                color: Colors.white,
                              ),
                              Text(
                                '24 ماڈیولز',
                                style: TextStyle(
                                    fontFamily: "UrduType",
                                    color: Colors.white,
                                    fontSize: 15),
                              ),
                              Text(
                                '•',
                                style: TextStyle(
                                    fontFamily: "UrduType",
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                              Image.asset(
                                'assets/icons/person_card.png',
                                color: Colors.white,
                              ),
                              Text(
                                '12 کوئز',
                                style: TextStyle(
                                    fontFamily: "UrduType",
                                    color: Colors.white,
                                    fontSize: 15),
                              ),
                            ], 3)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -15,
                  right: 0,
                  child: Image.asset(
                    'assets/icons/module.png', // replace with your image name
                    width: 120, // Set your width
                    height: 120,
                    fit: BoxFit.contain, // Set your height
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'آپ کی پیشرفت',
                  style: TextStyle(
                      fontFamily: 'UrduType',
                      color: Color(0xff232323),
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                SizedBox(
                  width: 100,
                ),
                Text('${(0.4 * 100).toInt()}%', // The percentage value
                    style: GoogleFonts.raleway(
                        fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 10),
            ProgressBar(
              width: 160.0,
              height: 6.0,
              value: 0.4, // 60%
            ),
            SizedBox(height: 25),
            Text(
              'غذائیت کا تعارف',
              style: TextStyle(
                  fontFamily: 'UrduType',
                  color: Color(0xff232323),
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...columnPadded([
                  Submodule_card(
                    imagePath: 'assets/icons/check.png',
                    heading: 'لیڈی ہیلتھ ورکر کے فرائض',
                    duration: '3 منٹ 2 سیکنڈ',onTap: (){}
                  ),
                  Submodule_card(
                    imagePath: 'assets/icons/video.png',
                    heading: 'بنیادی تعریف',
                    duration: '3 منٹ 2 سیکنڈ',onTap: (){}
                  ),
                  Submodule_card(
                    imagePath: 'assets/icons/video.png',
                    heading: 'پاکستان میں غذائیت کی صورتحال ',
                    duration: '3 منٹ 2 سیکنڈ',onTap: (){}
                  ),
                  Submodule_card(
                    imagePath: 'assets/icons/person_card.png',
                    heading: 'باب کوئز',
                    duration: '3 سوالات',onTap: (){}
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.black87.withOpacity(0.1),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'نوعمر لڑکیوں، حاملہ اور دودھ پلانے والی ماؤں کی غذائی ضروریات',
                      style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                    ),
                  ),
                  Submodule_card(
                    imagePath: 'assets/icons/video.png',
                    heading: 'لیڈی ہیلتھ ورکر کے فرائض',
                    duration: '3 منٹ 2 سیکنڈ',onTap: (){}
                  ),
                  Submodule_card(
                    imagePath: 'assets/icons/video.png',
                    heading: 'بنیادی تعریف',
                    duration: '3 منٹ 2 سیکنڈ',onTap: (){}
                  ),
                  Submodule_card(
                    imagePath: 'assets/icons/video.png',
                    heading: 'پاکستان میں غذائیت کی صورتحال ',
                    duration: '3 منٹ 2 سیکنڈ',onTap: (){}
                  ),
                  Submodule_card(
                    imagePath: 'assets/icons/video2.png',
                    heading: 'باب کوئز',
                    duration: '3 سوالات',onTap: (){}
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.black87.withOpacity(0.1),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'حمل کی غذائی ضروریات',
                      style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                    ),
                  ),
                  Submodule_card(
                    imagePath: 'assets/icons/video.png',
                    heading: 'لیڈی ہیلتھ ورکر کے فرائض',
                    duration: '3 منٹ 2 سیکنڈ',onTap: (){}
                  ),
                  Submodule_card(
                    imagePath: 'assets/icons/video.png',
                    heading: 'بنیادی تعریف',
                    duration: '3 منٹ 2 سیکنڈ',onTap: (){}
                  ),
                  Submodule_card(
                    imagePath: 'assets/icons/video.png',
                    heading: 'پاکستان میں غذائیت کی صورتحال ',
                    duration: '3 منٹ 2 سیکنڈ',onTap: (){}
                  ),
                  Submodule_card(
                    imagePath: 'assets/icons/person_card.png',
                    heading: 'باب کوئز',
                    duration: '3 سوالات', onTap: (){},
                  ),
                ], 7)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Submodule_card extends StatelessWidget {
  final String imagePath;
  final String heading;
  final String duration;
  final Function onTap;

  //Constructor
  Submodule_card(
      {required this.imagePath, required this.heading, required this.duration, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap;
      },
      child: Container(
        width: 400,
        height: 70,
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.contain,
                height: 22,
                width: 22,
              ),
              SizedBox(
                width: 15,
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      heading,
                      style: TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 15,
                          color: Color(0xff685F78)),
                    ),
                    Text(
                      duration,
                      style: TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 15,
                          color: Color(0xff929293)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
