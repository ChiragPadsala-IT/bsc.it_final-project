import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';
import 'package:quotes/screen/admin/quotes_category_list__screen.dart';
import 'package:quotes/screen/category_list_display_screen/category_list_screen.dart';
import 'package:quotes/screen/display_screen/display_screen.dart';
import 'package:quotes/screen/home/home_screen.dart';
import 'package:quotes/screen/login/login_screen.dart';
import 'package:quotes/screen/profile_screen/profile_screen.dart';
import 'package:quotes/screen/quote_write_screen/quote_write_screen.dart';
import 'package:quotes/screen/signup/signup_screen.dart';
import 'package:quotes/screen/splash/splash_screen.dart';
import 'package:quotes/screen/usefull_quotes_screen/usefull_quotes_screen.dart';
import 'package:quotes/screen/user_list_screen/user_list_screen.dart';

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
      initialRoute: SplashScreen.path,
      color: Colors.indigo,
      title: "MyQuotes",
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
          name: DisplayScreen.path,
          page: () => DisplayScreen(),
        ),
        GetPage(
          name: ProfileScreen.path,
          page: () => ProfileScreen(),
        ),
        GetPage(
          name: QuotesCategoryListScreen.path,
          page: () => QuotesCategoryListScreen(),
        ),
        GetPage(
          name: CategoryListScreen.path,
          page: () => CategoryListScreen(),
        ),
        GetPage(
          name: QuoteWriteScreen.path,
          page: () => QuoteWriteScreen(),
        ),
        GetPage(
          name: UserListScreen.path,
          page: () => UserListScreen(),
        ),
        GetPage(
          name: UseFullQuotesScreen.path,
          page: () => const UseFullQuotesScreen(),
        ),
      ],
      theme: ThemeData(
        textTheme: const TextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.indigo[900]),
          ),
        ),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.indigo[900]),
      ),
    );
  }
}
