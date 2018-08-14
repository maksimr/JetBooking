import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class PickerView extends StatelessWidget {
  final List<Widget> children;
  final ValueChanged<int> onSelectedItemChanged;
  final double itemExtent;
  final FixedExtentScrollController controller;
  final double perspective;

  PickerView({
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
      physics: const FixedExtentScrollPhysics(),
      perspective: perspective ?? RenderListWheelViewport.defaultPerspective,
      controller: controller,
      itemExtent: itemExtent,
      children: children,
      onSelectedItemChanged: onSelectedItemChanged,
    );
  }
}
