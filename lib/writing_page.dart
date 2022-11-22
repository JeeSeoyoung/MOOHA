import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mooha/provider/ApplicationState.dart';

int value = 0;

class WritingPage extends StatelessWidget {
  final DateTime checkedDate;
  User? user = FirebaseAuth.instance.currentUser;
  WritingPage({Key? key, required this.checkedDate}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();

  Future AddDiary(
      String title, String content, DateTime datetime, int emoji) async {
    User? user = FirebaseAuth.instance.currentUser;
    final docDiary = FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('diary')
        .doc(datetime.toString());
    final json = {
      'datetime': datetime,
      'uid': user.uid,
      'title': title,
      'content': content,
      'emoji': emoji,
    };
    await docDiary.set(json);
  }

  @override
  Widget build(BuildContext context) {
    final year = DateFormat('yyyy').format(checkedDate);
    final monthAndDay = DateFormat('MM월 dd일').format(checkedDate);
    final dayOfWeek = DateFormat.E('ko_KR').format(checkedDate);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        centerTitle: true,
        title: Text(
          '일기쓰기',
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
                MoodButtons(),
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
                OutlinedButton(
                  onPressed: () {
                    AddDiary(_titleController.text, _contentController.text,
                        checkedDate, value);
                    Navigator.pop(context);
                  },
                  child: Text('저장하기'),
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
  const MoodButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<MoodButtons> createState() => _MoodButtonsState();
}

class _MoodButtonsState extends State<MoodButtons> {
  Widget CustomRadioButton(String text, int index) {
    // index = 1;
    return GestureDetector(
      onTap: () {
        setState(() {
          value = index;
          print('value=$value');
          print('index=$index');
        });
      },
      child: ColorFiltered(
        colorFilter: (value == index)
            ? const ColorFilter.mode(Colors.yellow, BlendMode.modulate)
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
        CustomRadioButton('emoji-smile', 1),
        CustomRadioButton('emoji-angry', 2),
        CustomRadioButton('emoji-dizzy', 3),
        CustomRadioButton('emoji-expressionless', 4),
        CustomRadioButton('emoji-frown', 5),
        CustomRadioButton('emoji-laughing', 6),
        CustomRadioButton('emoji-sunglasses', 7),
      ],
    );
  }
}
