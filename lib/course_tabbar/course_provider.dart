import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhw/Image_Hotspot/LessonOption26.dart';
import 'package:lhw/Mobile_Lesson%20&%20Flashcards/Lesson_Option20.dart';
import 'package:lhw/Quiz/MCQ%204.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../JourneyMap.dart';
import '../models/module_model.dart';
import '../models/course_model.dart';
import '../models/submodule_model.dart';

// course provider
class CoursesProvider with ChangeNotifier {
  final List<Course> _courses = [
    Course(
      courseId: 1,
      title: 'تعارف ٹریننگ کا طریقہ کار',
      gradient:
          const LinearGradient(colors: [Color(0xffEAAF58), Color(0xffF4D6A9)]),
      quizCount: 64,
      moduleCount: 64,
      imagePath: 'assets/images/two_women.png',
      isStart: true,
      modules: [
        Module(
          moduleId: 1,
          title: 'متعدی بیماریوں کا تعارف',
          imagePath: 'assets/images/image9.png',
          isStart: false,
          progressValue: 0.5,
          onTap: () {
            // Define navigation logic here, adjusted as per your framework's navigation system
          },
          submodules: [
            Submodule(
              title: 'متعدی بیماریوں کا تعارف',
              description:
                  'اس سبق میں، آپ متعدی بیماریوں کے بارے میں سیکھیں گی، جو بیکٹیریا، وائرس، پھپھوندی، یا پیراسائٹ جیسے جانداروں کی وجہ سے ہونے والی بیماریاں ہیں. آپ جانیں گی  کہ یہ بیماریاں کس طرح ایک شخص سے دوسرے شخص میں، کیڑے مکوڑوں یا جانوروں کے ذریعے، اور بعض اوقات آلودہ غذا یا پانی پینے سے پھیل سکتی ہیں۔',
              buttonPosition: const Offset(120, 520),
              iconPath: 'assets/images/tick.svg',
              navigateToFeatureCallbacks: [
                () => Get.to(() => const Feature1()), // Navigate using GetX
                () => Get.off(() => const Feature2()), // Navigate using GetX
              ],
              numberOfQuizzes: 1,
              titleAlignment: 'left',
            ),
            Submodule(
              title: 'متعدی بیماریوں کی مثالیں۔',
              description:
                  "یہ حصہ آپ کو متعدی بیماریوں کی مثالوں سے متعارف کرائے گا ، جس سے آپ کو ان کی علامات اور صحت پر اثرات کو پہچاننے میں مدد ملے گی۔ آپ نزلہ زکام  ، ایچ آئی وی / ایڈز ، اور ملیریا جیسی بیماریوں کے بارے میں سیکھیں گی ، اور روک تھام کے اقدامات کی اہمیت کو سمجھیں گی۔ ",
              buttonPosition: const Offset(70, 200),
              iconPath: 'assets/images/book.svg',
              navigateToFeatureCallbacks: [
                () => Get.to(() => const Feature1()), // Navigate using GetX
              ],
              numberOfQuizzes: 1,
              titleAlignment: 'left',
            ),
          ],
          submoduleCount: 2,
        ),
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


class Feature1 extends StatelessWidget {
  const Feature1({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeatureNavigationController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            controller.navigateToNextFeatureOrBack();
          },
          child: const Text('Next'),
        ),
      ),
    );
  }
}

class Feature2 extends StatelessWidget {
  const Feature2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeatureNavigationController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature 2'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to the JourneyMapScreen
            controller.navigateToNextFeatureOrBack();
          },
          child: const Text('Back to Journey Map'),
        ),
      ),
    );
  }
}




