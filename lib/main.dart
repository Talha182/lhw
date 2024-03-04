import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhw/CourseTabbar/courses_tabbar.dart';
import 'package:lhw/navy.dart';
import 'package:lhw/notification/notifications_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:lhw/services/user_service.dart'; // Adjust the import path as needed
import 'CourseTabbar/course_provider.dart';
import 'Database/data_manager.dart';
import 'LoginSignUp/Login.dart';
import 'package:lhw/Database/database_helper.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  bool isLoggedIn = await UserService.isLoggedIn();
  await DataManager.insertCoursesFromJson();
  await DataManager.insertUsersFromJson();
  final dbHelper = DatabaseHelper.instance;
  dbHelper.printAllUserData();
  // dbHelper.printAllCourseData();
  runApp(MyApp(isLoggedIn: isLoggedIn));
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
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn})
      : super(key: key); // Update constructor

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CoursesProvider()),
      ],
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
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
        home: isLoggedIn ? const Courses_Tabbar() : const LoginScreen(),
      ),
    );
  }
}

