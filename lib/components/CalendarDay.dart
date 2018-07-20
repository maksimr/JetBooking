import 'package:flutter/material.dart';

class CalendarDay extends StatelessWidget {
  final DateTime date;
  final Function(DateTime) onTap;
  final bool selected;

  CalendarDay({this.date, this.onTap, this.selected = false, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mTheme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 17.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selected ? mTheme.accentColor : null,
          shape: BoxShape.circle,
        ),
        child: _buildInk(context),
      ),
    );
  }

  Widget _buildInk(BuildContext context) {
    return onTap != null && date != null
        ? InkWell(onTap: () => onTap(date), child: _buildContent(context))
        : _buildContent(context);
  }

  Center _buildContent(BuildContext context) {
    return Center(
      child: Text(
        "${date?.day ?? ''}",
        style: TextStyle(
          color: _dateColor(context),
          fontSize: 20.0,
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
