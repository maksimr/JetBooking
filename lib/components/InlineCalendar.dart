import 'package:flutter/material.dart';
import 'package:jetbooking/components/CalendarDay.dart';
import 'package:jetbooking/components/WeekDay.dart';

class InlineCalendar extends StatelessWidget {
  final DateTime seedDate;
  final Function(DateTime) onTap;
  final DateTime date;

  InlineCalendar({
    @required this.seedDate,
    date,
    this.onTap,
    Key key,
  })  : date = date ?? seedDate,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightForFinite(height: 94.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _buildDay(seedDate.add(Duration(days: index)));
        },
      ),
    );
  }

  _buildDay(DateTime dayDate) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: <Widget>[
            _buildWeekDayTitle(dayDate),
            Padding(padding: EdgeInsets.only(top: 8.0)),
            CalendarDay(
              onTap: onTap,
              date: dayDate,
              selected: _isEqual(dayDate, date),
            ),
          ],
        ),
      ),
    );
  }

  _isEqual(DateTime dateA, DateTime dateB) {
    return (dateA.year == dateB.year &&
        dateA.month == dateB.month &&
        dateA.day == dateB.day);
  }

  _buildWeekDayTitle(DateTime dayDate) {
    return WeekDay(
      weekday: dayDate.weekday,
      style: TextStyle(fontSize: 12.0),
    );
  }
}
