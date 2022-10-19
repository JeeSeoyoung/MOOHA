import 'package:flutter/material.dart';

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
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ))),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).backgroundColor,
        child: ListView(),
      ),
      body: Container(
        alignment: Alignment.center,
        child: OutlinedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/writePage');
            },
            icon: Icon(
              Icons.create,
              color: Colors.black,
            ),
            label: Text(
              '일기쓰기',
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }
}
