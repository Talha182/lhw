import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lhw/Mobile_Module%20&%20Submodule/Course_dropdown%20open%20view.dart';
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: InkWell(
                  child: const Icon(Icons.arrow_back),
                  onTap: () {},
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 5.0),
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
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  child: const Icon(Icons.more_vert),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xff8E79FB), Color(0xffB09FFD)]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('نیوٹریشن کورس',
                            style: TextStyle(
                              fontFamily: 'UrduType',
                              color: Colors.white,
                              fontSize: 25,
                            )),
                        Row(
                          children: [
                            Text(
                              '${(progressValue * 100).toStringAsFixed(0)}%', // Displaying the progress as percentage
                              style: const TextStyle(
                                fontFamily: 'UrduType',
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            AnimatedProgressBar(
                              height: 5,
                              value: progressValue,
                              duration: const Duration(seconds: 2),
                              color: const Color(0xff9AC9C2),
                              backgroundColor: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
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
                        _feedbackButtonPressed
                            ? RatingBar.builder(
                                unratedColor: const Color(0xffC8CCFE),
                                initialRating: 0,
                                itemSize: 35,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Color(0xffF7DE8D),
                                ),
                                onRatingUpdate: (rating) {},
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.white, width: 2),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  minimumSize: const Size(140, 40),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _feedbackButtonPressed = true;
                                  });
                                },
                                child: const Text(
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
            const Text(
              'کورس کا مواد',
              style: TextStyle(fontFamily: 'UrduType', fontSize: 25),
              textAlign: TextAlign.right,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...rowPadded([
                  SvgPicture.asset('assets/images/module.svg'),
                  const Text(
                    '16 ماڈیولز',
                    style: TextStyle(
                        fontFamily: "UrduType",
                        color: Color(0xff7A7D84),
                        fontSize: 15),
                  ),
                  const Text(
                    '•',
                    style: TextStyle(
                        fontFamily: "UrduType",
                        color: Color(0xff232323),
                        fontSize: 18),
                  ),
                  SvgPicture.asset('assets/images/person_card.svg'),
                  const Text(
                    '12 کوئز',
                    style: TextStyle(
                        fontFamily: "UrduType",
                        color: Color(0xff7A7D84),
                        fontSize: 15),
                  ),
                  const Text(
                    '•',
                    style: TextStyle(
                        fontFamily: "UrduType",
                        color: Color(0xff232323),
                        fontSize: 18),
                  ),
                  const Text(
                    '5h 45m کل لمبائی',
                    style: TextStyle(
                        fontFamily: "UrduType",
                        color: Color(0xff7A7D84),
                        fontSize: 15),
                  )
                ], 4)
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent, // Background color
                    side: const BorderSide(
                      color: Colors.black, // Border color
                      width: 1,
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Circular radius
                    ),
                    minimumSize: const Size(200, 40),
                  ),
                  onPressed: () {
                    // Add your action here
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/download.svg'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
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
                    backgroundColor: const Color(0xffFE8BD1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Circular radius
                    ),
                    minimumSize: const Size(150, 40),
                  ),
                  onPressed: () {
                    // Add your action here
                  },
                  child: const Text(
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
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                ...columnPadded([
                  Module_DashBoard_Card(
                    onClick: () {
                      Get.to(() => const Course_DropDown());
                    },
                    progressValue: progressValue,
                    imagePath: 'assets/images/image 8.png',
                    cardText: 'غذائیت کا تعارف',
                    showProgressBar: false,
                  ),
                  Module_DashBoard_Card(
                    progressValue: progressValue,
                    imagePath: 'assets/images/image9.png',
                    cardText:
                        'نوعمر لڑکیوں، حاملہ اور دودھ پلانے والی ماؤں کی غذائی ضروریات',
                    showProgressBar: false,
                    onClick: () {},
                  ),
                  Module_DashBoard_Card(
                    onClick: () {},
                    progressValue: progressValue,
                    imagePath: 'assets/images/image10.png',
                    cardText: 'حمل کی غذائی ضروریات',
                    showProgressBar: false,
                  ),
                  Module_DashBoard_Card(
                    onClick: () {},
                    progressValue: progressValue,
                    imagePath: 'assets/images/image11.png',
                    cardText: 'آئرن کی کمی/انیمیا',
                    showProgressBar: false,
                  ),
                  Module_DashBoard_Card(
                    onClick: () {},
                    progressValue: progressValue,
                    imagePath: 'assets/images/image12.png',
                    cardText: 'وٹامن اے کی کمی',
                    showProgressBar: false,
                  ),
                  Module_DashBoard_Card(
                    onClick: () {},
                    progressValue: progressValue,
                    imagePath: 'assets/images/image13.png',
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
