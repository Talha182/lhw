import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhw/Bookmarks.dart';
import 'package:lhw/Branching/LessonOption21.dart';
import 'package:lhw/Branching/LessonOption24.dart';
import 'package:lhw/Comic_Strip/comic_strip.dart';
import 'package:lhw/Image_Hotspot/LessonOption26.dart';
import 'package:lhw/Interactive%20Image/LessonOption32.dart';
import 'package:lhw/Login_SignUp/Login.dart';
import 'package:lhw/Mobile_Lesson%20&%20Flashcards/Lesson_Option20.dart';
import 'package:lhw/Mobile_Lesson%20&%20Flashcards/lesson_page_tabbar.dart';
import 'package:lhw/Mobile_Module%20&%20Submodule/Course_dropdown%20open%20view.dart';
import 'package:lhw/Presentation/Presentation.dart';
import 'package:lhw/Quiz/MCQ%204.dart';
import 'package:lhw/Quiz/MCQ%205.dart';
import 'package:lhw/Quiz/MCQ%206.dart';
import 'package:lhw/Result/ResultScreen.dart';
import 'package:lhw/api/firebase_api.dart';
import 'package:lhw/firebase_options.dart';
import 'package:lhw/loading_screen.dart';
import 'package:lhw/notification/notifications_screen.dart';
import 'package:lhw/repositories/authentication_repository/auth_status.dart';
import 'package:lhw/repositories/authentication_repository/authentication_repository.dart';
import 'package:lhw/test/Features/InteractiveImage.dart';
import 'package:lhw/test/Features/ObjectivesTree.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'Mobile_Lesson & Flashcards/Lesson.dart';
import 'navy.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();

  runApp(const MaterialApp(
    home: MyApp(),
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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      routes: {'/notification_screen': (context) => const NotificationScreen()},
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

      home: Obx(() {
        switch (AuthenticationRepository.instance.authStatus.value) {
          case AuthStatus.undecided:
            return const LoadingScreen();  // your loading screen widget
          case AuthStatus.authenticated:
            return const LessonOption20();
          case AuthStatus.unauthenticated:
          default:
            return const LoginScreen();
        }
      }),
    );
  }
}
