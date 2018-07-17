import 'package:flutter/material.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/Calendar.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppTheme(
      child: SafeArea(
        child: Calendar(),
      ),
    );
  }
}
