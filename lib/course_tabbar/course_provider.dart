import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhw/Branching/LessonOption21.dart';
import 'package:lhw/Branching/LessonOption24.dart';
import 'package:lhw/Branching/LessonOption33.dart';
import 'package:lhw/Comic_Strip/comic_strip.dart';
import 'package:lhw/Image_Hotspot/LessonOption26.dart';
import 'package:lhw/Mobile_Lesson%20&%20Flashcards/flash_cards_screen.dart';
import 'package:lhw/Presentation/Presentation.dart';
import 'package:lhw/Quiz/MCQ%204.dart';
import 'package:lhw/test/Features/InteractiveImage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Bookmarks.dart';
import '../Discussion_Group/DiscussionGroups.dart';
import '../JourneyMap.dart';
import '../Mobile_Lesson & Flashcards/Lesson.dart';
import '../Mobile_Lesson & Flashcards/inforgraphics_carousel.dart';
import '../Mobile_Module & Submodule/module_screen.dart';
import '../controllers/feature_navigation.dart';
import '../custom_widgets/Row_Column_Padding.dart';
import '../models/feature_tile_model.dart';
import '../models/module_model.dart';
import '../models/course_model.dart';
import '../models/submodule_model.dart';
import 'ModuleTest/ModuleScreenTest.dart';

