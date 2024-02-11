import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhw/InteractiveAnimationVideo/interactive_animation_video.dart';
import 'package:lhw/FlashCard/flash_cards_screen.dart';
import 'package:lhw/Interactive%20Image/LessonOption32.dart';
import 'package:lhw/Login_SignUp/Login.dart';
import 'package:lhw/Quiz_Widgets/question_model.dart';
import 'package:lhw/api/firebase_api.dart';
import 'package:lhw/firebase_options.dart';
import 'package:lhw/loading_screen.dart';
import 'package:lhw/notification/notifications_screen.dart';
import 'package:lhw/repositories/authentication_repository/auth_status.dart';
import 'package:lhw/repositories/authentication_repository/authentication_repository.dart';
import 'package:lhw/Image_Hotspot/ImageHotspot.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'course_tabbar/course_provider.dart';
import 'models/image_hotspot_model.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
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
        home: Obx(() {
          switch (AuthenticationRepository.instance.authStatus.value) {
            case AuthStatus.undecided:
              return const LoadingScreen(); // your loading screen widget
            case AuthStatus.authenticated:
              return FlashCardsScreen(
                  flashCardScreenModel:
                      FlashCardScreenModel(title: "title", cards: [
                FlashCard(
                    frontImage: "assets/images/1.png",
                    heading: "title",
                    titleColor: Colors.black,
                    description: 'asdadasd'),
                FlashCard(
                    frontImage: "assets/images/flashcards/2.png",
                    heading: "title",
                    titleColor: Colors.black,
                    description: 'asdadaddds'),
                FlashCard(
                    frontImage: "assets/images/flashcards/3.png",
                    heading: "title",
                    titleColor: Colors.black,
                    description: 'qeqweqwe'),
                FlashCard(
                    frontImage: "assets/images/flashcards/4.png",
                    heading: "title",
                    titleColor: Colors.black,
                    description: 'qwqweqweqwe'),
                FlashCard(
                    frontImage: "assets/images/flashcards/5.png",
                    heading: "title",
                    titleColor: Colors.black,
                    description: 'qweqewqwe'),
                FlashCard(
                    frontImage: "assets/images/flashcards/6.png",
                    heading: "title",
                    titleColor: Colors.black,
                    description: 'qwqewqweqwe'),
              ]));
            case AuthStatus.unauthenticated:
            default:
              return const LoginScreen();
          }
        }),
      ),
    );
  }
}
