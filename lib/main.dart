import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhw/Branching/LessonOption21.dart';
import 'package:lhw/Branching/LessonOption33.dart';
import 'package:lhw/Login_SignUp/Forgot_Password.dart';
import 'package:lhw/Login_SignUp/Login.dart';
import 'package:lhw/Login_SignUp/SignUp.dart';
import 'package:lhw/Mobile_Module%20&%20Submodule/Course_dropdown%20open%20view.dart';
import 'package:lhw/Mobile_Module%20&%20Submodule/Course_dropdown%20openview%202.dart';
import 'package:lhw/Presentation/Presentation.dart';
import 'package:lhw/Profile/edit_profile.dart';
import 'package:lhw/Quiz/DragDrop/DragDrop.dart';
import 'package:lhw/Reports/Reports_Learning.dart';
import 'package:lhw/Settings/SettingsPage.dart';
import 'package:lhw/api/firebase_api.dart';
import 'package:lhw/firebase_options.dart';
import 'package:lhw/loading_screen.dart';
import 'package:lhw/notification/notifications_screen.dart';
import 'package:lhw/repositories/authentication_repository/authentication_repository.dart';
import 'package:responsive_framework/responsive_framework.dart';


final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  //     .then((value) => Get.put(AuthenticationRepository()));
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
      routes: {
        '/notification_screen' : (context) =>  NotificationScreen()
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
      home: LoginScreen(),
    );
  }
}
