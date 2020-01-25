import 'package:flutter/material.dart';
import 'package:jetbooking/components/CalendarDay.dart';
import 'package:jetbooking/components/CalendarMonth.dart';
import 'package:jetbooking/components/WeekDay.dart';

class Calendar extends StatelessWidget {
  final DateTime date;
  final Function(DateTime) onTap;
  final toolbarKey = UniqueKey();
  final calendarKey = UniqueKey();

  Calendar({date, this.onTap, Key key})
      : date = date ?? DateTime.now(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).padding,
      child: Stack(
        children: <Widget>[
          _buildCalendar(),
          _buildToolbar(context),
        ],
      ),
    );
  }

  _buildCalendar() {
    return ListView(
      key: calendarKey,
      padding: EdgeInsets.only(top: 40.0),
      children: List.generate((12 - date.month) + 1, (monthIndex) {
        return _buildMonth(
          DateTime(date.year, date.month + monthIndex),
        );
      }),
    );
  }

  _buildToolbar(context) {
    final mTheme = Theme.of(context);

    return Container(
      key: toolbarKey,
      color: mTheme.accentColor,
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Container(
          child: SizedBox(
            height: 40.0,
            child: Flex(
              direction: Axis.horizontal,
              children: List.generate(7, (weekDayIndex) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Center(
                      child: WeekDay(
                        weekday: weekDayIndex + 1,
                        style: TextStyle(
                          color: mTheme.accentTextTheme.headline6.color,
                          fontSize: 8.0,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  _buildMonth(DateTime date) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: CalendarMonth(
        title: CalendarMonthTitle(date: date),
        date: date,
        dayBuilder: (BuildContext context, DateTime date) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 17.0),
            child: CalendarDay(
              selected: _isCurrentDate(date),
              fontSize: 18.0,
              date: date,
              onTap: onTap,
            ),
          );
        },
      ),
    );
  }

  _isCurrentDate(DateTime _date) {
    if (_date == null) return false;
    return (date.year == _date.year &&
        date.month == _date.month &&
        date.day == _date.day);
  }
}
