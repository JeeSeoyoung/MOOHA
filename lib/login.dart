import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mooha/services/firebase_auth_methods.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<UserCredential?> LoginWithGoogle(BuildContext context) async {
    GoogleSignInAccount? user = await FirebaseAuthMethods.login();

    GoogleSignInAuthentication? googleAuth = await user!.authentication;
    var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    UserCredential? userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential != null) {
      print('login success ====> Google');
      print(userCredential);

      Navigator.pop(context);
    } else {
      print('login fail');
    }
    return userCredential;
  }

  Future AddUser() async {
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName;
    final email = user?.email;
    final uid = user?.uid;
    final docUser = FirebaseFirestore.instance.collection('user').doc(uid);
    final json = {
      'name': name,
      'email': email,
      'uid': uid,
    };
    await docUser.set(json);
  }

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
                SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () async {
                    await LoginWithGoogle(context);
                    AddUser();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
