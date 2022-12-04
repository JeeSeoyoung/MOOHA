import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mooha/provider/ApplicationState.dart';
import 'package:mooha/services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

User? user = FirebaseAuth.instance.currentUser;

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        children: [
          Column(
            children: [
              Consumer<ApplicationsState>(
                builder: (context, appState, _) => DiaryList(
                  detail: appState.diaryDetail,
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
    1: 'laughing',
    2: 'expressionless',
    3: 'sunglasses',
    4: 'dizzy',
    5: 'frown',
    6: 'angry',
  };
  // final year = DateFormat('yyyy').format(checkedDate);
  //   final monthAndDay = DateFormat('MM월 dd일').format(checkedDate);
  //   final dayOfWeek = DateFormat.E('ko_KR').format(checkedDate);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const ScrollPhysics(),
      itemCount: widget.detail.length,
      itemBuilder: ((context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  EmojiIcon(mood: mood, widget: widget, index: index),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('yyyy')
                            .format(widget.detail[index].datetime),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        DateFormat('MM월 dd일')
                            .format(widget.detail[index].datetime),
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.detail[index].title,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const Divider(
                      height: 30,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    Text(widget.detail[index].content),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class EmojiIcon extends StatelessWidget {
  const EmojiIcon({
    Key? key,
    required this.mood,
    required this.widget,
    required this.index,
  }) : super(key: key);

  final Map mood;
  final DiaryList widget;
  final int index;

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
    return ColorFiltered(
      colorFilter: color[widget.detail[index].emoji],
      child:
          Image.asset('assets/emoji-${mood[widget.detail[index].emoji]}.png'),
    );
  }
}
