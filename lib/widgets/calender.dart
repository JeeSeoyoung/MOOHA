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
  final DateTime _currentDate = DateTime.now();
  final DateTime _currentDate2 = DateTime.now();
  final String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  final DateTime _targetDateTime = DateTime.now();

  static final Widget _eventIcon = Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: const Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  final EventList<Event> _markedDateMap = EventList<Event>(events: {
    DateTime.now(): [
      Event(
        date: DateTime.now(),
        title: 'Event 1',
        icon: _eventIcon,
        dot: Container(
          margin: const EdgeInsets.symmetric(horizontal: 1.0),
          color: Colors.red,
          height: 5.0,
          width: 5.0,
        ),
      ),
      Event(
        date: DateTime.now(),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      Event(
        date: DateTime.now(),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]
  });

  @override
  void initState() {
    _markedDateMap.add(DateTime.now(),
        Event(date: DateTime.now(), title: 'Event 5', icon: _eventIcon));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
