import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart' show DateFormat;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime checkedDate = DateTime.now();
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
          const SizedBox(
            height: 20.0,
          ),
          Calender(
            checkedDate: checkedDate,
          ),
          OutlinedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/writePage');
                print(checkedDate);
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

class Calender extends StatefulWidget {
  Calender({Key? key, required this.checkedDate}) : super(key: key);
  late DateTime checkedDate;
  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  // get _markedDateMap => null;
  static Widget _eventIcon = new Container(
      child: Image.asset(
    'assets/emoji-smile.png',
    color: Colors.blue,
  ));
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2022, 11, 10): [
        new Event(
          date: new DateTime(2022, 11, 10),
          title: 'Event 1',
          icon: _eventIcon,
        ),
      ],
    },
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: CalendarCarousel<Event>(
        //calender format
        showOnlyCurrentMonthDate: true,
        weekFormat: false,
        height: 340.0,
        customGridViewPhysics: NeverScrollableScrollPhysics(),
        //header (prev/next month)
        showHeader: true,
        headerMargin: EdgeInsets.symmetric(vertical: 10.0),
        headerTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        //circular Border
        daysHaveCircularBorder: true,
        //today button
        todayBorderColor: Colors.red,
        todayTextStyle: TextStyle(
          color: Colors.black,
        ),
        todayButtonColor: Colors.transparent,

        //selected button
        selectedDateTime: _currentDate2,
        selectedDayTextStyle: TextStyle(
          color: Colors.white,
        ),
        selectedDayBorderColor: Colors.transparent,
        selectedDayButtonColor: Colors.red,
        onDayPressed: (date, events) {
          this.setState(() {
            _currentDate2 = date;
            widget.checkedDate = date;
          });
          events.forEach((event) => print(event.title));
          print(date);
        },

        //marked button
        markedDateIconMargin: 2.0,
        markedDatesMap: _markedDateMap,
        markedDateCustomShapeBorder:
            CircleBorder(side: BorderSide(color: Colors.transparent)),
        markedDateCustomTextStyle: TextStyle(
          fontSize: 18,
          color: Colors.transparent,
        ),
        markedDateShowIcon: true,
        markedDateIconMaxShown: 2,
        markedDateIconBuilder: (event) {
          return event.icon;
        },
        markedDateMoreShowTotal: true,

        //weekday text
        weekdayTextStyle: TextStyle(color: Colors.black),
        //weekend text
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),

        targetDateTime: _targetDateTime,
        minSelectedDate: _currentDate.subtract(Duration(days: 360)),
        maxSelectedDate: _currentDate.add(Duration(days: 360)),
        prevDaysTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.pinkAccent,
        ),
        inactiveDaysTextStyle: TextStyle(
          color: Colors.tealAccent,
          fontSize: 16,
        ),
        onCalendarChanged: (DateTime date) {
          this.setState(() {
            _targetDateTime = date;
            _currentMonth = DateFormat.yMMM().format(_targetDateTime);
          });
        },
      ),
    );
  }
}
