import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mooha/provider/ApplicationState.dart';

int modifiedEmoji = 0;

class EditingPage extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  EditingPage({Key? key, required this.document}) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> document;
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();

  void updateDoc(String title, String content, int emoji) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('diary')
        .doc(document.id)
        .update({
      'modifyTimeStamp': FieldValue.serverTimestamp(),
      'title': title,
      'content': content,
      'emoji': emoji,
    });
  }

  @override
  Widget build(BuildContext context) {
    final year =
        DateFormat('yyyy').format(document.data()['datetime'].toDate());
    final monthAndDay =
        DateFormat('MM월 dd일').format(document.data()['datetime'].toDate());
    final dayOfWeek =
        DateFormat.E('ko_KR').format(document.data()['datetime'].toDate());
    Map mood = {
      0: 'smile',
      1: 'laughing',
      2: 'expressionless',
      3: 'sunglasses',
      4: 'dizzy',
      5: 'frown',
      6: 'angry',
    };
    _titleController.text = document.data()['title'];
    _contentController.text = document.data()['content'];
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        centerTitle: true,
        title: Text(
          '수정하기',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${year}',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  '${monthAndDay} ${dayOfWeek}요일',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(height: 30.0),
                Text(
                  '오늘의 기분을 이모지로 기록해요',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 20.0),
                MoodButtons(
                  emoji: document.data()['emoji'],
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.all(30.0),
                  height: 300.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      )),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration:
                            const InputDecoration(hintText: '제목을 입력하세요'),
                      ),
                      Scrollbar(
                        child: SizedBox(
                          height: 190,
                          child: TextField(
                            controller: _contentController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                hintText: '내용을 입력하세요',
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                    onPressed: () {
                      updateDoc(_titleController.text, _contentController.text,
                          modifiedEmoji);
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text('수정하기'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MoodButtons extends StatefulWidget {
  MoodButtons({
    Key? key,
    required this.emoji,
  }) : super(key: key);
  int emoji;

  @override
  State<MoodButtons> createState() => _MoodButtonsState();
}

class _MoodButtonsState extends State<MoodButtons> {
  Widget CustomRadioButton(String text, int index, ColorFilter color) {
    // int value = widget.emoji;
    // index = 1;
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.emoji = index;
          modifiedEmoji = widget.emoji;
        });
      },
      child: ColorFiltered(
        colorFilter: (widget.emoji == index)
            ? color
            : const ColorFilter.mode(Colors.white, BlendMode.modulate),
        child: Image.asset('assets/${text}.png'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomRadioButton('emoji-smile', 0,
            ColorFilter.mode(Colors.yellowAccent, BlendMode.modulate)),
        CustomRadioButton('emoji-laughing', 1,
            ColorFilter.mode(Colors.amberAccent, BlendMode.modulate)),
        CustomRadioButton('emoji-expressionless', 2,
            ColorFilter.mode(Colors.lightGreenAccent, BlendMode.modulate)),
        CustomRadioButton('emoji-sunglasses', 3,
            ColorFilter.mode(Colors.tealAccent, BlendMode.modulate)),
        CustomRadioButton('emoji-dizzy', 4,
            ColorFilter.mode(Colors.lightBlueAccent, BlendMode.modulate)),
        CustomRadioButton('emoji-frown', 5,
            ColorFilter.mode(Colors.purpleAccent, BlendMode.modulate)),
        CustomRadioButton('emoji-angry', 6,
            ColorFilter.mode(Colors.redAccent, BlendMode.modulate)),
      ],
    );
  }
}
