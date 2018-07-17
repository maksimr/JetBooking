import 'package:flutter/material.dart';

class CalendarDay extends StatelessWidget {
  final DateTime date;
  final Function(DateTime) onTap;
  final bool selected;
  final containerKey = UniqueKey();

  CalendarDay({this.date, this.onTap, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final mTheme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 17.0),
      child: Container(
        key: containerKey,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selected ? mTheme.accentColor : null,
          shape: BoxShape.circle,
        ),
        child: InkWell(
          onTap: () => onTap(date),
          child: Center(
            child: Text(
              "${date?.day ?? ''}",
              style: TextStyle(
                color: _dateColor(context),
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _dateColor(context) {
    final mTheme = Theme.of(context);

    if (selected) {
      return mTheme.accentTextTheme.title.color;
    }

    return (date != null && date.weekday > 5)
        ? mTheme.disabledColor
        : mTheme.textTheme.body1.color;
  }
}