// Course(
//   courseId: 3,
//   title: 'متعدی بیماریاں',
//   gradient:
//   const LinearGradient(colors: [Color(0xff89E4FE), Color(0xff18A3C8)]),
//   quizCount: 24,
//   moduleCount: 8,
//   imagePath: 'assets/images/immunization-ico.png',
//   isStart: true,
//   isCompleted: false,
//   modules: [
//     Module(
//       moduleId: 1,
//       title: 'متعدی بیماریوں کا تعارف',
//       imagePath: 'assets/images/image9.png',
//       isStart: true,
//       progressValue: 0.5,
//       onTap: () {
//         Get.to(
//                 () =>
//                 JourneyMapScreen(
//                   submoduleTitles: const [
//                     'متعدی بیماریوں کا تعارف',
//                     'متعدی بیماریوں کی مثالیں۔',
//                   ],
//                   submoduleDescriptions: const [
//                     'اس سبق میں، آپ متعدی بیماریوں کے بارے میں سیکھیں گی، جو بیکٹیریا، وائرس، پھپھوندی، یا پیراسائٹ جیسے جانداروں کی وجہ سے ہونے والی بیماریاں ہیں. آپ جانیں گی  کہ یہ بیماریاں کس طرح ایک شخص سے دوسرے شخص میں، کیڑے مکوڑوں یا جانوروں کے ذریعے، اور بعض اوقات آلودہ غذا یا پانی پینے سے پھیل سکتی ہیں۔',
//                     "یہ حصہ آپ کو متعدی بیماریوں کی مثالوں سے متعارف کرائے گا ، جس سے آپ کو ان کی علامات اور صحت پر اثرات کو پہچاننے میں مدد ملے گی۔ آپ نزلہ زکام  ، ایچ آئی وی / ایڈز ، اور ملیریا جیسی بیماریوں کے بارے میں سیکھیں گی ، اور روک تھام کے اقدامات کی اہمیت کو سمجھیں گی۔ "
//                   ],
//                   buttonPositions: const [
//                     Offset(120, 520), // Position for Submodule 1
//                     Offset(70, 200), // Position for Submodule 2
//                   ],
//                   iconPaths: const [
//                     'assets/images/tick.svg', // Path to Submodule 2 icon
//                     'assets/images/book.svg', // Path to Submodule 1 icon
//                   ],
//                   navigateActions: [
//                         () => Get.to(() => const Submodule1()),
//                         () => Get.to(() => const Submodule1()),
//                   ],
//                   numberOfQuizzes: const [1, 1],
//                   titleAlignments: const ['left', 'left'],
//                 ),
//             transition: Transition.fade,
//             duration: const Duration(milliseconds: 400));
//
//         // Define what happens when you tap this module
//       },
//       submoduleCount: 2,
//     ),
//     Module(
//       moduleId: 2,
//       title: 'ٹی بی',
//       imagePath: 'assets/images/image10.png',
//       isStart: true,
//       progressValue: 0.5,
//       onTap: () {
//         Get.to(
//                 () =>
//                 JourneyMapScreen2(
//                   submoduleTitles: const [
//                     'ٹی بی کے متعلق اہم معلومات ',
//                     'ممکنہ مریض کی صورت میں اقدامات',
//                     'احتیاطی تدابیر اور غلط فہمیاں',
//                     'علاج میں معاونت'
//                   ],
//                   submoduleDescriptions: const [
//                     'یہاں، آپ ٹی بی کے بارے میں سیکھیں گی، جو ایک سنگین متعدی بیماری ہے۔ یہ بنیادی طور پر پھیپھڑوں کو متاثر کرتی ہے۔ اس سبق میں اس بات کا احاطہ کیا گیا ہے کہ ٹی بی ہوا کے ذریعے ایک شخص سے دوسرے شخص میں کیسے پھیلتی ہے اور ابتدائی تشخیص اور علاج کی اہمیت کیا ہے۔',
//                     'اگر آپ کسی ایسے شخص کا سامنا کرتی ہیں جسے ٹی بی ہوسکتا ہے تو آپ سیکھیں گی بشمول انہیں ٹیسٹ کروانے اور طبی دیکھ بھال حاصل کرنے کی ترغیب دینے کا طریقہ۔',
//                     'س سبق کا مقصد ٹی بی کے بارے میں عام غلط فہمیوں کو دور کرنا ہے اور آپ کو اس کے پھیلاؤ کو روکنے کے لئے احتیاطی تدابیر کے بارے میں تعلیم دینا ہے، جیسے ماسک پہننا اور رہنے کی جگہوں میں اچھی ہوا کی آمد و رفت کو یقینی بنانا۔',
//                     'اس حصے میں اس بات پر تبادلہ خیال کیا گیا ہے کہ علاج کے دوران ٹی بی کے مریضوں کی مدد کیسے کی جائے، ادویات کی پابندی پر زور دیا جائے اور پیشرفت کی نگران ہیلتھ ورکر کے فرائض  پر زور دیا جائے۔',
//                   ],
//                   buttonPositions: const [
//                     Offset(50, 620), // Position for Submodule 1
//                     Offset(0, 265), // Position for Submodule 2
//                     Offset(115, 370), // Position for Submodule 3
//                     Offset(85, 150), // Position for Submodule 4
//                   ],
//                   iconPaths: const [
//                     'assets/images/tick.svg', // Path to Submodule 3 icon
//                     'assets/images/book.svg', // Path to Submodule 1 icon
//                     'assets/images/trophy.svg', // Path to Submodule 2 icon
//                     'assets/images/tick.svg', // Path to Submodule 3 icon
//                   ],
//                   navigateActions: [
//                         () => Get.to(() => const Submodule1()),
//                         () => Get.to(() => const Submodule1()),
//                         () => Get.to(() => const Submodule1()),
//                         () => Get.to(() => const Submodule1()),
//                   ],
//                   numberOfQuizzes: const [1, 1, 3, 5],
//                   titleAlignments: const ['left', 'right', 'left', 'left'],
//                 ),
//             transition: Transition.fade,
//             duration: const Duration(milliseconds: 400));
//       },
//       submoduleCount: 2,
//     ),
//     Module(
//       moduleId: 3,
//       title: 'جنسی بیماریاں',
//       imagePath: 'assets/images/image11.png',
//       isStart: true,
//       progressValue: 0.5,
//       onTap: () {
//         Get.to(
//                 () =>
//                 JourneyMapScreen(
//                   submoduleTitles: const [
//                     'جنسی بیماریاں: تعریف، اقسام اور علامات',
//                     ' جنسی بیماریوں کا علاج اور بچاو',
//                   ],
//                   submoduleDescriptions: const [
//                     'اس سبق میں، آپ جنسی طور پر منتقل ہونے والی بیماریوں (ایس ٹی ڈیز) ، ان کی اقسام اور عام علامات کے بارے میں سیکھیں گی۔ اس میں ایس ٹی ڈی کی منتقلی اور محفوظ جنسی طریقوں اور باقاعدگی سے جانچ کی اہمیت کو بیان کیا گیا ہے۔',
//                     "یہ سبق آپ کو ایس ٹی ڈی کے لئے دستیاب علاج اور ان کی منتقلی کو روکنے کے طریقوں کے بارے میں رہنمائی کرے گا. یہ ایس ٹی ڈی کی روک تھام میں تعلیم، کنڈوم کے استعمال اور ویکسینیشن  کے کردار پر زور دیتا ہے۔"
//                   ],
//                   buttonPositions: const [
//                     Offset(50, 520), // Position for Submodule 1
//                     Offset(60, 200), // Position for Submodule 2
//                   ],
//                   iconPaths: const [
//                     'assets/images/tick.svg', // Path to Submodule 1 icon
//                     'assets/images/trophy.svg', // Path to Submodule 2 icon
//                   ],
//                   navigateActions: [
//                         () => Get.to(() => const Submodule1()),
//                         () => Get.to(() => const Submodule1()),
//                   ],
//                   numberOfQuizzes: const [1, 1],
//                   titleAlignments: const ['left', 'left'],
//                 ),
//             transition: Transition.fade,
//             duration: const Duration(milliseconds: 400));
//       },
//       submoduleCount: 2,
//     ),
//     Module(
//       moduleId: 4,
//       title: 'یچ آئی وی',
//       imagePath: 'assets/images/image12.png',
//       isStart: true,
//       progressValue: 0.5,
//       onTap: () {
//         Get.to(
//                 () =>
//                 JourneyMapScreen(
//                   submoduleTitles: const [
//                     'ایچ آئی وی / ایڈز کی منتقلی اور علامات',
//                     'ایچ آئی وی / ایڈز کے ٹیسٹ، علاج اور\n افواہیں',
//                   ],
//                   submoduleDescriptions: const [
//                     'اس سبق میں، آپ ایچ آئی وی / ایڈز کے بارے میں مزید  سیکھیں گی۔ اس بات پر توجہ دی جاۓ گی کہ وائرس لوگوں کے درمیان یہ بماری  کیسے منتقل ہوتی  ہے اور متاثرہ افراد میں ظاہر ہونے والی علامات  کیا ہیں۔ روک تھام اور جلد تشخیص کے لئے ان پہلوؤں کو سمجھنا بہت ضروری ہے۔',
//                     "یہ حصہ ایچ آئی وی کی جانچ کی اہمیت پر توجہ دے گا، دستیاب علاج اور ایچ آئی وی / ایڈز سے متعلق عام خرافات کو دور کرے گا۔ اس سبق میں ہم متاثرہ افراد کے لئے درست معلومات اور ہمدردانہ دیکھ بھال کی ضرورت سیکھیں گے۔"
//                   ],
//                   buttonPositions: const [
//                     Offset(50, 520), // Position for Submodule 1
//                     Offset(20, 200), // Position for Submodule 2
//                   ],
//                   iconPaths: const [
//                     'assets/images/tick.svg', // Path to Submodule 1 icon
//                     'assets/images/trophy.svg', // Path to Submodule 2 icon
//                   ],
//                   navigateActions: [
//                         () => Get.to(() => const Submodule1()),
//                         () => Get.to(() => const Submodule1()),
//                   ],
//                   numberOfQuizzes: const [1, 1],
//                   titleAlignments: const ['left', 'left'],
//                 ),
//             transition: Transition.fade,
//             duration: const Duration(milliseconds: 400));
//       },
//       submoduleCount: 2,
//     ),
//     Module(
//       moduleId: 5,
//       title: 'ہیپاٹائٹس',
//       imagePath: 'assets/images/image13.png',
//       isStart: true,
//       progressValue: 0.5,
//       onTap: () {
//         Get.to(
//                 () =>
//                 JourneyMapScreen(
//                   submoduleTitles: const [
//                     'ہیپاٹائٹس: وجوہات، پھیلاؤ اور علامات',
//                     ' ہیپاٹائٹس کی تشخیص، علاج اور روک تھام',
//                   ],
//                   submoduleDescriptions: const [
//                     'یہاں، آپ ہیپاٹائٹس کے بارے میں پڑھیں گی۔ یہ جگر کی سوزش ہوتی ہے جو مختلف وائرسوں کی وجہ سے ہوتی ہے. آپ اس بارے میں سیکھیں گے کہ یہ وائرس کیسے پھیلتے ہیں، ہیپاٹائٹس کی علامات، اور بیماری کا جلد پتہ لگانا اور اس کا علاج کرنا کیوں ضروری ہے۔',
//                     'یہ سبق آپ کو ہیپاٹائٹس کی تشخیص، بیماری کے انتظام کے لئے دستیاب علاج، اور احتیاط کے طریقوں اور ویکسینیشن سمیت مؤثر روک تھام کی حکمت عملی کے بارے میں رہنمائی کرے گا۔',
//                   ],
//                   buttonPositions: const [
//                     Offset(55, 520), // Position for Submodule 1
//                     Offset(0, 200), // Position for Submodule 2
//                   ],
//                   iconPaths: const [
//                     'assets/images/tick.svg', // Path to Submodule 3 icon
//                     'assets/images/book.svg', // Path to Submodule 1 icon
//                   ],
//                   navigateActions: [
//                         () => Get.to(() => const Submodule1()),
//                         () => Get.to(() => const Submodule1()),
//                   ],
//                   numberOfQuizzes: const [1, 1],
//                   titleAlignments: const ['left', 'left'],
//                 ),
//             transition: Transition.fade,
//             duration: const Duration(milliseconds: 400));
//       },
//       submoduleCount: 2,
//     ),
//     Module(
//       moduleId: 6,
//       title: 'ملیریا',
//       imagePath: 'assets/images/image9.png',
//       isStart: true,
//       progressValue: 0.5,
//       onTap: () {
//         Get.to(
//                 () =>
//                 JourneyMapScreen(
//                   submoduleTitles: const [
//                     ' ملیریا کے اسباب، پھیلاؤ اور علامات',
//                     'ملیریا کی تشخیص، علاج اور روک تھام',
//                   ],
//                   submoduleDescriptions: const [
//                     'اس سبق میں، آپ ملیریا کے بارے میں سیکھیں گی، جو مچھروں سے پھیلنے والی بیماری ہے۔ یہ انسانوں میں کیسے منتقل ہوتا ہے، دیکھنے کے لئے علامات، اور بیماری کی روک تھام میں مچھروں پر قابو پانے کی اہمیت پر توجہ دی گئ ہے۔',
//                     'اس حصے میں ملیریا کی تشخیص کیسے کی جاتی ہے، علاج  اور مچھروں کے کاٹنے سے بچنے کے لئے مچھر دانیوں اور کیڑوں کو روکنے والی ادویات کا استعمال جیسے احتیاطی اقدامات پر تبادلہ خیال کیا گیا ہے۔',
//                   ],
//                   buttonPositions: const [
//                     Offset(65, 520), // Position for Submodule 1
//                     Offset(30, 200), // Position for Submodule 2
//                   ],
//                   iconPaths: const [
//                     'assets/images/tick.svg', // Path to Submodule 3 icon
//                     'assets/images/book.svg', // Path to Submodule 1 icon
//                   ],
//                   navigateActions: [
//                         () => Get.to(() => const Submodule1()),
//                         () => Get.to(() => const Submodule1()),
//                   ],
//                   numberOfQuizzes: const [1, 1],
//                   titleAlignments: const ['left', 'left'],
//                 ),
//             transition: Transition.fade,
//             duration: const Duration(milliseconds: 400));
//       },
//       submoduleCount: 2,
//     ),
//     Module(
//       moduleId: 7,
//       title: 'ڈینگی',
//       imagePath: 'assets/images/image10.png',
//       isStart: true,
//       progressValue: 0.5,
//       onTap: () {
//         Get.to(
//                 () =>
//                 JourneyMapScreen(
//                   submoduleTitles: const [
//                     'ڈینگی اور اس کا پھیلاؤ',
//                     'ڈینگی کی علامات، تشخیص، علاج اور\n روک تھام',
//                   ],
//                   submoduleDescriptions: const [
//                     'آپ ڈینگی کے بارے میں سیکھیں گی، جو مچھروں کے ذریعے پھیلنے والا وائرل انفیکشن ہے۔ یہ سبق اس بات پر توجہ دیتا ہے کہ ڈینگی کیسے پھیلتا ہے، وہ حالات جو اس کے پھیلاؤ کو بڑھاتے ہیں، اور مچھروں کی افزائش کے مقامات کو کم کرنے کے لئے کھڑے پانی کو ختم کرنے کی اہمیت۔',
//                     'اس سبق میں ڈینگی کی علامات، اس کی تشخیص، دستیاب علاج، اور ڈینگی کی روک تھام کے لئے جامع حکمت عملی بتائی گئی ہے۔  اس میں مچھروں کی آبادی کو کنٹرول کرنے کے لئے کمیونٹی کی کوششیں بھی شامل ہیں۔',
//                   ],
//                   buttonPositions: const [
//                     Offset(130, 520), // Position for Submodule 1
//                     Offset(40, 200), // Position for Submodule 2
//                   ],
//                   iconPaths: const [
//                     'assets/images/tick.svg', // Path to Submodule 3 icon
//                     'assets/images/book.svg', // Path to Submodule 1 icon
//                   ],
//                   navigateActions: [
//                         () => Get.to(() => const Submodule1()),
//                         () => Get.to(() => const Submodule1()),
//                   ],
//                   numberOfQuizzes: const [1, 1],
//                   titleAlignments: const ['left', 'left'],
//                 ),
//             transition: Transition.fade,
//             duration: const Duration(milliseconds: 400));
//       },
//       submoduleCount: 2,
//     ),
//     Module(
//       moduleId: 8,
//       title: 'کرونا وائرس',
//       imagePath: 'assets/images/image11.png',
//       isStart: true,
//       progressValue: 0.5,
//       onTap: () {
//         Get.to(
//                 () =>
//                 JourneyMapScreen(
//                   submoduleTitles: const [
//                     'کورونا کی منتقلی اور علامات',
//                     'کورونا وائرس سے بچاؤ اور\n احتیاتی اقدامات',
//                     'کورونا کے مریض کی دیکھ بھال ',
//                   ],
//                   submoduleDescriptions: const [
//                     'اس سبق میں، آپ کورونا وائرس (کووڈ 19) کے بارے میں سیکھیں گے، بشمول یہ کہ یہ لوگوں کے درمیان کیسے منتقل ہوتا ہے اور متاثرہ افراد کو جو علامات کا سامنا کرنا پڑ سکتا ہے. یہ اس کے پھیلاؤ کو روکنے میں ماسک اور سماجی دوری کی اہمیت کو اجاگر کرتا ہے۔',
//                     'یہ حصہ کورونا وائرس کی منتقلی کو روکنے، کووڈ 19 کے مریضوں کی دیکھ بھال اور ذہنی صحت کی مدد کے بارے میں رہنمائی فراہم کرتا ہے۔ اس میں غذائی تغذیہ کی مدد اور وائرس سے متعلق عام خرافات کو مسترد کرنے پر بھی توجہ دی گئی ہے۔',
//                     'یہ سبق  کوویڈ 19 کے مریضوں کی مؤثر دیکھ بھال اور انتظام کے بارے میں اہم معلومات دیتا ہے ، جس میں حفاظتی اقدامات ، علاج کے پروٹوکول اور مریضوں کی فلاح و بہبود  پر توجہ شامل ہے ۔ یہ مواصلات، ہمدردانہ دیکھ بھال، اور صحت کی دیکھ بھال کی نئی حکمت عملیوں کو اپنانے کی اہمیت پر زور دیتا ہے۔',
//                   ],
//                   buttonPositions: const [
//                     Offset(110, 520), // Position for Submodule 1
//                     Offset(120, 330), // Position for Submodule 1
//                     Offset(45, 200), // Position for Submodule 2
//                   ],
//                   iconPaths: const [
//                     'assets/images/tick.svg', // Path to Submodule 3 icon
//                     'assets/images/book.svg', // Path to Submodule 1 icon
//                     'assets/images/trophy.svg', // Path to Submodule 1 icon
//                   ],
//                   navigateActions: [
//                         () => Get.to(() => const Submodule1()),
//                         () => Get.to(() => const Submodule1()),
//                         () => Get.to(() => const Submodule1()),
//                   ],
//                   numberOfQuizzes: const [1, 1, 1],
//                   titleAlignments: const ['left', 'right', 'left'],
//                 ),
//             transition: Transition.fade,
//             duration: const Duration(milliseconds: 400));
//       },
//       submoduleCount: 2,
//     ),
//   ],
// ),
// Course(
//     courseId: 4,
//     title: 'خاندانی منصوبہ بندی',
//     gradient: const LinearGradient(
//         colors: [Color(0xffF48401), Color(0xffFDD19D)]),
//     quizCount: 1,
//     moduleCount: 1,
//     imagePath: 'assets/images/community.png',
//     isStart: false,
//     isCompleted: true),
// Course(
//     courseId: 5,
//     title: 'رابطه / شخصی رابطہ اور تعلیم صحت',
//     gradient: const LinearGradient(
//         colors: [Color(0xffDCEFDE), Color(0xff4AA153)]),
//     quizCount: 1,
//     moduleCount: 1,
//     imagePath: 'assets/images/3.png',
//     isStart: false,
//     isCompleted: true),
// Course(
//     courseId: 6,
//     title: 'زیچگی کے دوران کی دیکھ بھال',
//     gradient: const LinearGradient(
//         colors: [Color(0xff8E79FB), Color(0xffB09FFD)]),
//     quizCount: 1,
//     moduleCount: 1,
//     imagePath: 'assets/images/1.png',
//     isStart: false,
//     isCompleted: true),
// Course(
//     courseId: 7,
//     title: 'دورانِ حمل نگہداشت',
//     gradient: const LinearGradient(
//         colors: [Color(0xffFE8FB6), Color(0xffF45483)]),
//     quizCount: 1,
//     moduleCount: 1,
//     imagePath: 'assets/images/1.png',
//     isStart: false,
//     isCompleted: true),
