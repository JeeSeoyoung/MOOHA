import 'package:flutter/material.dart';

import 'login.dart';

class MoohaApp extends StatelessWidget {
  const MoohaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOOHA',
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
      },
    );
  }
}
