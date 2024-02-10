import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhw/Branching/LessonOption21.dart';
import 'package:lhw/Comic_Strip/comic_strip.dart';
import 'package:lhw/Login_SignUp/Login.dart';
import 'package:lhw/Mobile_Lesson%20&%20Flashcards/Lesson.dart';
import 'package:lhw/Mobile_Lesson%20&%20Flashcards/Lesson_Option20.dart';
import 'package:lhw/Mobile_Lesson%20&%20Flashcards/flash_cards_screen.dart';
import 'package:lhw/Mobile_Lesson%20&%20Flashcards/lesson_page_tabbar.dart';
import 'package:lhw/Presentation/Presentation.dart';
import 'package:lhw/Presentation/presentation_model.dart';
import 'package:lhw/api/firebase_api.dart';
import 'package:lhw/course_tabbar/courses_tabbar.dart';
import 'package:lhw/firebase_options.dart';
import 'package:lhw/loading_screen.dart';
import 'package:lhw/navy.dart';
import 'package:lhw/notification/notifications_screen.dart';
import 'package:lhw/repositories/authentication_repository/auth_status.dart';
import 'package:lhw/repositories/authentication_repository/authentication_repository.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'Presentation/presentation_question_model.dart';
import 'course_tabbar/course_provider.dart';

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
              return const FlashCardsScreen(
                cardData: [
                  {
                    'frontText': ' ٹی۔ بی کیا ہے؟',
                    'backText':
                        'یہ مرض جرثومے، بیکٹیریا کی وجہ سے پھیلتا ہے، جو کہ جسم کے کسی بھی حصے میں رہ سکتا ہے۔',
                  },
                  {
                    'frontText': ' جسم کے کس حصے کو متاثر کرتا ہے؟',
                    'backText':
                    'اس سے جسم کے کئی حصے متاثر ہو سکتے ہیں مثلاً پھیپھڑے، آنتیں ، ہڈیاں ، جوڑ ، گردے وغیرہ,  تاہم پھیپھڑوں کی ٹی بی سب سے زیادہ عام ہے۔',
                  },
                  {
                    'frontText': ' کس عمر کے لوگ زیادہ متاثر ہوتے ہیں؟',
                    'backText':
                    'کسی بھی عمر کا فرد اس سے متاثر ہو سکتا ہے۔  پہلے حملے میں جب جراثیم جسم میں داخل ہوتے ہیں تو اکثر ان کا پتہ نہیں چلتا کیونکہ اس کی علامات بہت معمولی ہوتی ہیں۔  لیکن ایسے افراد جن کی قوت مدافعت کم ہو، وہ پہلے حملے میں ہی متاثر ہو سکتے ہیں۔ ',
                  },
                ],
              );
            case AuthStatus.unauthenticated:
            default:
              return const LoginScreen();
          }
        }),
      ),
    );
  }
}
