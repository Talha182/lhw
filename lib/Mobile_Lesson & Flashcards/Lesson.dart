import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lhw/Mobile_Module%20&%20Submodule/module_screen.dart';
import 'package:lhw/custom_widgets/Row_Column_Padding.dart';

import 'inforgraphics_carousel.dart';
import 'lesson_page_tabbar.dart';

class Lesson extends StatelessWidget {
  const Lesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Expanded(
                child: ListView(children: [
                  Stack(
                    children: [
                      Container(
                        width: Get.width,
                        height: 170,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0xff8E79FB), Color(0xffB09FFD)]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('نیوٹریشن کورس',
                                  style: TextStyle(
                                    fontFamily: 'UrduType',
                                    color: Colors.white,
                                    fontSize: 25,
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/module.svg',
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const Text(
                                    '24 ماڈیولز',
                                    style: TextStyle(
                                      fontFamily: 'UrduType',
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/module.svg',
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const Text(
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
                              const SizedBox(
                                height: 8,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(color: Colors.white, width: 2),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  minimumSize: const Size(150, 37),
                                ),
                                onPressed: () {},
                                child: const Text(
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
                        left  : 0,
                        child: Image.asset(
                          'assets/images/module.png', // replace with your image name
                          width: 180, // Set your width
                          height: 180,
                          fit: BoxFit.contain, // Set your height
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        color: const Color(0xffCAE1E5).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, left: 15),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                SizedBox(width: 15),
                                Text(
                                  "کورس کے ذیلی ماڈلز", // Updated this line
                                  style: TextStyle(fontFamily: 'UrduType', fontSize: 18),
                                ),
                              ],
                            ),
                            GestureDetector(
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                              ),
                              onTap: () {
                                Get.to(() => const ModulePage());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ImageCarousel(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'کورس کی تفصیل',
                    style: TextStyle(fontFamily: "UrduType", fontSize: 18),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ...rowPadded([
                        const Text(
                          '1h 34m',
                          style: TextStyle(
                              fontFamily: "UrduType",
                              color: Color(0xff232323),
                              fontSize: 18),
                        ),
                        const Text(
                          '•',
                          style: TextStyle(
                              fontFamily: "UrduType",
                              color: Color(0xff232323),
                              fontSize: 18),
                        ),
                        const Text(
                          '3/15/2023',
                          style: TextStyle(
                              fontFamily: "UrduType",
                              color: Color(0xff232323),
                              fontSize: 18),
                        ),
                        const Text(
                          'جاری کیا گیا:',
                          style: TextStyle(
                              fontFamily: "UrduType",
                              color: Color(0xff232323),
                              fontSize: 18),
                        ),
                        const Text(
                          '•',
                          style: TextStyle(
                              fontFamily: "UrduType",
                              color: Color(0xff232323),
                              fontSize: 18),
                        ),
                        const Text(
                          'ابتدائی',
                          style: TextStyle(
                              fontFamily: "UrduType",
                              color: Color(0xff232323),
                              fontSize: 18),
                        ),
                      ], 2)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ...rowPadded([
                        const Text(
                          '4/5',
                          style: TextStyle(fontSize: 20, fontFamily: "UrduType"),
                        ),
                        RatingBar.builder(
                          unratedColor: const Color(0xffD9D9D9),
                          initialRating: 4,
                          itemSize: 35,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Color(0xffF7DE8D),
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        const Text(
                          '(3770)',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "UrduType",
                          ),
                        ),
                      ], 3)
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "میرے جائزے میں ترمیم کریں۔",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontFamily: "UrduType", fontSize: 16, color: Color(0xffFE8BD1)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 1.0,
                    width: double.infinity,
                    color: Colors.black87.withOpacity(0.2),
                  ),
                  const SizedBox(height: 10,),
                  const Text("اس کورس سے متعلق",style: TextStyle(fontFamily: "UrduType",fontSize: 18),textAlign: TextAlign.right,),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ...rowPadded([
                        SvgPicture.asset('assets/images/doc.svg'),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            'ڈاؤن لوڈ کریں۔',
                            style: TextStyle(
                                fontFamily: "UrduType",
                                color: Color(0xffFE8BD1),
                                fontSize: 18),
                          ),
                        ),
                        const Text(
                          '•',
                          style: TextStyle(
                              fontFamily: "UrduType",
                              color: Color(0xff232323),
                              fontSize: 18),
                        ),
                        const Text(
                          'ابتدائی',
                          style: TextStyle(
                              fontFamily: "UrduType",
                              color: Color(0xff232323),
                              fontSize: 18),
                        ),
                      ], 2)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ...rowPadded([
                        SvgPicture.asset('assets/images/discussion.svg'),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            'ابھی شامل ہوں۔',
                            style: TextStyle(
                                fontFamily: "UrduType",
                                color: Color(0xffFE8BD1),
                                fontSize: 18),
                          ),
                        ),
                        const Text(
                          '•',
                          style: TextStyle(
                              fontFamily: "UrduType",
                              color: Color(0xff232323),
                              fontSize: 18),
                        ),
                        const Text(
                          'ڈسکشن گروپ میں شامل ہوں',
                          style: TextStyle(
                              fontFamily: "UrduType",
                              color: Color(0xff232323),
                              fontSize: 18),
                        ),
                      ], 2)
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ]),
              ),
            ),
            Positioned(
                bottom: 60, // Adjust as needed
                right: 15, // Adjust as needed
                child: CircleAvatar(
                  backgroundColor: Color(0xffF6B3D0),
                  radius: 30,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: SvgPicture.asset(
                        "assets/images/samina_instructor.svg",
                        fit: BoxFit.fill,
                      )),
                )),

          ],
        ));
  }
}
