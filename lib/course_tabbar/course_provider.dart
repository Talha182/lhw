import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhw/Branching/LessonOption33.dart';
import 'package:lhw/Presentation/Presentation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Comic_Strip/comic_strip.dart';
import '../Image_Hotspot/LessonOption26.dart';
import '../Mobile_Lesson & Flashcards/flash_cards_screen.dart';
import '../models/feature_tile_model.dart';
import '../models/module_model.dart';
import '../models/course_model.dart';
import '../models/submodule_model.dart';
import '../test/Features/InteractiveImage.dart';

// course provider
class CoursesProvider with ChangeNotifier {
  final List<Course> _courses = [
    Course(
      courseId: 1,
      title: 'متعدی بیماریاں',
      gradient:
          const LinearGradient(colors: [Color(0xff89E4FE), Color(0xff18A3C8)]),
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
              description:
                  'اس سبق میں، آپ متعدی بیماریوں کے بارے میں سیکھیں گی، جو بیکٹیریا، وائرس، پھپھوندی، یا پیراسائٹ جیسے جانداروں کی وجہ سے ہونے والی بیماریاں ہیں. آپ جانیں گی کہ یہ بیماریاں کس طرح ایک شخص سے دوسرے شخص میں، کیڑے مکوڑوں یا جانوروں کے ذریعے، اور بعض اوقات آلودہ غذا یا پانی پینے سے پھیل سکتی ہیں۔',
              buttonPosition: const Offset(120, 520),
              iconPath: 'assets/images/tick.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [
                FeatureCallback(
                  title: 'Lesson Option Video',
                  featureType: FeatureType.video,
                  duration: "3 منٹ 2 سیکنڈ",
                  callback: () async {
                    await Get.to(() => const LessonOption33(
                        videoPath: 'assets/videos/demo.mp4'));
                    return;
                  },
                ),
              ],
            ),
            Submodule(
              submoduleID: 2,
              title: 'متعدی بیماریوں کی مثالیں۔',
              description:
                  "یہ حصہ آپ کو متعدی بیماریوں کی مثالوں سے متعارف کرائے گا ، جس سے آپ کو ان کی علامات اور صحت پر اثرات کو پہچاننے میں مدد ملے گی۔ آپ نزلہ زکام ، ایچ آئی وی / ایڈز ، اور ملیریا جیسی بیماریوں کے بارے میں سیکھیں گی ، اور روک تھام کے اقدامات کی اہمیت کو سمجھیں گی۔",
              buttonPosition: const Offset(70, 200),
              iconPath: 'assets/images/book.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [
                FeatureCallback(
                  title: 'Presentation on Infectious Diseases',
                  featureType: FeatureType.presentation,
                  duration: "3 منٹ 2 سیکنڈ",
                  callback: () async {
                    await Get.to(() => const Presentation(
                          assetImages: [
                            'assets/presentations/presentation1.png',
                            'assets/presentations/presentation2.png',
                            'assets/presentations/presentation3.png',
                            'assets/presentations/presentation4.png',
                            'assets/presentations/presentation5.png',
                            'assets/presentations/presentation6.png',
                          ],
                        ));
                    return;
                  },
                ),
              ],
            ),
          ],
          submoduleCount: 2,
        ),
        Module(
          moduleId: 2,
          title: 'ٹی۔ بی',
          imagePath: 'assets/moduleIcons/module2.png',
          isStart: false,
          progressValue: 0.5,
          submodules: [
            Submodule(
              submoduleID: 1,
              title: 'ٹی بی کے متعلق اہم معلومات',
              description:
                  'یہاں، آپ ٹی بی کے بارے میں سیکھیں گی، جو ایک سنگین متعدی بیماری ہے۔ یہ بنیادی طور پر پھیپھڑوں کو متاثر کرتی ہے۔ اس سبق میں اس بات کا احاطہ کیا گیا ہے کہ ٹی بی ہوا کے ذریعے ایک شخص سے دوسرے شخص میں کیسے پھیلتی ہے اور ابتدائی تشخیص اور علاج کی اہمیت کیا ہے۔',
              buttonPosition: const Offset(50, 620), // Position for Submodule 1

              iconPath: 'assets/images/tick.svg',

              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [
                FeatureCallback(
                  title: 'Lesson Option Video',
                  featureType: FeatureType.video,
                  duration: "3 منٹ 2 سیکنڈ",
                  callback: () async {
                    await Get.to(() => const LessonOption33(
                        videoPath: 'assets/videos/demo.mp4'));
                    return;
                  },
                ), FeatureCallback(
                  title: 'Lesson Option Video',
                  featureType: FeatureType.video,
                  duration: "3 منٹ 2 سیکنڈ",
                  callback: () async {
                    await Get.to(() => const LessonOption33(
                        videoPath: 'assets/videos/demo.mp4'));
                    return;
                  },
                ),
              ],
            ),
            Submodule(
              submoduleID: 2,
              title: 'احتیاطی تدابیر اور غلط فہمیاں',
              description:
                  'س سبق کا مقصد ٹی بی کے بارے میں عام غلط فہمیوں کو دور کرنا ہے اور آپ کو اس کے پھیلاؤ کو روکنے کے لئے احتیاطی تدابیر کے بارے میں تعلیم دینا ہے، جیسے ماسک پہننا اور رہنے کی جگہوں میں اچھی ہوا کی آمد و رفت کو یقینی بنانا۔',
              buttonPosition: const Offset(115, 370),
              iconPath: 'assets/images/book.svg',
              numberOfQuizzes: 3,
              titleAlignment: 'left',
              featureCallbacks: [],
            ),
            Submodule(
              submoduleID: 3,
              title: 'ممکنہ مریض کی صورت میں اقدامات',
              description:
                  'اگر آپ کسی ایسے شخص کا سامنا کرتی ہیں جسے ٹی بی ہوسکتا ہے تو آپ سیکھیں گی بشمول انہیں ٹیسٹ کروانے اور طبی دیکھ بھال حاصل کرنے کی ترغیب دینے کا طریقہ۔',
              buttonPosition: const Offset(0, 265),
              iconPath: 'assets/images/book.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'right',
              featureCallbacks: [
                FeatureCallback(
                  title: 'Lesson Option Video',
                  featureType: FeatureType.video,
                  duration: "3 منٹ 2 سیکنڈ",
                  callback: () async {
                    await Get.to(() => const LessonOption33(
                        videoPath: 'assets/videos/demo.mp4'));
                    return;
                  },
                ),
              ],
            ),
            Submodule(
              submoduleID: 4,
              title: 'علاج میں معاونت',
              description:
                  'اس حصے میں اس بات پر تبادلہ خیال کیا گیا ہے کہ علاج کے دوران ٹی بی کے مریضوں کی مدد کیسے کی جائے، ادویات کی پابندی پر زور دیا جائے اور پیشرفت کی نگران ہیلتھ ورکر کے فرائض  پر زور دیا جائے۔',
              buttonPosition: const Offset(85, 150),
              iconPath: 'assets/images/book.svg',
              numberOfQuizzes: 5,
              titleAlignment: 'left',
              featureCallbacks: [
                FeatureCallback(
                  title: 'Lesson Option Video',
                  featureType: FeatureType.video,
                  duration: "3 منٹ 2 سیکنڈ",
                  callback: () async {
                    await Get.to(() => const LessonOption33(
                        videoPath: 'assets/videos/demo.mp4'));
                    return;
                  },
                ),FeatureCallback(
                  title: 'Lesson Option Video',
                  featureType: FeatureType.video,
                  duration: "3 منٹ 2 سیکنڈ",
                  callback: () async {
                    await Get.to(() => const LessonOption33(
                        videoPath: 'assets/videos/demo.mp4'));
                    return;
                  },
                ),
              ],
            ),
          ],
          submoduleCount: 4,
        ),
        Module(
          moduleId: 3,
          title: 'جنسی بیماریاں',
          imagePath: 'assets/moduleIcons/module3.png',
          isStart: false,
          progressValue: 0.5,
          submodules: [
            Submodule(
              submoduleID: 1,
              title: 'جنسی بیماریاں: تعریف، اقسام اور علامات',
              description:
                  'اس سبق میں، آپ جنسی طور پر منتقل ہونے والی بیماریوں (ایس ٹی ڈیز) ، ان کی اقسام اور عام علامات کے بارے میں سیکھیں گی۔ اس میں ایس ٹی ڈی کی منتقلی اور محفوظ جنسی طریقوں اور باقاعدگی سے جانچ کی اہمیت کو بیان کیا گیا ہے۔',
              buttonPosition: const Offset(50, 520),
              iconPath: 'assets/images/tick.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [
                FeatureCallback(
                  title: 'Lesson Option Video',
                  featureType: FeatureType.video,
                  duration: "3 منٹ 2 سیکنڈ",
                  callback: () async {
                    await Get.to(() => const LessonOption33(
                        videoPath: 'assets/videos/demo.mp4'));
                    return;
                  },
                ),
              ],
            ),
            Submodule(
              submoduleID: 2,
              title: 'جنسی بیماریوں کا علاج اور بچاو',
              description:
                  "یہ سبق آپ کو ایس ٹی ڈی کے لئے دستیاب علاج اور ان کی منتقلی کو روکنے کے طریقوں کے بارے میں رہنمائی کرے گا. یہ ایس ٹی ڈی کی روک تھام میں تعلیم، کنڈوم کے استعمال اور ویکسینیشن  کے کردار پر زور دیتا ہے۔",
              buttonPosition: const Offset(60, 200),
              iconPath: 'assets/images/book.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [
                FeatureCallback(
                  title: 'Lesson Option Video',
                  featureType: FeatureType.video,
                  duration: "3 منٹ 2 سیکنڈ",
                  callback: () async {
                    await Get.to(() => const LessonOption33(
                        videoPath: 'assets/videos/demo.mp4'));
                    return;
                  },
                ),
              ],
            ),
          ],
          submoduleCount: 2,
        ),
        Module(
          moduleId: 4,
          title: 'یچ آئی وی',
          imagePath: 'assets/moduleIcons/module4.png',
          isStart: false,
          progressValue: 0.5,
          submodules: [
            Submodule(
              submoduleID: 1,
              title: 'ایچ آئی وی / ایڈز کی منتقلی اور علامات',
              description:
                  'اس سبق میں، آپ ایچ آئی وی / ایڈز کے بارے میں مزید  سیکھیں گی۔ اس بات پر توجہ دی جاۓ گی کہ وائرس لوگوں کے درمیان یہ بماری  کیسے منتقل ہوتی  ہے اور متاثرہ افراد میں ظاہر ہونے والی علامات  کیا ہیں۔ روک تھام اور جلد تشخیص کے لئے ان پہلوؤں کو سمجھنا بہت ضروری ہے۔',
              buttonPosition: const Offset(50, 520),
              iconPath: 'assets/images/tick.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [FeatureCallback(
                title: 'Lesson Option Video',
                featureType: FeatureType.video,
                duration: "3 منٹ 2 سیکنڈ",
                callback: () async {
                  await Get.to(() => const LessonOption33(
                      videoPath: 'assets/videos/demo.mp4'));
                  return;
                },
              ),FeatureCallback(
                title: 'Lesson Option Video',
                featureType: FeatureType.video,
                duration: "3 منٹ 2 سیکنڈ",
                callback: () async {
                  await Get.to(() => const LessonOption33(
                      videoPath: 'assets/videos/demo.mp4'));
                  return;
                },
              ),FeatureCallback(
                title: 'Lesson Option Video',
                featureType: FeatureType.video,
                duration: "3 منٹ 2 سیکنڈ",
                callback: () async {
                  await Get.to(() => const LessonOption33(
                      videoPath: 'assets/videos/demo.mp4'));
                  return;
                },
              ),],
            ),
            Submodule(
              submoduleID: 2,
              title: 'ایچ آئی وی / ایڈز کے ٹیسٹ، علاج اور\n افواہیں',
              description:
                  "یہ حصہ ایچ آئی وی کی جانچ کی اہمیت پر توجہ دے گا، دستیاب علاج اور ایچ آئی وی / ایڈز سے متعلق عام خرافات کو دور کرے گا۔ اس سبق میں ہم متاثرہ افراد کے لئے درست معلومات اور ہمدردانہ دیکھ بھال کی ضرورت سیکھیں گے۔",
              buttonPosition: const Offset(20, 200),
              iconPath: 'assets/images/book.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [],
            ),
          ],
          submoduleCount: 2,
        ),
        Module(
          moduleId: 5,
          title: 'ہیپاٹائٹس',
          imagePath: 'assets/moduleIcons/module5.png',
          isStart: false,
          progressValue: 0.5,
          submodules: [
            Submodule(
              submoduleID: 1,
              title: 'ہیپاٹائٹس: وجوہات، پھیلاؤ اور علامات',
              description:
                  'یہاں، آپ ہیپاٹائٹس کے بارے میں پڑھیں گی۔ یہ جگر کی سوزش ہوتی ہے جو مختلف وائرسوں کی وجہ سے ہوتی ہے. آپ اس بارے میں سیکھیں گے کہ یہ وائرس کیسے پھیلتے ہیں، ہیپاٹائٹس کی علامات، اور بیماری کا جلد پتہ لگانا اور اس کا علاج کرنا کیوں ضروری ہے۔',
              buttonPosition: const Offset(55, 520),
              iconPath: 'assets/images/tick.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [FeatureCallback(
                title: 'Lesson Option Video',
                featureType: FeatureType.video,
                duration: "3 منٹ 2 سیکنڈ",
                callback: () async {
                  await Get.to(() => const LessonOption33(
                      videoPath: 'assets/videos/demo.mp4'));
                  return;
                },
              ),FeatureCallback(
                title: 'Lesson Option Video',
                featureType: FeatureType.video,
                duration: "3 منٹ 2 سیکنڈ",
                callback: () async {
                  await Get.to(() => const LessonOption33(
                      videoPath: 'assets/videos/demo.mp4'));
                  return;
                },
              ),],
            ),
            Submodule(
              submoduleID: 2,
              title: 'ہیپاٹائٹس کی تشخیص، علاج اور روک تھام',
              description:
                  'یہ سبق آپ کو ہیپاٹائٹس کی تشخیص، بیماری کے انتظام کے لئے دستیاب علاج، اور احتیاط کے طریقوں اور ویکسینیشن سمیت مؤثر روک تھام کی حکمت عملی کے بارے میں رہنمائی کرے گا۔',
              buttonPosition: const Offset(0, 200),
              iconPath: 'assets/images/book.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [FeatureCallback(
                title: 'Lesson Option Video',
                featureType: FeatureType.video,
                duration: "3 منٹ 2 سیکنڈ",
                callback: () async {
                  await Get.to(() => const LessonOption33(
                      videoPath: 'assets/videos/demo.mp4'));
                  return;
                },
              ),FeatureCallback(
                title: 'Lesson Option Video',
                featureType: FeatureType.video,
                duration: "3 منٹ 2 سیکنڈ",
                callback: () async {
                  await Get.to(() => const LessonOption33(
                      videoPath: 'assets/videos/demo.mp4'));
                  return;
                },
              ),],
            ),
          ],
          submoduleCount: 2,
        ),
        Module(
          moduleId: 6,
          title: 'ملیریا',
          imagePath: 'assets/moduleIcons/module6.png',
          isStart: false,
          progressValue: 0.5,
          submodules: [
            Submodule(
              submoduleID: 1,
              title: 'ملیریا کے اسباب، پھیلاؤ اور علامات',
              description:
                  'اس سبق میں، آپ ملیریا کے بارے میں سیکھیں گی، جو مچھروں سے پھیلنے والی بیماری ہے۔ یہ انسانوں میں کیسے منتقل ہوتا ہے، دیکھنے کے لئے علامات، اور بیماری کی روک تھام میں مچھروں پر قابو پانے کی اہمیت پر توجہ دی گئ ہے۔',
              buttonPosition: const Offset(65, 520),
              iconPath: 'assets/images/tick.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [FeatureCallback(
                title: 'Lesson Option Video',
                featureType: FeatureType.video,
                duration: "3 منٹ 2 سیکنڈ",
                callback: () async {
                  await Get.to(() => const LessonOption33(
                      videoPath: 'assets/videos/demo.mp4'));
                  return;
                },
              ),],
            ),
            Submodule(
              submoduleID: 2,
              title: 'ملیریا کی تشخیص، علاج اور روک تھام',
              description:
                  'اس حصے میں ملیریا کی تشخیص کیسے کی جاتی ہے، علاج  اور مچھروں کے کاٹنے سے بچنے کے لئے مچھر دانیوں اور کیڑوں کو روکنے والی ادویات کا استعمال جیسے احتیاطی اقدامات پر تبادلہ خیال کیا گیا ہے۔',
              buttonPosition: const Offset(30, 200),
              iconPath: 'assets/images/book.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [FeatureCallback(
                title: 'Lesson Option Video',
                featureType: FeatureType.video,
                duration: "3 منٹ 2 سیکنڈ",
                callback: () async {
                  await Get.to(() => const LessonOption33(
                      videoPath: 'assets/videos/demo.mp4'));
                  return;
                },
              ),],
            ),
          ],
          submoduleCount: 2,
        ),
        Module(
          moduleId: 7,
          title: 'ڈینگی',
          imagePath: 'assets/moduleIcons/module7.png',
          isStart: false,
          progressValue: 0.5,
          submodules: [
            Submodule(
              submoduleID: 1,
              title: 'ڈینگی اور اس کا پھیلاؤ',
              description:
                  'آپ ڈینگی کے بارے میں سیکھیں گی، جو مچھروں کے ذریعے پھیلنے والا وائرل انفیکشن ہے۔ یہ سبق اس بات پر توجہ دیتا ہے کہ ڈینگی کیسے پھیلتا ہے، وہ حالات جو اس کے پھیلاؤ کو بڑھاتے ہیں، اور مچھروں کی افزائش کے مقامات کو کم کرنے کے لئے کھڑے پانی کو ختم کرنے کی اہمیت۔',
              buttonPosition: const Offset(130, 520),
              iconPath: 'assets/images/tick.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [FeatureCallback(
                title: 'Lesson Option Video',
                featureType: FeatureType.video,
                duration: "3 منٹ 2 سیکنڈ",
                callback: () async {
                  await Get.to(() => const LessonOption33(
                      videoPath: 'assets/videos/demo.mp4'));
                  return;
                },
              ),],
            ),
            Submodule(
              submoduleID: 2,
              title: 'ڈینگی کی علامات، تشخیص، علاج اور\n روک تھام',
              description:
                  'اس سبق میں ڈینگی کی علامات، اس کی تشخیص، دستیاب علاج، اور ڈینگی کی روک تھام کے لئے جامع حکمت عملی بتائی گئی ہے۔  اس میں مچھروں کی آبادی کو کنٹرول کرنے کے لئے کمیونٹی کی کوششیں بھی شامل ہیں۔',
              buttonPosition: const Offset(40, 200),
              iconPath: 'assets/images/book.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [FeatureCallback(
                title: 'Lesson Option Video',
                featureType: FeatureType.video,
                duration: "3 منٹ 2 سیکنڈ",
                callback: () async {
                  await Get.to(() => const LessonOption33(
                      videoPath: 'assets/videos/demo.mp4'));
                  return;
                },
              ),],
            ),
          ],
          submoduleCount: 2,
        ),
        Module(
          moduleId: 8,
          title: 'کرونا وائرس',
          imagePath: 'assets/moduleIcons/module8.png',
          isStart: false,
          progressValue: 0.5,
          submodules: [
            Submodule(
              submoduleID: 1,
              title: 'کورونا کی منتقلی اور علامات',
              description:
                  'اس سبق میں، آپ کورونا وائرس (کووڈ 19) کے بارے میں سیکھیں گے، بشمول یہ کہ یہ لوگوں کے درمیان کیسے منتقل ہوتا ہے اور متاثرہ افراد کو جو علامات کا سامنا کرنا پڑ سکتا ہے. یہ اس کے پھیلاؤ کو روکنے میں ماسک اور سماجی دوری کی اہمیت کو اجاگر کرتا ہے۔',
              buttonPosition: const Offset(110, 520),
              iconPath: 'assets/images/tick.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [FeatureCallback(
                title: 'Lesson Option Video',
                featureType: FeatureType.video,
                duration: "3 منٹ 2 سیکنڈ",
                callback: () async {
                  await Get.to(() => const LessonOption33(
                      videoPath: 'assets/videos/demo.mp4'));
                  return;
                },
              ),],
            ),
            Submodule(
              submoduleID: 2,
              title: 'کورونا وائرس سے بچاؤ اور\n احتیاتی اقدامات',
              description:
                  'یہ حصہ کورونا وائرس کی منتقلی کو روکنے، کووڈ 19 کے مریضوں کی دیکھ بھال اور ذہنی صحت کی مدد کے بارے میں رہنمائی فراہم کرتا ہے۔ اس میں غذائی تغذیہ کی مدد اور وائرس سے متعلق عام خرافات کو مسترد کرنے پر بھی توجہ دی گئی ہے۔',
              buttonPosition: const Offset(120, 330),
              iconPath: 'assets/images/book.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'right',
              featureCallbacks: [FeatureCallback(
                title: 'Lesson Option Video',
                featureType: FeatureType.video,
                duration: "3 منٹ 2 سیکنڈ",
                callback: () async {
                  await Get.to(() => const LessonOption33(
                      videoPath: 'assets/videos/demo.mp4'));
                  return;
                },
              ),],
            ),
            Submodule(
              submoduleID: 3,
              title: 'کورونا کے مریض کی دیکھ بھال',
              description:
                  'یہ سبق  کوویڈ 19 کے مریضوں کی مؤثر دیکھ بھال اور انتظام کے بارے میں اہم معلومات دیتا ہے ، جس میں حفاظتی اقدامات ، علاج کے پروٹوکول اور مریضوں کی فلاح و بہبود  پر توجہ شامل ہے ۔ یہ مواصلات، ہمدردانہ دیکھ بھال، اور صحت کی دیکھ بھال کی نئی حکمت عملیوں کو اپنانے کی اہمیت پر زور دیتا ہے۔',
              buttonPosition: const Offset(45, 200),
              iconPath: 'assets/images/book.svg',
              numberOfQuizzes: 1,
              titleAlignment: 'left',
              featureCallbacks: [FeatureCallback(
                title: 'Lesson Option Video',
                featureType: FeatureType.video,
                duration: "3 منٹ 2 سیکنڈ",
                callback: () async {
                  await Get.to(() => const LessonOption33(
                      videoPath: 'assets/videos/demo.mp4'));
                  return;
                },
              ),],
            ),
          ],
          submoduleCount: 2,
        ),
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
