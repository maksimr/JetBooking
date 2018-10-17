import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class PickerView extends StatelessWidget {
  final List<Widget> children;
  final ValueChanged<int> onSelectedItemChanged;
  final double itemExtent;
  final FixedExtentScrollController controller;
  final double perspective;
  final bool childLooping;

  PickerView({
    @required this.itemExtent,
    @required this.children,
    @required this.onSelectedItemChanged,
    this.perspective,
    this.controller,
    this.childLooping = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      diameterRatio: 1.0,
      physics: const FixedExtentScrollPhysics(),
      perspective: perspective ?? RenderListWheelViewport.defaultPerspective,
      controller: controller,
      itemExtent: itemExtent,
      onSelectedItemChanged: onSelectedItemChanged,
      childDelegate: childLooping
          ? ListWheelChildLoopingListDelegate(children: children)
          : ListWheelChildListDelegate(children: children),
    );
  }
}
