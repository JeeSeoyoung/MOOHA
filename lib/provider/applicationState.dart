import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mooha/firebase_options.dart';
import 'package:provider/provider.dart';

class ApplicationsState extends ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;
  ApplicationsState() {
    init();
  }
  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  Future<DocumentReference> createDiaryDocs(
      DateTime datetime, String title, String content) {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('diary')
        .add(<String, dynamic>{
      'datetime': datetime,
      'uid': user!.uid,
      'title': title,
      'content': content,
    });
  }
}

class DiaryDetail {
  final DateTime datetime;
  final String uid;
  final String title;
  final String content;

  DiaryDetail({
    required this.datetime,
    required this.uid,
    required this.title,
    required this.content,
  });
}
