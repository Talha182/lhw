import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lhw/Profile/Profile.dart';
import 'package:lhw/Profile/edit_profile.dart';
import 'package:lhw/Quiz/MCQ%204.dart';
import 'package:lhw/Reports/Reports_Learning.dart';
import 'package:lhw/Settings/SettingsPage.dart';
import 'package:lhw/Settings/data.dart';
import 'package:lhw/demo.dart';
import 'package:lhw/notification/notifications_screen.dart';
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
      home: ReportsScreen(),
    );
  }
}
