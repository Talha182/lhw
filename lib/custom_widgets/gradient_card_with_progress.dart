import 'package:flutter/material.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';

class GradientCardWithProgress extends StatelessWidget {
  final double progressValue;
  final String imagePath;
  final Color gradientStartColor;
  final Color gradientEndColor;

  GradientCardWithProgress({
    required this.progressValue,
    required this.imagePath,
    required this.gradientStartColor,
    required this.gradientEndColor,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [gradientStartColor, gradientEndColor],

        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 45,
                  child: CircleProgressBar(
                    strokeWidth: 3.0,
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xffE6D0B0),
                    value: progressValue,
                    child: Center(
                      child: Text(
                        '${(progressValue * 100).toStringAsFixed(0)}%',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'بعدازپیدائشکید یکھ بھال',
                  style: TextStyle(
                    fontFamily: 'UrduType',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 4,
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
                    primary: Color(0xffF5DAB2),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(140, 40),
                  ),
                  onPressed: () {},
                  child: Text(
                    'جاری رہے',
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -26,
            right: 0,
            child: Image.asset(
              imagePath,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
