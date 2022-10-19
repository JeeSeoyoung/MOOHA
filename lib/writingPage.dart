import 'package:flutter/material.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _contentController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '2022',
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              '9월 21일 수요일',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 30.0),
            Text(
              '오늘의 기분을 이모지로 기록해요',
              style: Theme.of(context).textTheme.headline3,
            ),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.emoji_emotions)),
                IconButton(onPressed: () {}, icon: Icon(Icons.face)),
                IconButton(onPressed: () {}, icon: Icon(Icons.face)),
              ],
            ),
            Container(
              padding: EdgeInsets.all(30.0),
              height: 300.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  )),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(hintText: '제목을 입력하세요'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
