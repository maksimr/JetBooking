import 'package:flutter/material.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/CalendarDay.dart';
import 'package:jetbooking/components/CalendarMonth.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dateNow = DateTime.now();
    final selectedDate = DateTime(dateNow.year, dateNow.month, dateNow.day);
    return AppTheme(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CalendarMonth(
            date: selectedDate,
            dayBuilder: (BuildContext context, DateTime date) {
              return Expanded(
                child: CalendarDay(
                  selected: date == selectedDate,
                  onTap: (date) => print(date),
                  date: date,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
