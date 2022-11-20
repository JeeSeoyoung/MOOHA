import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WritingPage extends StatelessWidget {
  final DateTime checkedDate;
  WritingPage({Key? key, required this.checkedDate}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          Colors.white, BlendMode.modulate),
                      child: Image.asset('assets/emoji-smile.png'),
                    ),
                    ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          Colors.white, BlendMode.modulate),
                      child: Image.asset('assets/emoji-angry.png'),
                    ),
                    ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          Colors.white, BlendMode.modulate),
                      child: Image.asset('assets/emoji-dizzy.png'),
                    ),
                    ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          Colors.white, BlendMode.modulate),
                      child: Image.asset('assets/emoji-expressionless.png'),
                    ),
                    ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          Colors.white, BlendMode.modulate),
                      child: Image.asset('assets/emoji-frown.png'),
                    ),
                    ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          Colors.white, BlendMode.modulate),
                      child: Image.asset('assets/emoji-laughing.png'),
                    ),
                    ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          Colors.white, BlendMode.modulate),
                      child: Image.asset('assets/emoji-sunglasses.png'),
                    ),
                  ],
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
                OutlinedButton(
                  onPressed: () {
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
