import 'package:flutter/material.dart';

class CustomBottomModalSheet extends StatelessWidget {
  const CustomBottomModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: [
          SizedBox(height: 35),
          Text('مزید خدمات', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 15.0),
          // First Row
          Row(
            children: [
              _buildContainer(
                  flex: 3,
                  colors: [Color(0xffF4D6A9), Color(0xffEAAF58)],
                  firstText: 'کیلنڈر',
                  secondText: 'اپنا کیلنڈر اور میٹنگ چیک کریں۔',
                  imageName: 'assets/icons/calender.png',
                  textColor: Colors.black87),
              _buildContainer(
                  flex: 2,
                  colors: [Color(0xffDCEFDE), Color(0xff81C588)],
                  firstText: 'پروفائل',
                  secondText: 'اپنا پروفائل چیک کریں۔',
                  imageName: 'assets/icons/profile.png',
                  textColor: Colors.black87),
            ],
          ),
          // Second Row
          Row(
            children: [
              _buildContainer(
                  flex: 1,
                  colors: [Color(0xffF4B9E1), Color(0xffED8DCE)],
                  firstText: 'مدد',
                  secondText: 'امدادی مرکز دیکھیں',
                  imageName: 'assets/icons/help.png',
                  textColor: Colors.black87),
              _buildContainer(
                  flex: 2,
                  colors: [Color(0xffC8C0FC), Color(0xffAB9FF9)],
                  firstText: 'حوالہ جات',
                  secondText: 'اپنا کیلنڈر اور میٹنگ چیک کریں۔',
                  imageName: 'assets/icons/BookOpen.png',
                  textColor: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Expanded _buildContainer({
    required int flex,
    required List<Color> colors,
    required String firstText,
    required String secondText,
    required String imageName,
    required Color textColor, // Added textColor parameter
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(firstText,
                        style: TextStyle(
                          fontFamily: 'UrduType',
                            color: textColor,
                            fontWeight: FontWeight.bold)), // Used textColor
                    SizedBox(height: 2),
                    Text(secondText,
                        style: TextStyle(
                            fontFamily: 'UrduType',

                            color: textColor, fontSize: 12)), // Used textColor
                  ],
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Image.asset(
                  imageName,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
