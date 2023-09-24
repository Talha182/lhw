import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lhw/Comic_Strip/comic_strip.dart';
import 'package:lhw/Mobile_HomePage/home_page.dart';
import 'package:lhw/Mobile_HomePage/tab_bar.dart';
import 'package:lhw/Reports/Help.dart';
import 'package:lhw/Reports/Reports_Learning.dart';
import 'package:lhw/Reports/Resources_Tabbar.dart';
import 'package:lhw/custom_widgets/custom_navbar.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'navy.dart';
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
    return MaterialApp(
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
      home: ComicStrip(),
    );
  }
}
