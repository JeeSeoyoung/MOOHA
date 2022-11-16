import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class Calender extends StatefulWidget {
  const Calender({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(events: {
    new DateTime.now(): [
      new Event(
        date: new DateTime.now(),
        title: 'Event 1',
        icon: _eventIcon,
        dot: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.0),
          color: Colors.red,
          height: 5.0,
          width: 5.0,
        ),
      ),
      new Event(
        date: new DateTime.now(),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime.now(),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]
  });

  @override
  void initState() {
    _markedDateMap.add(
        new DateTime.now(),
        new Event(
            date: new DateTime.now(), title: 'Event 5', icon: _eventIcon));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
