import 'package:flutter/material.dart';
import 'package:jetbooking/components/Calendar.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Calendar(
        date: DateTime.now(),
      ),
    );
  }
}
