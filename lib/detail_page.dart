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
    0: 'smile',
    1: 'angry',
    2: 'dizzy',
    3: 'expressionless',
    4: 'frown',
    5: 'laughing',
    6: 'sunglasses',
  };
  // final year = DateFormat('yyyy').format(checkedDate);
  //   final monthAndDay = DateFormat('MM월 dd일').format(checkedDate);
  //   final dayOfWeek = DateFormat.E('ko_KR').format(checkedDate);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      itemCount: widget.detail.length,
      itemBuilder: ((context, index) {
        return Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Text(widget.detail[index].title),
                  Image.asset(
                    'assets/emoji-${mood[widget.detail[index].emoji]}.png',
                    width: 32,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat('yyyy')
                          .format(widget.detail[index].datetime)),
                      Text(DateFormat('MM월 dd일')
                          .format(widget.detail[index].datetime))
                    ],
                  )
                ],
              ),
              Text(widget.detail[index].title),
              Text(widget.detail[index].content),
            ],
          ),
        );
      }),
    );
  }
}