// course provider
class CoursesProvider with ChangeNotifier {
  final List<Course> _courses = [
    Course(
      courseId: 1,
      title: 'متعدی بیماریاں',
      gradient: const LinearGradient(colors: [Color(0xff89E4FE), Color(0xff18A3C8)]),
      quizCount: 12,
      moduleCount: 8,
      imagePath: 'assets/images/immunization-ico.png',
      isStart: true,
      modules: [
        Module(
          moduleId: 1,
          title: 'تعارف',
          imagePath: 'assets/moduleIcons/module1.png',
          isStart: false,
          progressValue: 0.5,

          submodules: [
            Submodule(
              submoduleID: 1,
              title: 'متعدی بیماریوں کا تعارف',
              description: 'اس سبق میں، آپ متعدی بیماریوں کے بارے میں سیکھیں گی، جو بیکٹیریا، وائرس، پھپھوندی، یا پیراسائٹ جیسے جانداروں کی وجہ سے ہونے والی بیماریاں ہیں. آپ جانیں گی کہ یہ بیماریاں کس طرح ایک شخص سے دوسرے شخص میں، کیڑے مکوڑوں یا جانوروں کے ذریعے، اور بعض اوقات آلودہ غذا یا پانی پینے سے پھیل سکتی ہیں۔',
              buttonPosition: const Offset(120, 520),
              iconPath: 'assets/images/tick.svg',

              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [
                FeatureCallback(
                  title: 'Lesson Option Video',
                  featureType: FeatureType.video,
                  callback: () => Get.to(() => const LessonOption33(videoPath: 'assets/videos/demo.mp4')),
                ),
              ],
            ),
            Submodule(
              submoduleID: 2,
              title: 'متعدی بیماریوں کی مثالیں۔',
              description: "یہ حصہ آپ کو متعدی بیماریوں کی مثالوں سے متعارف کرائے گا ، جس سے آپ کو ان کی علامات اور صحت پر اثرات کو پہچاننے میں مدد ملے گی۔ آپ نزلہ زکام ، ایچ آئی وی / ایڈز ، اور ملیریا جیسی بیماریوں کے بارے میں سیکھیں گی ، اور روک تھام کے اقدامات کی اہمیت کو سمجھیں گی۔",
              buttonPosition: const Offset(70, 200),
              iconPath: 'assets/images/book.svg',

              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [
                FeatureCallback(
                  title: 'Presentation on Infectious Diseases',
                  featureType: FeatureType.presentation,
                  callback: () => Get.to(() => const Presentation(
                    assetImages: [
                      'assets/presentations/presentation1.png',
                      'assets/presentations/presentation2.png',
                      'assets/presentations/presentation3.png',
                      'assets/presentations/presentation4.png',
                      'assets/presentations/presentation5.png',
                      'assets/presentations/presentation6.png',
                    ],
                  )),
                ),
              ],
            ),
          ],
          submoduleCount: 2,
        ),
        // Module(
        //   moduleId: 2,
        //   title: 'ٹی۔ بی',
        //   imagePath: 'assets/moduleIcons/module2.png',
        //   isStart: false,
        //   progressValue: 0.5,
        //   onTap: () {
        //     // Define navigation logic here, adjusted as per your framework's navigation system
        //   },
        //   submodules: [
        //     Submodule(
        //       submoduleID: 1,
        //       title: 'ٹی بی کے متعلق اہم معلومات',
        //       description:
        //           'یہاں، آپ ٹی بی کے بارے میں سیکھیں گی، جو ایک سنگین متعدی بیماری ہے۔ یہ بنیادی طور پر پھیپھڑوں کو متاثر کرتی ہے۔ اس سبق میں اس بات کا احاطہ کیا گیا ہے کہ ٹی بی ہوا کے ذریعے ایک شخص سے دوسرے شخص میں کیسے پھیلتی ہے اور ابتدائی تشخیص اور علاج کی اہمیت کیا ہے۔',
        //       buttonPosition: const Offset(50, 620), // Position for Submodule 1
        //
        //       iconPath: 'assets/images/tick.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const ComicStrip()),
        //         () => Get.off(() => const InteractiveImages()),
        //         () => Get.off(() => const FlashCardsScreen()),
        //       ],
        //       numberOfQuizzes: 1,
        //       titleAlignment: 'left',
        //     ),
        //     Submodule(
        //       submoduleID: 2,
        //       title: 'احتیاطی تدابیر اور غلط فہمیاں',
        //       description:
        //           'س سبق کا مقصد ٹی بی کے بارے میں عام غلط فہمیوں کو دور کرنا ہے اور آپ کو اس کے پھیلاؤ کو روکنے کے لئے احتیاطی تدابیر کے بارے میں تعلیم دینا ہے، جیسے ماسک پہننا اور رہنے کی جگہوں میں اچھی ہوا کی آمد و رفت کو یقینی بنانا۔',
        //       buttonPosition: const Offset(115, 370),
        //       iconPath: 'assets/images/book.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const LessonOption33(
        //             videoPath: 'assets/videos/demo.mp4')),
        //       ],
        //       numberOfQuizzes: 3,
        //       titleAlignment: 'left',
        //     ),
        //     Submodule(
        //       submoduleID: 3,
        //       title: 'ممکنہ مریض کی صورت میں اقدامات',
        //       description:
        //           'اگر آپ کسی ایسے شخص کا سامنا کرتی ہیں جسے ٹی بی ہوسکتا ہے تو آپ سیکھیں گی بشمول انہیں ٹیسٹ کروانے اور طبی دیکھ بھال حاصل کرنے کی ترغیب دینے کا طریقہ۔',
        //       buttonPosition: const Offset(0, 265),
        //       iconPath: 'assets/images/book.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const ComicStrip()),
        //         () => Get.off(() => const Presentation(
        //               assetImages: [
        //                 'assets/presentations/presentation1.png',
        //                 'assets/presentations/presentation2.png',
        //                 'assets/presentations/presentation3.png',
        //                 'assets/presentations/presentation4.png',
        //                 'assets/presentations/presentation5.png',
        //                 'assets/presentations/presentation6.png',
        //               ],
        //             )),
        //         () => Get.off(() => const LessonOption26()),
        //         () => Get.off(() => const InteractiveImages()),
        //         () => Get.off(() => const FlashCardsScreen()),
        //       ],
        //       numberOfQuizzes: 1,
        //       titleAlignment: 'right',
        //     ),
        //     Submodule(
        //       submoduleID: 4,
        //       title: 'علاج میں معاونت',
        //       description:
        //           'اس حصے میں اس بات پر تبادلہ خیال کیا گیا ہے کہ علاج کے دوران ٹی بی کے مریضوں کی مدد کیسے کی جائے، ادویات کی پابندی پر زور دیا جائے اور پیشرفت کی نگران ہیلتھ ورکر کے فرائض  پر زور دیا جائے۔',
        //       buttonPosition: const Offset(85, 150),
        //       iconPath: 'assets/images/book.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const ComicStrip()),
        //         () => Get.off(() => const LessonOption21()),
        //
        //         // () => Get.off(() => const LessonOption26()),
        //       ],
        //       numberOfQuizzes: 5,
        //       titleAlignment: 'left',
        //     ),
        //   ],
        //   submoduleCount: 4,
        // ),
        //
        // Module(
        //   moduleId: 3,
        //   title: 'جنسی بیماریاں',
        //   imagePath: 'assets/moduleIcons/module3.png',
        //   isStart: false,
        //   progressValue: 0.5,
        //   onTap: () {
        //     // Define navigation logic here, adjusted as per your framework's navigation system
        //   },
        //   submodules: [
        //     Submodule(
        //       submoduleID: 1,
        //       title: 'جنسی بیماریاں: تعریف، اقسام اور علامات',
        //       description:
        //           'اس سبق میں، آپ جنسی طور پر منتقل ہونے والی بیماریوں (ایس ٹی ڈیز) ، ان کی اقسام اور عام علامات کے بارے میں سیکھیں گی۔ اس میں ایس ٹی ڈی کی منتقلی اور محفوظ جنسی طریقوں اور باقاعدگی سے جانچ کی اہمیت کو بیان کیا گیا ہے۔',
        //       buttonPosition: const Offset(50, 520),
        //       iconPath: 'assets/images/tick.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const Presentation(
        //               assetImages: [
        //                 'assets/presentations/presentation1.png',
        //                 'assets/presentations/presentation2.png',
        //                 'assets/presentations/presentation3.png',
        //                 'assets/presentations/presentation4.png',
        //                 'assets/presentations/presentation5.png',
        //                 'assets/presentations/presentation6.png',
        //               ],
        //             )), // Navigate using
        //         () => Get.off(() => const LessonOption26()),
        //       ],
        //       numberOfQuizzes: 1,
        //       titleAlignment: 'left',
        //     ),
        //     Submodule(
        //       submoduleID: 2,
        //       title: 'جنسی بیماریوں کا علاج اور بچاو',
        //       description:
        //           "یہ سبق آپ کو ایس ٹی ڈی کے لئے دستیاب علاج اور ان کی منتقلی کو روکنے کے طریقوں کے بارے میں رہنمائی کرے گا. یہ ایس ٹی ڈی کی روک تھام میں تعلیم، کنڈوم کے استعمال اور ویکسینیشن  کے کردار پر زور دیتا ہے۔",
        //       buttonPosition: const Offset(60, 200),
        //       iconPath: 'assets/images/book.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const ComicStrip()),
        //       ],
        //       numberOfQuizzes: 1,
        //       titleAlignment: 'left',
        //     ),
        //   ],
        //   submoduleCount: 2,
        // ),
        //
        // Module(
        //   moduleId: 4,
        //   title: 'یچ آئی وی',
        //   imagePath: 'assets/moduleIcons/module4.png',
        //   isStart: false,
        //   progressValue: 0.5,
        //   onTap: () {
        //     // Define navigation logic here, adjusted as per your framework's navigation system
        //   },
        //   submodules: [
        //     Submodule(
        //       submoduleID: 1,
        //       title: 'ایچ آئی وی / ایڈز کی منتقلی اور علامات',
        //       description:
        //           'اس سبق میں، آپ ایچ آئی وی / ایڈز کے بارے میں مزید  سیکھیں گی۔ اس بات پر توجہ دی جاۓ گی کہ وائرس لوگوں کے درمیان یہ بماری  کیسے منتقل ہوتی  ہے اور متاثرہ افراد میں ظاہر ہونے والی علامات  کیا ہیں۔ روک تھام اور جلد تشخیص کے لئے ان پہلوؤں کو سمجھنا بہت ضروری ہے۔',
        //       buttonPosition: const Offset(50, 520),
        //       iconPath: 'assets/images/tick.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const LessonOption33(
        //             videoPath: 'assets/videos/demo.mp4')),
        //         () => Get.off(() => const Presentation(
        //               assetImages: [
        //                 'assets/presentations/presentation1.png',
        //                 'assets/presentations/presentation2.png',
        //                 'assets/presentations/presentation3.png',
        //                 'assets/presentations/presentation4.png',
        //                 'assets/presentations/presentation5.png',
        //                 'assets/presentations/presentation6.png',
        //               ],
        //             )),
        //       ],
        //       numberOfQuizzes: 1,
        //       titleAlignment: 'left',
        //     ),
        //     Submodule(
        //       submoduleID: 2,
        //       title: 'ایچ آئی وی / ایڈز کے ٹیسٹ، علاج اور\n افواہیں',
        //       description:
        //           "یہ حصہ ایچ آئی وی کی جانچ کی اہمیت پر توجہ دے گا، دستیاب علاج اور ایچ آئی وی / ایڈز سے متعلق عام خرافات کو دور کرے گا۔ اس سبق میں ہم متاثرہ افراد کے لئے درست معلومات اور ہمدردانہ دیکھ بھال کی ضرورت سیکھیں گے۔",
        //       buttonPosition: const Offset(20, 200),
        //       iconPath: 'assets/images/book.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const LessonOption33(
        //             videoPath: 'assets/videos/demo.mp4')),
        //         () => Get.off(() => const Presentation(
        //               assetImages: [
        //                 'assets/presentations/presentation1.png',
        //                 'assets/presentations/presentation2.png',
        //                 'assets/presentations/presentation3.png',
        //                 'assets/presentations/presentation4.png',
        //                 'assets/presentations/presentation5.png',
        //                 'assets/presentations/presentation6.png',
        //               ],
        //             )),
        //       ],
        //       numberOfQuizzes: 1,
        //       titleAlignment: 'left',
        //     ),
        //   ],
        //   submoduleCount: 2,
        // ),
        //
        // Module(
        //   moduleId: 5,
        //   title: 'ہیپاٹائٹس',
        //   imagePath: 'assets/moduleIcons/module5.png',
        //   isStart: false,
        //   progressValue: 0.5,
        //   onTap: () {
        //     // Define navigation logic here, adjusted as per your framework's navigation system
        //   },
        //   submodules: [
        //     Submodule(
        //       submoduleID: 1,
        //       title: 'ہیپاٹائٹس: وجوہات، پھیلاؤ اور علامات',
        //       description:
        //           'یہاں، آپ ہیپاٹائٹس کے بارے میں پڑھیں گی۔ یہ جگر کی سوزش ہوتی ہے جو مختلف وائرسوں کی وجہ سے ہوتی ہے. آپ اس بارے میں سیکھیں گے کہ یہ وائرس کیسے پھیلتے ہیں، ہیپاٹائٹس کی علامات، اور بیماری کا جلد پتہ لگانا اور اس کا علاج کرنا کیوں ضروری ہے۔',
        //       buttonPosition: const Offset(55, 520),
        //       iconPath: 'assets/images/tick.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const Presentation(
        //               assetImages: [
        //                 'assets/presentations/presentation1.png',
        //                 'assets/presentations/presentation2.png',
        //                 'assets/presentations/presentation3.png',
        //                 'assets/presentations/presentation4.png',
        //                 'assets/presentations/presentation5.png',
        //                 'assets/presentations/presentation6.png',
        //               ],
        //             )),
        //         () => Get.off(() => const LessonOption26()),
        //       ],
        //       numberOfQuizzes: 1,
        //       titleAlignment: 'left',
        //     ),
        //     Submodule(
        //       submoduleID: 2,
        //       title: 'ہیپاٹائٹس کی تشخیص، علاج اور روک تھام',
        //       description:
        //           'یہ سبق آپ کو ہیپاٹائٹس کی تشخیص، بیماری کے انتظام کے لئے دستیاب علاج، اور احتیاط کے طریقوں اور ویکسینیشن سمیت مؤثر روک تھام کی حکمت عملی کے بارے میں رہنمائی کرے گا۔',
        //       buttonPosition: const Offset(0, 200),
        //       iconPath: 'assets/images/book.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const FlashCardsScreen()),
        //         () => Get.off(() => const LessonOption26()),
        //       ],
        //       numberOfQuizzes: 1,
        //       titleAlignment: 'left',
        //     ),
        //   ],
        //   submoduleCount: 2,
        // ),
        //
        // Module(
        //   moduleId: 6,
        //   title: 'ملیریا',
        //   imagePath: 'assets/moduleIcons/module6.png',
        //   isStart: false,
        //   progressValue: 0.5,
        //   onTap: () {
        //     // Define navigation logic here, adjusted as per your framework's navigation system
        //   },
        //   submodules: [
        //     Submodule(
        //       submoduleID: 1,
        //       title: 'ملیریا کے اسباب، پھیلاؤ اور علامات',
        //       description:
        //           'اس سبق میں، آپ ملیریا کے بارے میں سیکھیں گی، جو مچھروں سے پھیلنے والی بیماری ہے۔ یہ انسانوں میں کیسے منتقل ہوتا ہے، دیکھنے کے لئے علامات، اور بیماری کی روک تھام میں مچھروں پر قابو پانے کی اہمیت پر توجہ دی گئ ہے۔',
        //       buttonPosition: const Offset(65, 520),
        //       iconPath: 'assets/images/tick.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const Presentation(
        //               assetImages: [
        //                 'assets/presentations/presentation1.png',
        //                 'assets/presentations/presentation2.png',
        //                 'assets/presentations/presentation3.png',
        //                 'assets/presentations/presentation4.png',
        //                 'assets/presentations/presentation5.png',
        //                 'assets/presentations/presentation6.png',
        //               ],
        //             )),
        //         () => Get.off(() => const InteractiveImages()),
        //         () => Get.off(() => const FlashCardsScreen()),
        //       ],
        //       numberOfQuizzes: 1,
        //       titleAlignment: 'left',
        //     ),
        //     Submodule(
        //       submoduleID: 2,
        //       title: 'ملیریا کی تشخیص، علاج اور روک تھام',
        //       description:
        //           'اس حصے میں ملیریا کی تشخیص کیسے کی جاتی ہے، علاج  اور مچھروں کے کاٹنے سے بچنے کے لئے مچھر دانیوں اور کیڑوں کو روکنے والی ادویات کا استعمال جیسے احتیاطی اقدامات پر تبادلہ خیال کیا گیا ہے۔',
        //       buttonPosition: const Offset(30, 200),
        //       iconPath: 'assets/images/book.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const Presentation(
        //               assetImages: [
        //                 'assets/presentations/presentation1.png',
        //                 'assets/presentations/presentation2.png',
        //                 'assets/presentations/presentation3.png',
        //                 'assets/presentations/presentation4.png',
        //                 'assets/presentations/presentation5.png',
        //                 'assets/presentations/presentation6.png',
        //               ],
        //             )),
        //         () => Get.off(() => const InteractiveImages()),
        //       ],
        //       numberOfQuizzes: 1,
        //       titleAlignment: 'left',
        //     ),
        //   ],
        //   submoduleCount: 2,
        // ),
        // Module(
        //   moduleId: 7,
        //   title: 'ڈینگی',
        //   imagePath: 'assets/moduleIcons/module7.png',
        //   isStart: false,
        //   progressValue: 0.5,
        //   onTap: () {
        //     // Define navigation logic here, adjusted as per your framework's navigation system
        //   },
        //   submodules: [
        //     Submodule(
        //       submoduleID: 1,
        //       title: 'ڈینگی اور اس کا پھیلاؤ',
        //       description:
        //           'آپ ڈینگی کے بارے میں سیکھیں گی، جو مچھروں کے ذریعے پھیلنے والا وائرل انفیکشن ہے۔ یہ سبق اس بات پر توجہ دیتا ہے کہ ڈینگی کیسے پھیلتا ہے، وہ حالات جو اس کے پھیلاؤ کو بڑھاتے ہیں، اور مچھروں کی افزائش کے مقامات کو کم کرنے کے لئے کھڑے پانی کو ختم کرنے کی اہمیت۔',
        //       buttonPosition: const Offset(130, 520),
        //       iconPath: 'assets/images/tick.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const LessonOption33(
        //             videoPath: 'assets/videos/demo.mp4')),
        //         () => Get.off(() => const Presentation(
        //               assetImages: [
        //                 'assets/presentations/presentation1.png',
        //                 'assets/presentations/presentation2.png',
        //                 'assets/presentations/presentation3.png',
        //                 'assets/presentations/presentation4.png',
        //                 'assets/presentations/presentation5.png',
        //                 'assets/presentations/presentation6.png',
        //               ],
        //             )),
        //       ],
        //       numberOfQuizzes: 1,
        //       titleAlignment: 'left',
        //     ),
        //     Submodule(
        //       submoduleID: 2,
        //       title: 'ڈینگی کی علامات، تشخیص، علاج اور\n روک تھام',
        //       description:
        //           'اس سبق میں ڈینگی کی علامات، اس کی تشخیص، دستیاب علاج، اور ڈینگی کی روک تھام کے لئے جامع حکمت عملی بتائی گئی ہے۔  اس میں مچھروں کی آبادی کو کنٹرول کرنے کے لئے کمیونٹی کی کوششیں بھی شامل ہیں۔',
        //       buttonPosition: const Offset(40, 200),
        //       iconPath: 'assets/images/book.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const FlashCardsScreen()),
        //       ],
        //       numberOfQuizzes: 1,
        //       titleAlignment: 'left',
        //     ),
        //   ],
        //   submoduleCount: 2,
        // ),
        // Module(
        //   moduleId: 8,
        //   title: 'کرونا وائرس',
        //   imagePath: 'assets/moduleIcons/module8.png',
        //   isStart: false,
        //   progressValue: 0.5,
        //   onTap: () {
        //     // Define navigation logic here, adjusted as per your framework's navigation system
        //   },
        //   submodules: [
        //     Submodule(
        //       submoduleID: 1,
        //       title: 'کورونا کی منتقلی اور علامات',
        //       description:
        //           'اس سبق میں، آپ کورونا وائرس (کووڈ 19) کے بارے میں سیکھیں گے، بشمول یہ کہ یہ لوگوں کے درمیان کیسے منتقل ہوتا ہے اور متاثرہ افراد کو جو علامات کا سامنا کرنا پڑ سکتا ہے. یہ اس کے پھیلاؤ کو روکنے میں ماسک اور سماجی دوری کی اہمیت کو اجاگر کرتا ہے۔',
        //       buttonPosition: const Offset(110, 520),
        //       iconPath: 'assets/images/tick.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const LessonOption33(
        //             videoPath: 'assets/videos/demo.mp4')),
        //         () => Get.off(() => const InteractiveImages()),
        //         () => Get.off(() => const ComicStrip()),
        //       ],
        //       numberOfQuizzes: 1,
        //       titleAlignment: 'left',
        //     ),
        //     Submodule(
        //       submoduleID: 2,
        //       title: 'کورونا وائرس سے بچاؤ اور\n احتیاتی اقدامات',
        //       description:
        //           'یہ حصہ کورونا وائرس کی منتقلی کو روکنے، کووڈ 19 کے مریضوں کی دیکھ بھال اور ذہنی صحت کی مدد کے بارے میں رہنمائی فراہم کرتا ہے۔ اس میں غذائی تغذیہ کی مدد اور وائرس سے متعلق عام خرافات کو مسترد کرنے پر بھی توجہ دی گئی ہے۔',
        //       buttonPosition: const Offset(120, 330),
        //       iconPath: 'assets/images/book.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const Presentation(
        //               assetImages: [
        //                 'assets/presentations/presentation1.png',
        //                 'assets/presentations/presentation2.png',
        //                 'assets/presentations/presentation3.png',
        //                 'assets/presentations/presentation4.png',
        //                 'assets/presentations/presentation5.png',
        //                 'assets/presentations/presentation6.png',
        //               ],
        //             )),
        //         () => Get.off(() => const LessonOption33(
        //             videoPath: 'assets/videos/demo.mp4')),
        //         () => Get.off(() => const FlashCardsScreen()),
        //       ],
        //       numberOfQuizzes: 1,
        //       titleAlignment: 'right',
        //     ),
        //     Submodule(
        //       submoduleID: 3,
        //       title: 'کورونا کے مریض کی دیکھ بھال',
        //       description:
        //           'یہ سبق  کوویڈ 19 کے مریضوں کی مؤثر دیکھ بھال اور انتظام کے بارے میں اہم معلومات دیتا ہے ، جس میں حفاظتی اقدامات ، علاج کے پروٹوکول اور مریضوں کی فلاح و بہبود  پر توجہ شامل ہے ۔ یہ مواصلات، ہمدردانہ دیکھ بھال، اور صحت کی دیکھ بھال کی نئی حکمت عملیوں کو اپنانے کی اہمیت پر زور دیتا ہے۔',
        //       buttonPosition: const Offset(45, 200),
        //       iconPath: 'assets/images/book.svg',
        //       navigateToFeatureCallbacks: [
        //         () => Get.to(() => const InteractiveImages()),
        //         () => Get.off(() => const Presentation(
        //               assetImages: [
        //                 'assets/presentations/presentation1.png',
        //                 'assets/presentations/presentation2.png',
        //                 'assets/presentations/presentation3.png',
        //                 'assets/presentations/presentation4.png',
        //                 'assets/presentations/presentation5.png',
        //                 'assets/presentations/presentation6.png',
        //               ],
        //             )),
        //       ],
        //       numberOfQuizzes: 1,
        //       titleAlignment: 'left',
        //     ),
        //   ],
        //   submoduleCount: 2,
        // ),
        // You can define more modules here...
      ],
    ),
  ];

