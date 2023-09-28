import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFEF1F9),
      body: Padding(
        padding: EdgeInsets.only(
          top: 80,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffFE8BD1)),
                      child: Center(
                        child: SvgPicture.asset("assets/images/cross.svg"),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "ایل ایچ ڈبلیو",
                      style: TextStyle(fontFamily: "UrduType", fontSize: 30),
                    )
                  ],
                )
              ],
            ),
            Positioned(
                bottom: -30,
                child: SvgPicture.asset("assets/images/splash_curve.svg")),
            Positioned(
                bottom: -30,
                child: SvgPicture.asset("assets/images/splash_bg.svg")),
            Positioned(
                bottom: -30,
                child: SvgPicture.asset("assets/images/splash_samina.svg")),
            Positioned(
                bottom: -30,
                right: 10,
                child: SvgPicture.asset("assets/images/splash_lady.svg")),
          ],
        ),
      ),
    );
  }
}