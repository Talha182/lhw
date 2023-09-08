import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lhw/custom_widgets/Row_Column_Padding.dart';
import 'package:lhw/lessons/inforgraphics_carousel.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

class Jaiza extends StatelessWidget {
  const Jaiza({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(10),
      child: ListView(children: [
        Stack(
          children: [
            Container(
              width: 400,
              height: 170,
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.white, width: 2),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: Size(150, 37),
                      ),
                      onPressed: () {},
                      child: Text(
                        'سیکھنا شروع کریں۔',
                        style: TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 15,
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
        Container(
          width: 400,
          height: 55,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              color: Color(0xffCAE1E5).withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      "کورس کے ذیلی ماڈلز", // Updated this line
                      style: TextStyle(fontFamily: 'UrduType', fontSize: 18),
                    ),
                  ],
                ),
                InkWell(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ImageCarousel(),
        SizedBox(
          height: 20,
        ),
        Text(
          'کورس کی تفصیل',
          style: TextStyle(fontFamily: "UrduType", fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            ...rowPadded([
              Text(
                '1h 34m',
                style: TextStyle(
                    fontFamily: "UrduType",
                    color: Color(0xff232323),
                    fontSize: 18),
              ),
              Text(
                '•',
                style: TextStyle(
                    fontFamily: "UrduType",
                    color: Color(0xff232323),
                    fontSize: 18),
              ),
              Text(
                '3/15/2023',
                style: TextStyle(
                    fontFamily: "UrduType",
                    color: Color(0xff232323),
                    fontSize: 18),
              ),
              Text(
                'جاری کیا گیا:',
                style: TextStyle(
                    fontFamily: "UrduType",
                    color: Color(0xff232323),
                    fontSize: 18),
              ),
              Text(
                '•',
                style: TextStyle(
                    fontFamily: "UrduType",
                    color: Color(0xff232323),
                    fontSize: 18),
              ),
              Text(
                'ابتدائی',
                style: TextStyle(
                    fontFamily: "UrduType",
                    color: Color(0xff232323),
                    fontSize: 18),
              ),
            ], 2)
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            ...rowPadded([
              Text(
                '4/5',
                style: GoogleFonts.raleway(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
              RatingBar.builder(
                unratedColor: Color(0xffD9D9D9),
                initialRating: 1,
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
              ),
              Text(
                '(3770)',
                style: GoogleFonts.raleway(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ], 3)
          ],
        ),
        SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () {},
          child: Text(
            "میرے جائزے میں ترمیم کریں۔",
            style: TextStyle(
                fontFamily: "UrduType", fontSize: 16, color: Color(0xffFE8BD1)),
          ),
        ),
        SizedBox(height: 20,),
        Container(
          height: 1.0,
          width: double.infinity,
          color: Colors.black87.withOpacity(0.2),
        ),
        SizedBox(height: 20,),

        Row(
          children: [
            ...rowPadded([
              Image.asset('assets/icons/doc.png'),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){},
                child: Text(
                  'ڈاؤن لوڈ کریں۔',
                  style: TextStyle(
                      fontFamily: "UrduType",
                      color: Color(0xffFE8BD1),
                      fontSize: 18),
                ),
              ),
              Text(
                '•',
                style: TextStyle(
                    fontFamily: "UrduType",
                    color: Color(0xff232323),
                    fontSize: 18),
              ),
              Text(
                'ابتدائی',
                style: TextStyle(
                    fontFamily: "UrduType",
                    color: Color(0xff232323),
                    fontSize: 18),
              ),
            ], 2)
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            ...rowPadded([
              Image.asset('assets/icons/discussion.png'),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){},
                child: Text(
                  'ابھی شامل ہوں۔',
                  style: TextStyle(
                      fontFamily: "UrduType",
                      color: Color(0xffFE8BD1),
                      fontSize: 18),
                ),
              ),
              Text(
                '•',
                style: TextStyle(
                    fontFamily: "UrduType",
                    color: Color(0xff232323),
                    fontSize: 18),
              ),
              Text(
                'ڈسکشن گروپ میں شامل ہوں',
                style: TextStyle(
                    fontFamily: "UrduType",
                    color: Color(0xff232323),
                    fontSize: 18),
              ),
            ], 2)
          ],
        ),


        SizedBox(height: 50,),
      ]),
    ));
  }
}
