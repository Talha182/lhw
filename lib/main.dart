import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhw/CourseTabbar/courses_tabbar.dart';
import 'package:lhw/api/firebase_api.dart';
import 'package:lhw/firebase_options.dart';
import 'package:lhw/loading_screen.dart';
import 'package:lhw/navy.dart';
import 'package:lhw/notification/notifications_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CourseTabbar/course_provider.dart';
import 'LoginSignUp/Login.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;


  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(isLoggedIn: isLoggedIn,),
  ));
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

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CoursesProvider(),
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        routes: {
          '/notification_screen': (context) => const NotificationScreen()
        },
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
        home: isLoggedIn ? const Custom_NavBar() : const LoginScreen(),
      ),
    );
  }
}
