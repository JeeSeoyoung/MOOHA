import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'edit_page.dart';

User? user = FirebaseAuth.instance.currentUser;

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.document}) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> document;
  void deleteDoc(QueryDocumentSnapshot documentSnapshot) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('diary')
        .doc(documentSnapshot.id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    Map mood = {
      0: 'smile',
      1: 'laughing',
      2: 'expressionless',
      3: 'sunglasses',
      4: 'dizzy',
      5: 'frown',
      6: 'angry',
    };
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
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        EmojiIcon(
                          mood: mood,
                          document: document,
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('yyyy')
                                  .format(document.data()['datetime'].toDate()),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              DateFormat('MM월 dd일')
                                  .format(document.data()['datetime'].toDate()),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            document.data()['title'],
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          const Divider(
                            height: 30,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          Text(document.data()['content']),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            deleteDoc(document);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            '삭제',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditingPage(
                                          document: document,
                                        )));
                          },
                          child: const Text('수정'),
                        ),
                      ],
                    )
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

class EmojiIcon extends StatelessWidget {
  const EmojiIcon({Key? key, required this.mood, required this.document})
      : super(key: key);

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
    return ColorFiltered(
      colorFilter: color[document.data()['emoji']],
      child: Image.asset('assets/emoji-${mood[document.data()['emoji']]}.png'),
    );
  }
}
