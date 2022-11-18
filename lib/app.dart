import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';
import 'writing_page.dart';

class MoohaApp extends StatelessWidget {
  const MoohaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOOHA',
      theme: ThemeData(
        backgroundColor: const Color(0xFFFFFDF5),
        // scaffoldBackgroundColor: const Color(0xFFFFFDF5),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            )),
        textTheme: const TextTheme(
          headline1: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w600),
          headline2: TextStyle(
              color: Colors.black,
              fontSize: 12.0,
              fontWeight: FontWeight.normal),
          headline3: TextStyle(
              color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.w600),
          bodyText1: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.normal),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
        '/': (BuildContext context) => const HomePage(),
        // '/writePage': (BuildContext context) => const WritingPage(),
      },
    );
  }
}
