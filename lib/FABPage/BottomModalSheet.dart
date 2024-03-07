import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhw/Profile/profile_screen.dart';
import 'package:lhw/Reports/help_screen.dart';

class CustomBottomModalSheet extends StatelessWidget {
  const CustomBottomModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: [
          const SizedBox(height: 12),
          const Text('مزید خدمات',
              style: TextStyle(fontFamily: "UrduType", fontSize: 22)),
          const SizedBox(height: 12.0),
          // First Row
          Row(
            children: [
              _buildContainer(
                  flex: 3,
                  colors: [const Color(0xffF4D6A9), const Color(0xffEAAF58)],
                  firstText: 'سیٹنگز',
                  secondText: 'اپنی سیٹنگز اور دیگر اشیا دیکھیں',
                  imageName: 'assets/images/calender.png',
                  onTap: () {}),
              _buildContainer(
                  flex: 2,
                  colors: [const Color(0xffDCEFDE), const Color(0xff81C588)],
                  firstText: 'ذاتی معلومات',
                  secondText: 'اپنی ذاتی معلومات دیکھیں',
                  imageName: 'assets/images/profile.png',
                  onTap: () {
                    Get.to(() => const ProfileScreen());
                  }),
            ],
          ),
          // Second Row
          Row(
            children: [
              _buildContainer(
                  flex: 2,
                  colors: [const Color(0xffF4B9E1), const Color(0xffED8DCE)],
                  firstText: 'مدد',
                  secondText: 'کسی بھی قسم کی مدد حاصل کریں',
                  imageName: 'assets/images/help.png',
                  onTap: () {
                    Get.to(() => const HelpScreen(),
                        transition: Transition.fade,
                        duration: const Duration(milliseconds: 300));
                  }),
              _buildContainer(
                  flex: 3,
                  colors: [const Color(0xffC8C0FC), const Color(0xffAB9FF9)],
                  firstText: 'وسائل',
                  secondText: 'اسباق کا مواد دیکھیں',
                  imageName: 'assets/images/BookOpen.png',
                  onTap: () {}),
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
    required VoidCallback onTap, // <-- Added this line
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: colors),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(firstText,
                            style: TextStyle(
                                fontFamily: 'UrduType',
                                fontSize: 16,
                                color: Color(0xff232323),
                                fontWeight: FontWeight.bold)), // Used textColor
                        const SizedBox(height: 2),
                        Text(secondText,
                            style: TextStyle(
                                fontFamily: 'UrduType',
                                color: Color(0xff7A7D84),
                                fontSize: 12)), // Used textColor
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 5,
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
        ),
      ),
    );
  }
}
