import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mooha/provider/ApplicationState.dart';
import 'package:mooha/services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

User? user = FirebaseAuth.instance.currentUser;

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        centerTitle: true,
        title: Text(
          '일기장',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Consumer<ApplicationsState>(
                builder: (context, appState, _) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DiaryList(
                      detail: appState.diaryDetail,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class DiaryList extends StatefulWidget {
  const DiaryList({Key? key, required this.detail}) : super(key: key);
  final List<DiaryDetail> detail;
  @override
  State<DiaryList> createState() => _DiaryListState();
}

class _DiaryListState extends State<DiaryList> {
  Map mood = {
    1: 'smile',
    2: 'angry',
    3: 'dizzy',
    4: 'expressionless',
    5: 'frown',
    6: 'laughing',
    7: 'sunglasses',
  };
  // final year = DateFormat('yyyy').format(checkedDate);
  //   final monthAndDay = DateFormat('MM월 dd일').format(checkedDate);
  //   final dayOfWeek = DateFormat.E('ko_KR').format(checkedDate);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .collection('diary')
          .orderBy('datetime', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            itemCount: widget.detail.length,
            itemBuilder: ((context, index) {
              late DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              return Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/emoji-${mood[documentSnapshot['emoji']]}.png',
                          width: 32,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(DateFormat('yyyy')
                                .format(documentSnapshot['datetime'].toDate())),
                            Text(DateFormat('MM월 dd일')
                                .format(documentSnapshot['datetime'].toDate()))
                          ],
                        )
                      ],
                    ),
                    Text(documentSnapshot['title']),
                    Text(documentSnapshot['content']),
                  ],
                ),
              );
            }),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
