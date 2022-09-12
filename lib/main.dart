import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:expense_planner/home_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              cardColor: Colors.white,
              primaryColor: const Color(0XFF0785D8),
              textTheme: ThemeData.dark().textTheme.copyWith(
                    titleLarge: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Quicksand',
                    ),
                    titleSmall: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Quicksand',
                    ),
                    titleMedium: const TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.black,
                    ),
                    bodyMedium: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: 'Quicksand',
                      color: Colors.black,
                    ),
                  ),
              appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                backgroundColor: Color(0XFF0785D8),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: const Color(0XFF0785D8),
                ),
              ),
            ),
            home: const MyHomePage(title: 'Expense Planner'),
          );
  }
}
