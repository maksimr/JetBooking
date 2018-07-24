import 'package:flutter/widgets.dart';

class WeekDay extends StatelessWidget {
  final int weekday;
  final TextStyle style;

  WeekDay({@required this.weekday, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      (_shortWeekdays[weekday - 1]).toUpperCase(),
      style: style,
    );
  }

  static const List<String> _shortWeekdays = const <String>[
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
}
