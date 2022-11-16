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
      // decoration: new BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.all(Radius.circular(1000)),
      //     border: Border.all(color: Colors.blue, width: 2.0)),
      child: Image.asset('assets/emoji-angry.png'));
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2022, 11, 10): [
        new Event(
          date: new DateTime(2022, 11, 10),
          title: 'Event 1',
          icon: _eventIcon,
          // dot: Container(
          //   margin: EdgeInsets.symmetric(horizontal: 1.0),
          //   color: Colors.red,
          //   height: 5.0,
          //   width: 5.0,
          // ),
        ),
      ],
    },
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30.0),
      child: CalendarCarousel<Event>(
        todayBorderColor: Colors.green,
        onDayPressed: (date, events) {
          this.setState(() {
            _currentDate2 = date;
            widget.checkedDate = date;
          });
          events.forEach((event) => print(event.title));
          print(date);
        },
        daysHaveCircularBorder: true,
        showOnlyCurrentMonthDate: true,
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        // thisMonthDayBorderColor: Colors.grey,
        weekFormat: false,
//      firstDayOfWeek: 4,
        markedDatesMap: _markedDateMap,
        height: 420.0,
        selectedDateTime: _currentDate2,
        targetDateTime: _targetDateTime,
        customGridViewPhysics: NeverScrollableScrollPhysics(),
        markedDateCustomShapeBorder:
            CircleBorder(side: BorderSide(color: Colors.transparent)),
        markedDateCustomTextStyle: TextStyle(
          fontSize: 18,
          color: Colors.transparent,
        ),
        showHeader: true,
        weekdayTextStyle: TextStyle(color: Colors.black),
        headerMargin: EdgeInsets.symmetric(vertical: 10.0),
        headerTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        todayTextStyle: TextStyle(
          color: Colors.blue,
        ),
        markedDateShowIcon: true,
        markedDateIconMaxShown: 2,
        markedDateIconBuilder: (event) {
          return event.icon;
        },
        markedDateMoreShowTotal: true,
        todayButtonColor: Colors.transparent,
        selectedDayTextStyle: TextStyle(
          color: Colors.black,
        ),
        selectedDayBorderColor: Colors.red,
        selectedDayButtonColor: Colors.red,
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
        onDayLongPressed: (DateTime date) {
          print('long pressed date $date');
        },
      ),
    );
  }
}
