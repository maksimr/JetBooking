import 'package:flutter/material.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/screens/CalendarScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppTheme(
      child: CalendarScreen(),
    );
  }
}
