import 'package:flutter/widgets.dart';
import 'package:jetbooking/i18n.dart';

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

  static List<String> _shortWeekdays = <String>[
    i18n('Mon'),
    i18n('Tue'),
    i18n('Wed'),
    i18n('Thu'),
    i18n('Fri'),
    i18n('Sat'),
    i18n('Sun'),
  ];
}
