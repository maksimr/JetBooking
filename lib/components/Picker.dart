import 'package:flutter/widgets.dart';
import 'package:jetbooking/components/PickerView.dart';

class Picker extends StatelessWidget {
  final double itemExtent;
  final List<Widget> children;
  final ValueChanged<int> onSelectedItemChanged;
  final perspective;
  final int initialItem;
  final FixedExtentScrollController controller;

  Picker({
    Key key,
    @required this.itemExtent,
    @required this.children,
    this.initialItem,
    this.onSelectedItemChanged,
    this.perspective,
  })  : controller = FixedExtentScrollController(initialItem: initialItem ?? 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PickerView(
      itemExtent: itemExtent,
      controller: controller,
      children: children,
      perspective: perspective,
      onSelectedItemChanged: onSelectedItemChanged,
    );
  }
}
