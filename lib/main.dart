import 'package:flutter/material.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/CalendaryDay.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppTheme(
      child: UnconstrainedBox(
        child: CalendarDay(
          selected: true,
          onTap: (date) => print(date),
          date: DateTime.now(),
        ),
      ),
    );
  }
}
