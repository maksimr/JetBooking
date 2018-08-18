import 'package:flutter/material.dart';
import 'package:jetbooking/components/Calendar.dart';
import 'package:jetbooking/components/TimePicker.dart';
import 'package:jetbooking/screens/DetailsScreen.dart';

class CalendarScreen extends StatelessWidget {
  final DateTime date;

  CalendarScreen({date, Key key})
      : date = date ?? DateTime.now(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Calendar(
        date: date,
        onTap: (date) => _onDateSelect(context, date),
      ),
    );
  }

  _onDateSelect(context, DateTime date) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Material(
            child: DetailsScreen(date: _roundDate(date)),
          );
        },
      ),
    );
  }

  DateTime _roundDate(DateTime date) {
    final dateTimeNow = DateTime.now();
    return DateTime(
      date.year,
      date.month,
      date.day,
      dateTimeNow.hour,
      roundTo(dateTimeNow.minute, 5),
    );
  }
}
