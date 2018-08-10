import 'package:flutter/widgets.dart';

class Picker extends StatelessWidget {
  final List<Widget> children;
  final ValueChanged<int> onSelectedItemChanged;
  final double itemExtent;
  final FixedExtentScrollController controller;

  Picker({
    @required this.itemExtent,
    @required this.children,
    @required this.onSelectedItemChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      diameterRatio: 1.0,
      controller: controller,
      itemExtent: itemExtent,
      children: children,
      onSelectedItemChanged: onSelectedItemChanged,
    );
  }
}
