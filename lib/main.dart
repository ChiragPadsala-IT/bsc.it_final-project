import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';
import 'package:quotes/home/home_screen.dart';
import 'package:quotes/login/login_screen.dart';
import 'package:quotes/screen/quotes_screen.dart';
import 'package:quotes/signup/signup_screen.dart';
import 'package:quotes/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: SplashScreen.path,
      initialRoute: LoginScreen.path,
      getPages: [
        GetPage(
          name: SplashScreen.path,
          page: () => SplashScreen(),
        ),
        GetPage(
          name: LoginScreen.path,
          page: () => LoginScreen(),
        ),
        GetPage(
          name: SignUpScreen.path,
          page: () => SignUpScreen(),
        ),
        GetPage(
          name: HomeScreen.path,
          page: () => HomeScreen(),
        ),
        GetPage(
          name: QuotesScreen.path,
          page: () => QuotesScreen(),
        ),
      ],
    );
  }
}