  List<Course> get courses => _courses;

  List<Course> get ongoingCourses =>
      _courses.where((course) => course.isStart).toList();

  List<Course> get completedCourses =>
      _courses.where((course) => course.isCompleted).toList();

  Course getCourseById(int courseId) {
    return _courses.firstWhere((course) => course.courseId == courseId);
  }

  Course? _lastVisitedCourse;
  bool _isLoading = true; // Add a loading flag

  Course? get lastVisitedCourse => _lastVisitedCourse;
  bool get isLoading => _isLoading; // Expose the loading flag

  CoursesProvider() {
    _loadLastVisitedCourse();
  }
  void setLastVisitedCourse(Course course) async {
    _lastVisitedCourse = course;
    notifyListeners(); // Notify listeners to rebuild the widgets that depend on this

    // Save the last visited course's ID to shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastVisitedCourseId', course.courseId);
  }

  Future<void> _loadLastVisitedCourse() async {
    final prefs = await SharedPreferences.getInstance();
    final lastVisitedCourseId = prefs.getInt('lastVisitedCourseId');

    if (lastVisitedCourseId != null) {
      _lastVisitedCourse = _courses.firstWhere(
          (course) => course.courseId == lastVisitedCourseId,
          orElse: () => null!);
    } else {
      _lastVisitedCourse = _courses.firstWhere((course) => course.courseId == 1,
          orElse: () => null!);
      await prefs.setInt('lastVisitedCourseId', 1);
    }
    _isLoading = false; // Update the loading flag
    notifyListeners();
  }
}


