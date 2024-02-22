import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhw/navy.dart';
import 'package:lhw/notification/notifications_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:lhw/services/user_service.dart'; // Adjust the import path as needed
import 'CourseTabbar/course_provider.dart';
import 'FloorDatabase/database.dart';
import 'FloorDatabase/database_initializer.dart';
import 'LoginSignUp/Login.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  // Initialize the database and insert initial data
  final appDatabase = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  DatabaseInitializer(appDatabase).insertInitialData();

  // Use UserService to check if the user is logged in
  bool isLoggedIn = await UserService.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn, database: appDatabase));
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
  final AppDatabase database; // Add this line

  const MyApp({Key? key, required this.isLoggedIn, required this.database}) : super(key: key); // Update constructor

  @override
  Widget build(BuildContext context) {
    return MultiProvider( // Changed to MultiProvider for future extensibility
      providers: [
        ChangeNotifierProvider(create: (context) => CoursesProvider()),
        Provider<AppDatabase>.value(value: database), // Provide the database to the widget tree
      ],
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
