import 'package:flutter/material.dart';

class AppTheme extends StatelessWidget {
  final Widget child;

  const AppTheme({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: child,
      ),
    );
  }
}
