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
import 'LoginSignUp/Login.dart';
import 'package:lhw/Database/database_helper.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  // Use UserService to check if the user is logged in
  bool isLoggedIn = await UserService.isLoggedIn();
  await DataManager.insertCoursesFromJson();
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
      // Changed to MultiProvider for future extensibility
      providers: [
        ChangeNotifierProvider(create: (context) => CoursesProvider()),
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

// class CoursesScreenTest extends StatefulWidget {
//   @override
//   _CoursesScreenTestState createState() => _CoursesScreenTestState();
// }

// class _CoursesScreenTestState extends State<CoursesScreenTest> {
//   late List<Course> _courses;
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }
//
//   Future _loadData() async {
//     await DataManager.insertCoursesFromJson();
//     _refreshCourses();
//   }
//
//   Future _refreshCourses() async {
//     _courses = await DatabaseHelper.instance.courses();
//     setState(() => _isLoading = false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Courses'),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _courses.length,
//               itemBuilder: (context, index) {
//                 final course = _courses[index];
//                 return Card(
//                     child: Container(
//                   decoration: const BoxDecoration(),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Course ID: ${course.courseId}",
//                             style: const TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold)),
//                         Text("Title: ${course.title}",
//                             style: const TextStyle(fontSize: 16)),
//                         Text("Quiz Count: ${course.quizCount}",
//                             style: const TextStyle(fontSize: 14)),
//                         Text("Module Count: ${course.moduleCount}",
//                             style: const TextStyle(fontSize: 14)),
//                         Text("Image Path: ${course.imagePath}",
//                             style: const TextStyle(fontSize: 14)),
//                         Text("Is Started: ${course.isStart ? 'Yes' : 'No'}",
//                             style: const TextStyle(fontSize: 14)),
//                         Text(
//                             "Is Completed: ${course.isCompleted ? 'Yes' : 'No'}",
//                             style: const TextStyle(fontSize: 14)),
//                         Text("Progress: ${course.progress * 100}%",
//                             style: const TextStyle(fontSize: 14)),
//                         Text("Arrow Text: ${course.arrowText}",
//                             style: const TextStyle(fontSize: 14)),
//                         const SizedBox(height: 10),
//                         const Text("Modules:",
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold)),
//                         ...course.modules.map(
//                           (module) => Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("- Module ID: ${module.moduleId}",
//                                     style: const TextStyle(fontSize: 14)),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 16.0),
//                                   child: Text("Title: ${module.title}",
//                                       style: const TextStyle(fontSize: 14)),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 16.0),
//                                   child: Text("Image Path: ${module.imagePath}",
//                                       style: const TextStyle(fontSize: 14)),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 16.0),
//                                   child: Text(
//                                       "Submodule Count: ${module.submoduleCount}",
//                                       style: const TextStyle(fontSize: 14)),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 16.0),
//                                   child: Text(
//                                       "Is Started: ${module.isStart ? 'Yes' : 'No'}",
//                                       style: const TextStyle(fontSize: 14)),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 16.0),
//                                   child: Text(
//                                       "Is Completed: ${module.isCompleted ? 'Yes' : 'No'}",
//                                       style: const TextStyle(fontSize: 14)),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 16.0),
//                                   child: Text(
//                                       "Progress Value: ${module.progressValue * 100}%",
//                                       style: const TextStyle(fontSize: 14)),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 const Text("Submodules:",
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold)),
//                                 ...module.submodules
//                                     .map(
//                                       (submodule) => Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 32.0, top: 8.0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                                 "- Submodule ID: ${submodule.submoduleId}",
//                                                 style: const TextStyle(
//                                                     fontSize: 14)),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 16.0),
//                                               child: Text(
//                                                   "Title: ${submodule.title}",
//                                                   style: const TextStyle(
//                                                       fontSize: 14)),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 16.0),
//                                               child: Text(
//                                                   "Description: ${submodule.description}",
//                                                   style: const TextStyle(
//                                                       fontSize: 14)),
//                                             ),
//                                             // Display Features here
//                                             const Text("Features:",
//                                                 style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight:
//                                                         FontWeight.bold)),
//                                             ...submodule.features
//                                                 .map(
//                                                   (feature) => Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 32.0,
//                                                             top: 8.0),
//                                                     child: Text(
//                                                         "- Feature Name: ${feature.featureType}",
//                                                         style: const TextStyle(
//                                                             fontSize: 14)),
//                                                   ),
//                                                 )
//                                                 .toList(),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                     .toList(),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ));
//               },
//             ),
//     );
//   }
// }
