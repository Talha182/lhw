import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lhw/JourneyMap.dart';
import 'package:lhw/JourneyMap2.dart';
import 'package:lhw/Mobile_Module%20&%20Submodule/Course_dropdown%20open%20view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

import '../DownloadProgressDialog.dart';
import '../custom_widgets/Row_Column_Padding.dart';
import 'module_dashboard_card.dart';

class ModuleScreen extends StatefulWidget {
  const ModuleScreen({super.key});

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  bool _feedbackButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    double progressValue = 0.4; // Example variable to hold progress value

    final List<Map<String, dynamic>> moduleData = [
      {
        'cardText': 'متعدی بیماریوں کا تعارف',
        'imagePath': 'assets/images/image9.png',
        'submoduleCount': 2, // Number of submodules for this module
        'isStart' : true,
        'progressValue' : 0.4,
        'onTap': () {
          Get.to(
              () => JourneyMapScreen(
                    submoduleTitles: const [
                      'متعدی بیماریوں کا تعارف',
                      'متعدی بیماریوں کی مثالیں۔',
                    ],
                    submoduleDescriptions: const [
                      'اس سبق میں، آپ متعدی بیماریوں کے بارے میں سیکھیں گی، جو بیکٹیریا، وائرس، پھپھوندی، یا پیراسائٹ جیسے جانداروں کی وجہ سے ہونے والی بیماریاں ہیں. آپ جانیں گی  کہ یہ بیماریاں کس طرح ایک شخص سے دوسرے شخص میں، کیڑے مکوڑوں یا جانوروں کے ذریعے، اور بعض اوقات آلودہ غذا یا پانی پینے سے پھیل سکتی ہیں۔',
                      "یہ حصہ آپ کو متعدی بیماریوں کی مثالوں سے متعارف کرائے گا ، جس سے آپ کو ان کی علامات اور صحت پر اثرات کو پہچاننے میں مدد ملے گی۔ آپ نزلہ زکام  ، ایچ آئی وی / ایڈز ، اور ملیریا جیسی بیماریوں کے بارے میں سیکھیں گی ، اور روک تھام کے اقدامات کی اہمیت کو سمجھیں گی۔ "
                    ],
                    buttonPositions: const [
                      Offset(120, 520), // Position for Submodule 1
                      Offset(70, 200), // Position for Submodule 2
                    ],
                    iconPaths: const [
                      'assets/images/tick.svg', // Path to Submodule 2 icon
                      'assets/images/book.svg', // Path to Submodule 1 icon
                    ],
                    navigateActions: [
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule1())),
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule2())),
                    ],
                    numberOfQuizzes: const [1, 1],
                    titleAlignments: const ['left', 'left'],
                  ),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 400));
        },
      },

      {
        'cardText': 'ٹی بی',
        'imagePath': 'assets/images/image10.png',
        'submoduleCount': 4, // Number of submodules for this module
        'isStart' : true,
        'progressValue' : 0.6,
        'onTap': () {
          Get.to(
              () => JourneyMapScreen2(
                    submoduleTitles: const [
                      'ٹی بی کے متعلق اہم معلومات ',
                      'ممکنہ مریض کی صورت میں اقدامات',
                      'احتیاطی تدابیر اور غلط فہمیاں',
                      'علاج میں معاونت'
                    ],
                    submoduleDescriptions: const [
                      'یہاں، آپ ٹی بی کے بارے میں سیکھیں گی، جو ایک سنگین متعدی بیماری ہے۔ یہ بنیادی طور پر پھیپھڑوں کو متاثر کرتی ہے۔ اس سبق میں اس بات کا احاطہ کیا گیا ہے کہ ٹی بی ہوا کے ذریعے ایک شخص سے دوسرے شخص میں کیسے پھیلتی ہے اور ابتدائی تشخیص اور علاج کی اہمیت کیا ہے۔',
                      'اگر آپ کسی ایسے شخص کا سامنا کرتی ہیں جسے ٹی بی ہوسکتا ہے تو آپ سیکھیں گی بشمول انہیں ٹیسٹ کروانے اور طبی دیکھ بھال حاصل کرنے کی ترغیب دینے کا طریقہ۔',
                      'س سبق کا مقصد ٹی بی کے بارے میں عام غلط فہمیوں کو دور کرنا ہے اور آپ کو اس کے پھیلاؤ کو روکنے کے لئے احتیاطی تدابیر کے بارے میں تعلیم دینا ہے، جیسے ماسک پہننا اور رہنے کی جگہوں میں اچھی ہوا کی آمد و رفت کو یقینی بنانا۔',
                      'اس حصے میں اس بات پر تبادلہ خیال کیا گیا ہے کہ علاج کے دوران ٹی بی کے مریضوں کی مدد کیسے کی جائے، ادویات کی پابندی پر زور دیا جائے اور پیشرفت کی نگران ہیلتھ ورکر کے فرائض  پر زور دیا جائے۔',
                    ],
                    buttonPositions: const [
                      Offset(50, 620), // Position for Submodule 1
                      Offset(0, 265), // Position for Submodule 2
                      Offset(115, 370), // Position for Submodule 3
                      Offset(85, 150), // Position for Submodule 4
                    ],
                    iconPaths: const [
                      'assets/images/tick.svg', // Path to Submodule 3 icon
                      'assets/images/book.svg', // Path to Submodule 1 icon
                      'assets/images/trophy.svg', // Path to Submodule 2 icon
                      'assets/images/tick.svg', // Path to Submodule 3 icon
                    ],
                    navigateActions: [
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule1())),
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule2())),
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule3())),
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule3())),
                    ],
                    numberOfQuizzes: const [1, 1, 3, 5],
                    titleAlignments: const ['left', 'right', 'left', 'left'],
                  ),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 400));
        },
      },

      {
        'cardText': 'جنسی بیماریاں',
        'imagePath': 'assets/images/image11.png',
        'submoduleCount': 2, // Number of submodules for this module
        'isStart' : false,
        'progressValue' : 0.0,
        'onTap': () {
          Get.to(
              () => JourneyMapScreen(
                    submoduleTitles: const [
                      'جنسی بیماریاں: تعریف، اقسام اور علامات',
                      ' جنسی بیماریوں کا علاج اور بچاو',
                    ],
                    submoduleDescriptions: const [
                      'اس سبق میں، آپ جنسی طور پر منتقل ہونے والی بیماریوں (ایس ٹی ڈیز) ، ان کی اقسام اور عام علامات کے بارے میں سیکھیں گی۔ اس میں ایس ٹی ڈی کی منتقلی اور محفوظ جنسی طریقوں اور باقاعدگی سے جانچ کی اہمیت کو بیان کیا گیا ہے۔',
                      "یہ سبق آپ کو ایس ٹی ڈی کے لئے دستیاب علاج اور ان کی منتقلی کو روکنے کے طریقوں کے بارے میں رہنمائی کرے گا. یہ ایس ٹی ڈی کی روک تھام میں تعلیم، کنڈوم کے استعمال اور ویکسینیشن  کے کردار پر زور دیتا ہے۔"
                    ],
                    buttonPositions: const [
                      Offset(50, 520), // Position for Submodule 1
                      Offset(60, 200), // Position for Submodule 2
                    ],
                    iconPaths: const [
                      'assets/images/tick.svg', // Path to Submodule 1 icon
                      'assets/images/trophy.svg', // Path to Submodule 2 icon
                    ],
                    navigateActions: [
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule1())),
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule2())),
                    ],
                    numberOfQuizzes: const [1, 1],
                    titleAlignments: const ['left', 'left'],
                  ),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 400));
        },
      },

      {
        'cardText': 'یچ آئی وی',
        'imagePath': 'assets/images/image12.png',
        'submoduleCount': 2, // Number of submodules for this module
        'onTap': () {
          Get.to(
              () => JourneyMapScreen(
                    submoduleTitles: const [
                      'ایچ آئی وی / ایڈز کی منتقلی اور علامات',
                      'ایچ آئی وی / ایڈز کے ٹیسٹ، علاج اور\n افواہیں',
                    ],
                    submoduleDescriptions: const [
                      'اس سبق میں، آپ ایچ آئی وی / ایڈز کے بارے میں مزید  سیکھیں گی۔ اس بات پر توجہ دی جاۓ گی کہ وائرس لوگوں کے درمیان یہ بماری  کیسے منتقل ہوتی  ہے اور متاثرہ افراد میں ظاہر ہونے والی علامات  کیا ہیں۔ روک تھام اور جلد تشخیص کے لئے ان پہلوؤں کو سمجھنا بہت ضروری ہے۔',
                      "یہ حصہ ایچ آئی وی کی جانچ کی اہمیت پر توجہ دے گا، دستیاب علاج اور ایچ آئی وی / ایڈز سے متعلق عام خرافات کو دور کرے گا۔ اس سبق میں ہم متاثرہ افراد کے لئے درست معلومات اور ہمدردانہ دیکھ بھال کی ضرورت سیکھیں گے۔"
                    ],
                    buttonPositions: const [
                      Offset(50, 520), // Position for Submodule 1
                      Offset(20, 200), // Position for Submodule 2
                    ],
                    iconPaths: const [
                      'assets/images/tick.svg', // Path to Submodule 1 icon
                      'assets/images/trophy.svg', // Path to Submodule 2 icon
                    ],
                    navigateActions: [
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule1())),
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule2())),
                    ],
                    numberOfQuizzes: const [1, 1],
                    titleAlignments: const ['left', 'left'],
                  ),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 400));
        },
      },

      {
        'cardText': 'ہیپاٹائٹس',
        'imagePath': 'assets/images/image13.png',
        'submoduleCount': 3, // Number of submodules for this module
        'onTap': () {
          Get.to(
              () => JourneyMapScreen(
                    submoduleTitles: const [
                      'ہیپاٹائٹس: وجوہات، پھیلاؤ اور علامات',
                      ' ہیپاٹائٹس کی تشخیص، علاج اور روک تھام',
                    ],
                    submoduleDescriptions: const [
                      'یہاں، آپ ہیپاٹائٹس کے بارے میں پڑھیں گی۔ یہ جگر کی سوزش ہوتی ہے جو مختلف وائرسوں کی وجہ سے ہوتی ہے. آپ اس بارے میں سیکھیں گے کہ یہ وائرس کیسے پھیلتے ہیں، ہیپاٹائٹس کی علامات، اور بیماری کا جلد پتہ لگانا اور اس کا علاج کرنا کیوں ضروری ہے۔',
                      'یہ سبق آپ کو ہیپاٹائٹس کی تشخیص، بیماری کے انتظام کے لئے دستیاب علاج، اور احتیاط کے طریقوں اور ویکسینیشن سمیت مؤثر روک تھام کی حکمت عملی کے بارے میں رہنمائی کرے گا۔',
                    ],
                    buttonPositions: const [
                      Offset(55, 520), // Position for Submodule 1
                      Offset(0, 200), // Position for Submodule 2
                    ],
                    iconPaths: const [
                      'assets/images/tick.svg', // Path to Submodule 3 icon
                      'assets/images/book.svg', // Path to Submodule 1 icon
                    ],
                    navigateActions: [
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule1())),
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule3())),
                    ],
                    numberOfQuizzes: const [1, 1],
                    titleAlignments: const ['left', 'left'],
                  ),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 400));
        },
      },

      {
        'cardText': 'ملیریا',
        'imagePath': 'assets/images/image9.png',
        'submoduleCount': 2, // Number of submodules for this module
        'onTap': () {
          Get.to(
              () => JourneyMapScreen(
                    submoduleTitles: const [
                      ' ملیریا کے اسباب، پھیلاؤ اور علامات',
                      'ملیریا کی تشخیص، علاج اور روک تھام',
                    ],
                    submoduleDescriptions: const [
                      'اس سبق میں، آپ ملیریا کے بارے میں سیکھیں گی، جو مچھروں سے پھیلنے والی بیماری ہے۔ یہ انسانوں میں کیسے منتقل ہوتا ہے، دیکھنے کے لئے علامات، اور بیماری کی روک تھام میں مچھروں پر قابو پانے کی اہمیت پر توجہ دی گئ ہے۔',
                      'اس حصے میں ملیریا کی تشخیص کیسے کی جاتی ہے، علاج  اور مچھروں کے کاٹنے سے بچنے کے لئے مچھر دانیوں اور کیڑوں کو روکنے والی ادویات کا استعمال جیسے احتیاطی اقدامات پر تبادلہ خیال کیا گیا ہے۔',
                    ],
                    buttonPositions: const [
                      Offset(65, 520), // Position for Submodule 1
                      Offset(30, 200), // Position for Submodule 2
                    ],
                    iconPaths: const [
                      'assets/images/tick.svg', // Path to Submodule 3 icon
                      'assets/images/book.svg', // Path to Submodule 1 icon
                    ],
                    navigateActions: [
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule1())),
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule3())),
                    ],
                    numberOfQuizzes: const [1, 1],
                    titleAlignments: const ['left', 'left'],
                  ),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 400));
        },
      },

      {
        'cardText': 'ڈینگی',
        'imagePath': 'assets/images/image10.png',
        'submoduleCount': 2, // Number of submodules for this module
        'onTap': () {
          Get.to(
              () => JourneyMapScreen(
                    submoduleTitles: const [
                      'ڈینگی اور اس کا پھیلاؤ',
                      'ڈینگی کی علامات، تشخیص، علاج اور\n روک تھام',
                    ],
                    submoduleDescriptions: const [
                      'آپ ڈینگی کے بارے میں سیکھیں گی، جو مچھروں کے ذریعے پھیلنے والا وائرل انفیکشن ہے۔ یہ سبق اس بات پر توجہ دیتا ہے کہ ڈینگی کیسے پھیلتا ہے، وہ حالات جو اس کے پھیلاؤ کو بڑھاتے ہیں، اور مچھروں کی افزائش کے مقامات کو کم کرنے کے لئے کھڑے پانی کو ختم کرنے کی اہمیت۔',
                      'اس سبق میں ڈینگی کی علامات، اس کی تشخیص، دستیاب علاج، اور ڈینگی کی روک تھام کے لئے جامع حکمت عملی بتائی گئی ہے۔  اس میں مچھروں کی آبادی کو کنٹرول کرنے کے لئے کمیونٹی کی کوششیں بھی شامل ہیں۔',
                    ],
                    buttonPositions: const [
                      Offset(130, 520), // Position for Submodule 1
                      Offset(40, 200), // Position for Submodule 2
                    ],
                    iconPaths: const [
                      'assets/images/tick.svg', // Path to Submodule 3 icon
                      'assets/images/book.svg', // Path to Submodule 1 icon
                    ],
                    navigateActions: [
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule1())),
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule3())),
                    ],
                    numberOfQuizzes: const [1, 1],
                    titleAlignments: const ['left', 'left'],
                  ),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 400));
        },
      },

      {
        'cardText': 'کرونا وائرس',
        'imagePath': 'assets/images/image11.png',
        'submoduleCount': 2, // Number of submodules for this module
        'onTap': () {
          Get.to(
              () => JourneyMapScreen(
                    submoduleTitles: const [
                      'کورونا کی منتقلی اور علامات',
                      'کورونا وائرس سے بچاؤ اور\n احتیاتی اقدامات',
                      'کورونا کے مریض کی دیکھ بھال ',
                    ],
                    submoduleDescriptions: const [
                      'اس سبق میں، آپ کورونا وائرس (کووڈ 19) کے بارے میں سیکھیں گے، بشمول یہ کہ یہ لوگوں کے درمیان کیسے منتقل ہوتا ہے اور متاثرہ افراد کو جو علامات کا سامنا کرنا پڑ سکتا ہے. یہ اس کے پھیلاؤ کو روکنے میں ماسک اور سماجی دوری کی اہمیت کو اجاگر کرتا ہے۔',
                      'یہ حصہ کورونا وائرس کی منتقلی کو روکنے، کووڈ 19 کے مریضوں کی دیکھ بھال اور ذہنی صحت کی مدد کے بارے میں رہنمائی فراہم کرتا ہے۔ اس میں غذائی تغذیہ کی مدد اور وائرس سے متعلق عام خرافات کو مسترد کرنے پر بھی توجہ دی گئی ہے۔',
                      'یہ سبق  کوویڈ 19 کے مریضوں کی مؤثر دیکھ بھال اور انتظام کے بارے میں اہم معلومات دیتا ہے ، جس میں حفاظتی اقدامات ، علاج کے پروٹوکول اور مریضوں کی فلاح و بہبود  پر توجہ شامل ہے ۔ یہ مواصلات، ہمدردانہ دیکھ بھال، اور صحت کی دیکھ بھال کی نئی حکمت عملیوں کو اپنانے کی اہمیت پر زور دیتا ہے۔',
                    ],
                    buttonPositions: const [
                      Offset(110, 520), // Position for Submodule 1
                      Offset(120, 330), // Position for Submodule 1
                      Offset(45, 200), // Position for Submodule 2
                    ],
                    iconPaths: const [
                      'assets/images/tick.svg', // Path to Submodule 3 icon
                      'assets/images/book.svg', // Path to Submodule 1 icon
                      'assets/images/trophy.svg', // Path to Submodule 1 icon
                    ],
                    navigateActions: [
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule1())),
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule1())),
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Submodule3())),
                    ],
                    numberOfQuizzes: const [1, 1, 1],
                    titleAlignments: const ['left', 'right', 'left'],
                  ),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 400));
        },
      },

      // Add more modules as needed
    ];

    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  onTap: () {

                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: const Text(
                  "عنوان",
                  style: TextStyle(
                    fontFamily: 'UrduType',
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ).animate().fadeIn().scale(),
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
        padding: const EdgeInsets.only(top: 15),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xff8E79FB), Color(0xffB09FFD)]),
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/module.png', // replace with your image name
                    ),
                  fit: BoxFit.none,
                  alignment: Alignment.bottomLeft,
                  scale: 0.9
                )
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('نیوٹریشن کورس',
                        style: TextStyle(
                            fontFamily: 'UrduType',
                            color: Colors.white,
                            fontSize: 24,
                            letterSpacing: 1)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${(progressValue * 100).toStringAsFixed(0)}%',
                          // Displaying the progress as percentage
                          style: const TextStyle(
                            fontFamily: 'UrduType',
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, top: 8),
                          child: AnimatedProgressBar(
                            height: 5,
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            value: progressValue,
                            duration: const Duration(seconds: 2),
                            color: const Color(0xff9AC9C2),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            'assets/images/module.svg',
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            '24 ماڈیولز',
                            style: TextStyle(
                              fontFamily: 'UrduType',
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            textDirection: TextDirection.rtl,
                          ),

                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(Icons.circle, color: Colors.white, size: 6,),
                          const SizedBox(
                            width: 8,
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
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            textDirection: TextDirection.rtl,
                          ),


                        ],
                      ),
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
                              minimumSize: const Size(140, 30),
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
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
           /* Positioned(
              bottom: -15,
              left: 0,
              child: Image.asset(
                'assets/images/module.png', // replace with your image name
                width: 180, // Set your width
                height: 180,
                fit: BoxFit.contain, // Set your height
              ),
            ),*/

            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(top: 16),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'کورس کا مواد',
                      style: TextStyle(fontFamily: 'UrduType', fontSize: 24),
                      textAlign: TextAlign.right,

                    ),
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
                          primary: Colors.transparent,
                          // Background color
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
                        onPressed: () async {
                          bool result = await _permissionRequest();
                          if (result) {
                            showDialog(
                                context: context,
                                builder: (dialogcontext) {
                                  return DownloadProgressDialog();
                                });
                          } else {
                            print("No permission to read and write.");
                          }
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
                    children: moduleData
                        .map((module) => Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: Module_DashBoard_Card(
                        onClick: module['onTap'],
                        progressValue: module['progressValue'] != null ? double.parse(module['progressValue'].toString()) : 0.0,
                        // Example progress value
                        imagePath: module['imagePath'],
                        cardText: module['cardText'],
                        showProgressBar: module['isStart'] != null ? module['isStart'] as bool : false,

                      ),
                    ))
                        .toList()
                        .animate(interval: 200.ms)
                        .fade(duration: 200.ms),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  static Future<bool> _permissionRequest() async {
    PermissionStatus result;
    result = await Permission.storage.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
