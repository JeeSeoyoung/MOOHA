import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 250,
                ),
                Image.asset('assets/logo.png'),
                const SizedBox(
                  height: 87,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Sign in with Google'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