class LessonPageTabBar extends StatefulWidget {
  final Course course;
  const LessonPageTabBar({super.key, required this.course});

  @override
  State<LessonPageTabBar> createState() => _LessonPageTabBarState();
}

class _LessonPageTabBarState extends State<LessonPageTabBar> {
  final GlobalKey _tabBarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 2,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              automaticallyImplyLeading: false,
              elevation: 1.0,
              backgroundColor: Colors.white,
              flexibleSpace: Align(
                alignment: Alignment.bottomCenter,
                child: _appBar(),
              ),
            )),
        body: _tabBar(),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 10),
            child: Icon(Icons.more_vert_rounded)),
        Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 7),
          child: Row(
            children: [
              GestureDetector(
                child: const Text(
                  "ماڈیول 1",
                  style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                ),
                onTap: () {},
              ),
              const SizedBox(width: 10),
              GestureDetector(
                child: const Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tabBar() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              ButtonsTabBar(
                key: _tabBarKey,
                splashColor: Colors.transparent,
                height: 50,
                radius: 20,
                elevation: 1,
                contentPadding: const EdgeInsets.symmetric(horizontal: 42),
                backgroundColor: Colors.white,
                unselectedBackgroundColor: const Color(0xffF0F0F0),
                unselectedLabelStyle: const TextStyle(
                    fontFamily: 'UrduType',
                    color: Color(0xff685F78),
                    fontWeight: FontWeight.w600),
                labelStyle: const TextStyle(
                    fontFamily: 'UrduType',
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(text: "بک مارکس"),
                  Tab(text: "گروپس"),
                  Tab(text: "جائزہ"),
                ],
              ),
            ],
          ),
           Expanded(
            child: TabBarView(
              children: <Widget>[
                const BookmarkScreen(),
                const GroupsDiscussion(
                  showAppBar: false,
                ),
                Lesson(course: widget.course,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class Lesson extends StatefulWidget {
  final Course course;
  const Lesson({super.key, required this.course});

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  bool showFirstMessage = false;
  bool showSecondMessage = false;

  @override
  void initState() {
    super.initState();

    // Show first message after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showFirstMessage = true;
        });

        // Hide first message after 5 seconds
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) {
            setState(() {
              showFirstMessage = false;
            });
          }
        });
      }
    });

    // Show second message after a minute
    Future.delayed(const Duration(minutes: 1), () {
      if (mounted) {
        setState(() {
          showSecondMessage = true;
        });

        // Hide second message after 5 seconds
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
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
                                side:
                                const BorderSide(color: Colors.white, width: 2),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                minimumSize: const Size(150, 37),
                              ),
                              onPressed: () {
                                Get.to(() =>  ModuleScreenTest(course: widget.course),
                                    transition: Transition.fade,
                                    duration: const Duration(milliseconds: 400));
                              },
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
                      left: 0,
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
                                style:
                                TextStyle(fontFamily: 'UrduType', fontSize: 18),
                              ),
                            ],
                          ),
                          GestureDetector(
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                            ),
                            onTap: () {
                              Get.to(() => const ModuleScreen(),
                                  transition: Transition.fade,
                                  duration: const Duration(milliseconds: 400));
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
                        fontFamily: "UrduType",
                        fontSize: 16,
                        color: Color(0xffFE8BD1)),
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
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "اس کورس سے متعلق",
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
            Positioned(
                bottom: 60, // Adjust as needed
                right: 15, // Adjust as needed
                child: CircleAvatar(
                  backgroundColor: const Color(0xffF6B3D0),
                  radius: 30,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: SvgPicture.asset(
                        "assets/images/samina_instructor.svg",
                        fit: BoxFit.fill,
                      )),
                )),
            // If `showMessage` is true, show the message
            // If `showFirstMessage` is true, show the first message
            if (showFirstMessage)
              Positioned(
                bottom: 100, // adjust as needed
                right: 60, // adjust as needed
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Text(
                    'Hello! Need any help?',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

            // If `showSecondMessage` is true, show the second message
          ],
        ));
  }
}
