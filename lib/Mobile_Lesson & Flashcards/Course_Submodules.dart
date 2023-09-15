import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../custom_widgets/Row_Column_Padding.dart';
import '../custom_widgets/progress_bar.dart';

class CourseSubModules extends StatelessWidget {
  const CourseSubModules({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(
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
                          GestureDetector(
                            child: const Icon(
                              Icons.arrow_back,
                              size: 25,
                            ),
                            onTap: () {},
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
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
                      padding: const EdgeInsets.only(right: 25, bottom: 6),
                      child: GestureDetector(
                        child: const Icon(Icons.more_vert),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  width: 400,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xff8E79FB), Color(0xffB09FFD)]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5),
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
                            ...rowPadded([
                              SvgPicture.asset(
                                'assets/images/module.svg',
                                color: Colors.white,
                              ),
                              const Text(
                                '24 ماڈیولز',
                                style: TextStyle(
                                    fontFamily: "UrduType",
                                    color: Colors.white,
                                    fontSize: 15),
                              ),
                              const Text(
                                '•',
                                style: TextStyle(
                                    fontFamily: "UrduType",
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                              SvgPicture.asset(
                                'assets/images/person_card.svg',
                                color: Colors.white,
                              ),
                              const Text(
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
                    'assets/images/module.png', // replace with your image name
                    width: 120, // Set your width
                    height: 120,
                    fit: BoxFit.contain, // Set your height
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'آپ کی پیشرفت',
                  style: TextStyle(
                      fontFamily: 'UrduType',
                      color: Color(0xff232323),
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                const SizedBox(
                  width: 100,
                ),
                Text('${(0.4 * 100).toInt()}%', // The percentage value
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 10),
            ProgressBar(
              width: 160.0,
              height: 6.0,
              value: 0.4, // 60%
            ),
            const SizedBox(height: 25),
            const Text(
              'غذائیت کا تعارف',
              style: TextStyle(
                  fontFamily: 'UrduType',
                  color: Color(0xff232323),
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...columnPadded([
                  Submodule_card(
                      imagePath: 'assets/images/check.svg',
                      heading: 'لیڈی ہیلتھ ورکر کے فرائض',
                      duration: '3 منٹ 2 سیکنڈ',
                      onTap: () {}, imageWidth: 22, imageHeight: 22,),
                  Submodule_card(
                      imagePath: 'assets/images/video.svg',
                      heading: 'بنیادی تعریف',
                      duration: '3 منٹ 2 سیکنڈ',
                      onTap: () {}, imageWidth: 22, imageHeight: 22,),
                  Submodule_card(
                      imagePath: 'assets/images/video.svg',
                      heading: 'پاکستان میں غذائیت کی صورتحال ',
                      duration: '3 منٹ 2 سیکنڈ',
                      onTap: () {}, imageWidth: 22, imageHeight: 22,),
                  Submodule_card(
                      imagePath: 'assets/images/person_card.svg',
                      heading: 'باب کوئز',
                      duration: '3 سوالات',
                      onTap: () {}, imageWidth: 18, imageHeight: 18,),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.black87.withOpacity(0.1),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'نوعمر لڑکیوں، حاملہ اور دودھ پلانے والی ماؤں کی غذائی ضروریات',
                      style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                    ),
                  ),
                  Submodule_card(
                      imagePath: 'assets/images/video.svg',
                      heading: 'لیڈی ہیلتھ ورکر کے فرائض',
                      duration: '3 منٹ 2 سیکنڈ',
                      onTap: () {}, imageWidth: 22, imageHeight: 22,),
                  Submodule_card(
                      imagePath: 'assets/images/video.svg',
                      heading: 'بنیادی تعریف',
                      duration: '3 منٹ 2 سیکنڈ',
                      onTap: () {}, imageWidth: 22, imageHeight: 22,),
                  Submodule_card(
                      imagePath: 'assets/images/video.svg',
                      heading: 'پاکستان میں غذائیت کی صورتحال ',
                      duration: '3 منٹ 2 سیکنڈ',
                      onTap: () {}, imageHeight: 22, imageWidth: 22,),
                  Submodule_card(
                      imagePath: 'assets/images/video2.svg',
                      heading: 'باب کوئز',
                      duration: '3 سوالات',
                      onTap: () {}, imageWidth: 20, imageHeight: 20,),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.black87.withOpacity(0.1),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'حمل کی غذائی ضروریات',
                      style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                    ),
                  ),
                  Submodule_card(
                      imagePath: 'assets/images/video.svg',
                      heading: 'لیڈی ہیلتھ ورکر کے فرائض',
                      duration: '3 منٹ 2 سیکنڈ',
                      onTap: () {}, imageWidth: 22, imageHeight: 22,),
                  Submodule_card(
                      imagePath: 'assets/images/video.svg',
                      heading: 'بنیادی تعریف',
                      duration: '3 منٹ 2 سیکنڈ',
                      onTap: () {}, imageWidth: 22, imageHeight: 22,),
                  Submodule_card(
                      imagePath: 'assets/images/video.svg',
                      heading: 'پاکستان میں غذائیت کی صورتحال ',
                      duration: '3 منٹ 2 سیکنڈ',
                      onTap: () {}, imageWidth: 22, imageHeight: 22,),
                  Submodule_card(
                    imagePath: 'assets/images/person_card.svg',
                    heading: 'باب کوئز',
                    duration: '3 سوالات',
                    onTap: () {}, imageWidth: 20, imageHeight: 20,
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
  final double imageWidth;
  final double imageHeight;
  final String duration;
  final Function onTap;

  //Constructor
  const Submodule_card(
      {super.key, required this.imagePath,
      required this.heading,
      required this.duration,
      required this.onTap, required this.imageWidth, required this.imageHeight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap;
      },
      child: Container(
        width: 400,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              SvgPicture.asset(
                imagePath,
                fit: BoxFit.contain,
                height: imageHeight,
                width: imageWidth,
              ),
              const SizedBox(
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      heading,
                      style: const TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 15,
                          color: Color(0xff685F78)),
                    ),
                    Text(
                      duration,
                      style: const TextStyle(
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
