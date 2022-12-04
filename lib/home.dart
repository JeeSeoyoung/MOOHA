import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:mooha/provider/ApplicationState.dart';
import 'package:mooha/services/firebase_auth_methods.dart';
import 'package:mooha/writing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

DateTime checkedDate = DateTime.now();
User? user = FirebaseAuth.instance.currentUser;

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
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 38.0),
              height: 180,
              color: const Color(0xFFFFF6D1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 120.0,
                  ),
                  const Text(
                    'MOOHA',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  const SizedBox(
                    height: 9.0,
                  ),
                  drawerName(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  _buildMenu(Icons.home, '홈', context),
                  _buildMenu(Icons.book, '일기장', context),
                  _buildMenu(Icons.photo_album, '갤러리', context),
                  _buildMenu(Icons.logout, '로그아웃', context),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Consumer<ApplicationsState>(
              builder: (context, appState, _) => Calender(
                    checkedDate: checkedDate,
                    list: appState.markedDateList,
                  )),
        ],
      ),
    );
  }
}

class drawerName extends StatefulWidget {
  const drawerName({Key? key}) : super(key: key);

  @override
  State<drawerName> createState() => _drawerNameState();
}

class _drawerNameState extends State<drawerName> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Text(
      '${user?.email}',
      style: const TextStyle(fontSize: 12.0),
    );
  }
}

ListTile _buildMenu(IconData icon, String label, BuildContext context) {
  return ListTile(
    leading: Icon(
      icon,
      color: Colors.black,
      // size: 20,
    ),
    title: Text(
      label,
      // style: TextStyle(fontSize: 12.0),
    ),
    onTap: () async {
      if (label == '홈') {
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        if (label == '일기장') {
          Navigator.pushNamed(context, '/ListPage');
        } else if (label == '갤러리')
          Navigator.pop(context);
        else if (label == '로그아웃') {
          await FirebaseAuthMethods.logout();
          Navigator.pushNamed(context, '/login');
        }
      }
    },
  );
}

class Calender extends StatefulWidget {
  Calender({Key? key, required this.checkedDate, required this.list})
      : super(key: key);
  late DateTime checkedDate;
  late EventList<Event> list;
  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  final DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  static final Widget _eventIcon = Container(
      child: Image.asset(
    'assets/emoji-smile.png',
  ));

  final EventList<Event> _markedDateMap = EventList<Event>(
    events: {
      DateTime(2022, 11, 10): [
        Event(
          date: DateTime(2022, 11, 10),
          title: 'Event 1',
          icon: _eventIcon,
        ),
      ],
    },
  );

  // void initState() {
  //   showEmoji();
  //   super.initState();
  // }

  // showEmoji() {
  //   widget.list.map(
  //       (e) => {_markedDateMap.add(e[0], Event(date: e[0], icon: _eventIcon))});
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20.0),
          child: CalendarCarousel<Event>(
            //calender format
            showOnlyCurrentMonthDate: true,
            weekFormat: false,
            height: 340.0,
            customGridViewPhysics: const NeverScrollableScrollPhysics(),
            //header (prev/next month)
            showHeader: true,
            headerMargin: const EdgeInsets.symmetric(vertical: 10.0),
            headerTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            //circular Border
            daysHaveCircularBorder: true,
            //today button
            todayBorderColor: Colors.red,
            todayTextStyle: const TextStyle(
              color: Colors.black,
            ),
            todayButtonColor: Colors.transparent,

            //selected button
            selectedDateTime: _currentDate2,
            selectedDayTextStyle: const TextStyle(
              color: Colors.white,
            ),
            selectedDayBorderColor: Colors.transparent,
            selectedDayButtonColor: Colors.red,
            onDayPressed: (date, events) {
              setState(() {
                _currentDate2 = date;
                widget.checkedDate = date;
              });
              events.forEach((event) => print(event.title));
              // print(date);
              // print(widget.checkedDate);
            },

            //marked button
            // markedDateIconMargin: 2.0,
            markedDatesMap: widget.list,
            markedDateCustomShapeBorder:
                const CircleBorder(side: BorderSide(color: Colors.transparent)),
            markedDateCustomTextStyle: const TextStyle(
              fontSize: 18,
              color: Colors.transparent,
            ),
            markedDateShowIcon: true,
            markedDateIconMaxShown: 1,
            markedDateIconBuilder: (event) {
              return event.icon;
            },
            markedDateMoreShowTotal: true,

            //weekday text
            weekdayTextStyle: const TextStyle(color: Colors.black),
            //weekend text
            weekendTextStyle: const TextStyle(
              color: Colors.red,
            ),

            targetDateTime: _targetDateTime,
            minSelectedDate: _currentDate.subtract(const Duration(days: 360)),
            maxSelectedDate: _currentDate.add(const Duration(days: 360)),
            prevDaysTextStyle: const TextStyle(
              fontSize: 16,
              color: Colors.pinkAccent,
            ),
            inactiveDaysTextStyle: const TextStyle(
              color: Colors.tealAccent,
              fontSize: 16,
            ),
            onCalendarChanged: (DateTime date) {
              setState(() {
                _targetDateTime = date;
                _currentMonth = DateFormat.yMMM().format(_targetDateTime);
              });
            },
          ),
        ),
        OutlinedButton.icon(
            onPressed: () {
              // Navigator.pushNamed(context, '/writePage');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WritingPage(checkedDate: widget.checkedDate)));
              print(widget.checkedDate);
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
    );
  }
}
