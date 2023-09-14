import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lhw/Branching/LessonOption21.dart';
import 'package:lhw/Mobile_HomePage/Courses_Ongoing.dart';
import 'package:lhw/Mobile_HomePage/home_page.dart';
import 'package:lhw/Mobile_HomePage/tab_bar.dart';
import 'package:lhw/Mobile_Module%20&%20Submodule/Course_dropdown%20open%20view.dart';
import 'package:lhw/Quiz/True%20False/True_False_03.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    /* SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));*/
    return MaterialApp(

      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home:  Course_DropDown(),
      debugShowCheckedModeBanner: false,
    );
  }
}