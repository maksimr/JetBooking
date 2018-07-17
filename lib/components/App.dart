import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final Widget child;

  const App({Key key, this.child}) : super(key: key);

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
