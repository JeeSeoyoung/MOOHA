import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:mooha/writing_page.dart';

DateTime checkedDate = DateTime.now();

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DateTime checkedDate = DateTime.now();
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
  final DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  // get _markedDateMap => null;
  static final Widget _eventIcon = Container(
      child: Image.asset(
    'assets/emoji-smile.png',
    color: Colors.blue,
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
              this.setState(() {
                _currentDate2 = date;
                widget.checkedDate = date;
              });
              events.forEach((event) => print(event.title));
              // print(date);
              // print(widget.checkedDate);
            },

            //marked button
            markedDateIconMargin: 2.0,
            markedDatesMap: _markedDateMap,
            markedDateCustomShapeBorder:
                const CircleBorder(side: BorderSide(color: Colors.transparent)),
            markedDateCustomTextStyle: const TextStyle(
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
              this.setState(() {
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
