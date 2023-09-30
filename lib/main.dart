import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhw/Branching/LessonOption21.dart';
import 'package:lhw/Branching/LessonOption24.dart';
import 'package:lhw/Branching/LessonOption25.dart';
import 'package:lhw/Discussion_Group/MessageScreen.dart';
import 'package:lhw/Image_Hotspot/LessonOption26.dart';
import 'package:lhw/Mobile_HomePage/Courses_All%20Courses.dart';
import 'package:lhw/Mobile_HomePage/Courses_Completed.dart';
import 'package:lhw/Mobile_HomePage/Courses_Ongoing.dart';
import 'package:lhw/Mobile_HomePage/Courses_SearchDropDown.dart';
import 'package:lhw/Mobile_HomePage/Courses_tabbar.dart';
import 'package:lhw/Mobile_HomePage/Search_DropDown.dart';
import 'package:lhw/Mobile_Lesson%20&%20Flashcards/Lesson.dart';
import 'package:lhw/Mobile_Lesson%20&%20Flashcards/Lesson_Option20.dart';
import 'package:lhw/Mobile_Lesson%20&%20Flashcards/lesson_page_tabbar.dart';
import 'package:lhw/Mobile_Module%20&%20Submodule/Course_dropdown%20open%20view.dart';
import 'package:lhw/Mobile_Module%20&%20Submodule/Course_dropdown%20openview%202.dart';
import 'package:lhw/Presentation/Presentation.dart';
import 'package:lhw/Reports/Reports_Learning.dart';
import 'package:lhw/Result/Presentation.dart';
import 'package:lhw/Result/Score.dart';
import 'package:lhw/Settings/SettingsPage.dart';
import 'package:lhw/navy.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'Login_SignUp/Login.dart';
import 'Mobile_HomePage/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Override for HTTP behavior due to certificate issues.
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home:  Score(),
    );
  }
}
