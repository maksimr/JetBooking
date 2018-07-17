import 'package:flutter/material.dart';

class AppTheme extends StatelessWidget {
  final Widget child;

  const AppTheme({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF222222),
        accentColor: Color(0xFFff2d55),
      ),
      home: Material(
        child: child,
      ),
    );
  }
}
