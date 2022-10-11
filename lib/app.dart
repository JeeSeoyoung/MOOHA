import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';

class MoohaApp extends StatelessWidget {
  const MoohaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOOHA',
      theme: ThemeData(
        backgroundColor: const Color(0xFFFFFDF5),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
        '/': (BuildContext context) => const HomePage(),
      },
    );
  }
}
