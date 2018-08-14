import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Picker extends StatelessWidget {
  final List<Widget> children;
  final ValueChanged<int> onSelectedItemChanged;
  final double itemExtent;
  final FixedExtentScrollController controller;
  final double perspective;

  Picker({
    @required this.itemExtent,
    @required this.children,
    @required this.onSelectedItemChanged,
    this.perspective,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      diameterRatio: 1.0,
      perspective: perspective ?? RenderListWheelViewport.defaultPerspective,
      controller: controller,
      itemExtent: itemExtent,
      children: children,
      onSelectedItemChanged: onSelectedItemChanged,
    );
  }
}
