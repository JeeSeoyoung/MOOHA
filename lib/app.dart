import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';
import 'writingPage.dart';

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
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
        '/': (BuildContext context) => const HomePage(),
        '/writePage': (BuildContext context) => const WritingPage(),
      },
    );
  }
}
