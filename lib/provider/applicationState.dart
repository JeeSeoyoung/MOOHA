import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mooha/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class ApplicationsState extends ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;
  StreamSubscription<QuerySnapshot>? _diaryStreamSubscription;
  List<DiaryDetail> _diaryDetail = [];
  List<DiaryDetail> get diaryDetail => _diaryDetail;
  Map mood = {
    1: 'smile',
    2: 'angry',
    3: 'dizzy',
    4: 'expressionless',
    5: 'frown',
    6: 'laughing',
    7: 'sunglasses',
  };

  // static final Widget _eventIcon = Container(
  //     child: Image.asset(
  //   'assets/emoji-dizzy.png',
  // ));
  // List<List<dynamic>> _markedDateList = [];
  // List<List<dynamic>> get markedDateList => _markedDateList;

  late EventList<Event> _markedDateList = EventList<Event>(
    events: {},
  );
  EventList<Event> get markedDateList => _markedDateList;

  ApplicationsState() {
    init();
  }
  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    if (user != null) {
      print('Login ~~~~~~~~~~~~~~~~~~~~~~');
      _diaryStreamSubscription = FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .collection('diary')
          .snapshots()
          .listen((snapshot) {
        _diaryDetail = [];
        _markedDateList = EventList(events: {});
        // _markedDateList = [];
        for (final document in snapshot.docs) {
          _diaryDetail.add(
            DiaryDetail(
                datetime: document.data()['datetime'].toDate(),
                uid: document.data()['uid'] as String,
                title: document.data()['title'] as String,
                content: document.data()['content'] as String,
                emoji: document.data()['emoji']),
          );
          _markedDateList.add(
              document.data()['datetime'].toDate(),
              Event(
                  date: document.data()['datetime'].toDate(),
                  icon: Container(
                      child: Image.asset(
                    'assets/emoji-${mood[document.data()['emoji']]}.png',
                  ))));
          print(document.data()['datetime']);
        }
        notifyListeners();
      });
    } else {
      print('Log Out~~~~~~~~~~~~~~~~~~~~~~~~~~~');
      _diaryDetail = [];
      _markedDateList = EventList(events: {});
    }
    notifyListeners();

    FirebaseAuth.instance.userChanges().listen((user) {});
  }

  Future<DocumentReference> createDiaryDocs(
      DateTime datetime, String title, String content, int emoji) {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('diary')
        .add(<String, dynamic>{
      'datetime': datetime,
      'uid': user!.uid,
      'title': title,
      'content': content,
      'emoji': emoji,
    });
  }

  Future addCalenderEmoji() async {
    var snapshots = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('diary')
        .snapshots();
    await for (var snapshot in snapshots) {
      for (var diary in snapshot.docs) {
        print(diary.get('emoji'));
      }
    }
  }
}

class DiaryDetail {
  final DateTime datetime;
  final String uid;
  final String title;
  final String content;
  final int emoji;

  DiaryDetail({
    required this.datetime,
    required this.uid,
    required this.title,
    required this.content,
    required this.emoji,
  });
}
