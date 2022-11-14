import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'MOOHA',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ))),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).backgroundColor,
        child: ListView(),
      ),
      body: Column(
        children: [
          OutlinedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/writePage');
              },
              icon: const Icon(
                Icons.create,
                color: Colors.black,
              ),
              label: const Text(
                '일기쓰기',
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
  }
}
