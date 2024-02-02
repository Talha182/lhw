import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // Ensure GetX is added to your pubspec.yaml
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:lhw/BookmarkController.dart'; // Adjust the import path based on your project structure

class LessonOption20 extends StatefulWidget {
  const LessonOption20({Key? key}) : super(key: key);

  @override
  _LessonOption20State createState() => _LessonOption20State();
}

class _LessonOption20State extends State<LessonOption20> {
  int _current = 0;
  final int _totalSteps = 100;
  bool _isLastCardFlipped = false;

  // Assuming each card can be uniquely identified by an index or ID for bookmarking purposes
  final String bookmarkId = 'unique_identifier_for_the_lesson';

  final CarouselController _carouselController = CarouselController();

  // Instantiating the BookmarkController
  final BookmarkController bookmarkController = Get.put(BookmarkController());

  List<Map<String, dynamic>> cardData = [
    {
      'frontText': ' ٹی۔ بی کیا ہے؟',
      'backText': 'یہ مرض جرثومے، بیکٹیریا کی وجہ سے پھیلتا ہے، جو کہ جسم کے کسی بھی حصے میں رہ سکتا ہے۔',
    },
    {
      'frontText': ' جسم کے کس حصے کو متاثر کرتا ہے؟',
      'backText': 'اس سے جسم کے کئی حصے متاثر ہو سکتے ہیں مثلاً پھیپھڑے، آنتیں ، ہڈیاں ، جوڑ ، گردے وغیرہ,  تاہم پھیپھڑوں کی ٹی بی سب سے زیادہ عام ہے۔',
    },
    {
      'frontText': ' کس عمر کے لوگ زیادہ متاثر ہوتے ہیں؟',
      'backText': 'کسی بھی عمر کا فرد اس سے متاثر ہو سکتا ہے۔  پہلے حملے میں جب جراثیم جسم میں داخل ہوتے ہیں تو اکثر ان کا پتہ نہیں چلتا کیونکہ اس کی علامات بہت معمولی ہوتی ہیں۔  لیکن ایسے افراد جن کی قوت مدافعت کم ہو، وہ پہلے حملے میں ہی متاثر ہو سکتے ہیں۔ ',
    },
    // Add more cards as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0, -0.2),
            colors: [
              const Color(0xff80B8FB).withOpacity(0.5),
              Colors.transparent,
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (bookmarkController.isBookmarked(bookmarkId)) {
                        bookmarkController.removeBookmark(bookmarkId);
                      } else {
                        bookmarkController.addBookmark(bookmarkId);
                      }
                    },
                    child: Obx(() =>
                        Icon(
                          bookmarkController.isBookmarked(bookmarkId)
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          size: 30,
                        )),
                  ),
                  const Icon(
                    Icons.close,
                    size: 30,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(
                          begin: 0,
                          end: ((_current + 1) / cardData.length) *
                              _totalSteps),
                      duration: const Duration(milliseconds: 400),
                      builder: (BuildContext context, double value,
                          Widget? child) {
                        return LinearPercentIndicator(
                          lineHeight: 8.0,
                          percent: min(value / _totalSteps, 1.0),
                          backgroundColor: Colors.white,
                          progressColor: const Color(0xffFE8BD1),
                          barRadius: const Radius.circular(10),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, top: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(
                  'assets/images/cloud.svg',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'ٹی بی  اور اس کی علامات۔',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "UrduType", fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Transform.translate(
              offset: const Offset(-40, 0),
              child: CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: cardData.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return FlipCard(
                    onFlip: () {
                      setState(() {
                        _isLastCardFlipped = index == cardData.length - 1;
                      });
                    },
                    direction: FlipDirection.HORIZONTAL,
                    front: Container(
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color(0xffF07DB2),width: 2 )

                      ),
                      child: Center(
                        child: Text(
                          cardData[index]['frontText'], // Text to display on the front side
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 25,
                            fontFamily: "UrduType",
                            color: Colors.black, // Text color
                          ),
                        ),
                      ),
                    ),
                    back: Container(
                      width: 280,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Color(0xffF07DB2),width: 2 )

                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Center(
                          child: Text(
                            cardData[index]['backText'], // Text to display on the front side
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 25,
                              fontFamily: "UrduType",
                              color: Colors.black, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 420.0,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                  aspectRatio: 16 / 9,
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.78,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                cardData
                    .length,
                // Use the length of cardData for dynamic indicator count
                    (index) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? const Color(0xff9AC9C2)
                          : const Color(0xffeaedee),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 1,
              decoration: BoxDecoration(color: Colors.black87.withOpacity(0.1)),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.white, width: 2),
                backgroundColor:
                _isLastCardFlipped ? const Color(0xffFE8BD1) : Colors.grey,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(150, 37),
              ),
              onPressed: (){
              },
              // onPressed: _isLastCardFlipped
              //     ? () {
              //   // handle the button press logic here
              // }
              //     : null, // null disables the button
              child: const Text(
                'جاری رہے',
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
    );
  }

  void toggleBookmark(String id) {
    if (bookmarkController.isBookmarked(id)) {
      bookmarkController.removeBookmark(id);
    } else {
      bookmarkController.addBookmark(id);
    }
  }
}