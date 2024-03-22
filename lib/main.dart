import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhw/Branching/LessonOption25.dart';
import 'package:lhw/CourseTabbar/courses_tabbar.dart';
import 'package:lhw/LoginSignUp/Onboarding.dart';
import 'package:lhw/Quiz/MCQ%204.dart';
import 'package:lhw/Quiz/MCQ%205.dart';
import 'package:lhw/Quiz/MCQ%206.dart';
import 'package:lhw/Quiz/True%20False/True_False_01.dart';
import 'package:lhw/Quiz/True%20False/True_False_02.dart';
import 'package:lhw/Quiz/True%20False/True_False_03.dart';
import 'package:lhw/Splash/splash.dart';
import 'package:lhw/Test/Features/ObjectivesTreeHorizontal.dart';
import 'package:lhw/loading_screen.dart';
import 'package:lhw/navy.dart';
import 'package:lhw/services/global_user.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:lhw/services/user_service.dart';
import 'CourseTabbar/course_provider.dart';
import 'Database/data_manager.dart';
import 'LoginSignUp/Login.dart';
import 'models/user_model.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await UserService.isLoggedIn();
  await DataManager.insertCoursesFromJson();
  await DataManager.insertUsersFromJson();
  final User? user = await UserService.loadUser();
  if (user != null) {
    GlobalUser.updateUser(user);
  }
  runApp(MyApp(isLoggedIn: isLoggedIn));
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
        ChangeNotifierProvider(create: (context) => TabIndexProvider()),
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
        home: isLoggedIn ?  const Custom_NavBar() : const SplashScreenLHW(),
      ),
    );
  }
}
