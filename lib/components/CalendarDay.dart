import 'package:flutter/material.dart';

class CalendarDay extends StatelessWidget {
  final DateTime date;
  final Function(DateTime) onTap;
  final bool selected;
  final double fontSize;

  CalendarDay({
    this.date,
    this.onTap,
    this.selected = false,
    this.fontSize,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mTheme = Theme.of(context);

    return _buildInk(
      context,
      AnimatedContainer(
        duration: Duration(milliseconds: selected ? 250 : 0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selected ? mTheme.accentColor : null,
          shape: BoxShape.circle,
        ),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildInk(BuildContext context, child) {
    return onTap != null && date != null
        ? RawMaterialButton(
            constraints: const BoxConstraints(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: CircleBorder(),
            child: child,
            onPressed: () => onTap(date),
          )
        : child;
  }

  Center _buildContent(BuildContext context) {
    return Center(
      child: Text(
        "${date?.day ?? ''}",
        style: TextStyle(
          color: _dateColor(context),
          fontSize: fontSize,
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
