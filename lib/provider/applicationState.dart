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

import '../detail_page.dart';

class ApplicationsState extends ChangeNotifier {
  ApplicationsState() {
    init();
  }
  User? user = FirebaseAuth.instance.currentUser;
  StreamSubscription<QuerySnapshot>? _diaryStreamSubscription;
  Map mood = {
    0: 'smile',
    1: 'laughing',
    2: 'expressionless',
    3: 'sunglasses',
    4: 'dizzy',
    5: 'frown',
    6: 'angry',
  };

  List<DiaryDetail> _diaryDetail = [];
  List<DiaryDetail> get diaryDetail => _diaryDetail;
  EventList<Event> _markedDateList = EventList<Event>(
    events: {},
  );
  EventList<Event> get markedDateList => _markedDateList;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    _diaryDetail = [];
    _markedDateList = EventList(events: {});
    GetList(user);

    FirebaseAuth.instance.userChanges().listen((user) {
      GetList(user);

      notifyListeners();
    });
  }

  Future<void> GetList(User? user) async {
    if (user != null) {
      print('Login ~~~~~~~~~~~~~~~~~~~~~~');
      _diaryStreamSubscription = FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .collection('diary')
          .orderBy('datetime', descending: true)
          .snapshots()
          .listen((snapshot) {
        _diaryDetail = [];
        _markedDateList = new EventList(events: {});
        for (final document in snapshot.docs) {
          _markedDateList.add(
              document.data()['datetime'].toDate(),
              Event(
                date: document.data()['datetime'].toDate(),
                title: document.data()['title'],
                icon: EmojiIcon(mood: mood, document: document),
                // icon: Image.asset(
                //   'assets/emoji-${mood[document.data()['emoji']]}.png',
                // ),
              ));
          _diaryDetail.add(
            DiaryDetail(
                datetime: document.data()['datetime'].toDate(),
                uid: document.data()['uid'] as String,
                title: document.data()['title'] as String,
                content: document.data()['content'] as String,
                emoji: document.data()['emoji']),
          );
        }
        notifyListeners();
      });
    } else {
      print('Log Out~~~~~~~~~~~~~~~~~~~~~~~~~~~');
      _diaryDetail = [];
      _markedDateList = EventList(events: {});
      _diaryStreamSubscription?.cancel();
    }
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

class EmojiIcon extends StatelessWidget {
  const EmojiIcon({
    Key? key,
    required this.mood,
    required this.document,
  }) : super(key: key);

  final Map mood;
  final QueryDocumentSnapshot<Map<String, dynamic>> document;

  @override
  Widget build(BuildContext context) {
    Map color = {
      0: const ColorFilter.mode(Colors.yellowAccent, BlendMode.modulate),
      1: const ColorFilter.mode(Colors.amberAccent, BlendMode.modulate),
      2: const ColorFilter.mode(Colors.lightGreenAccent, BlendMode.modulate),
      3: const ColorFilter.mode(Colors.tealAccent, BlendMode.modulate),
      4: const ColorFilter.mode(Colors.lightBlueAccent, BlendMode.modulate),
      5: const ColorFilter.mode(Colors.purpleAccent, BlendMode.modulate),
      6: const ColorFilter.mode(Colors.redAccent, BlendMode.modulate),
    };
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/DetailPage');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      document: document,
                    )));
      },
      child: ColorFiltered(
        colorFilter: color[document.data()['emoji']],
        child:
            Image.asset('assets/emoji-${mood[document.data()['emoji']]}.png'),
      ),
    );
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
