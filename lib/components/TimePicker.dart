import 'package:flutter/widgets.dart';
import 'package:jetbooking/components/Picker.dart';

class TimePicker extends StatelessWidget {
  final double itemExtent = 30.0;
  final DateTime date;

  TimePicker({Key key, date})
      : date = date ?? DateTime.now(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: _buildHourList()),
        Expanded(child: _buildMinList()),
      ],
    );
  }

  _buildHourList() {
    return _buildPicker(
        List<Widget>.generate(
          24,
          (it) => TimePickerHourItem(hourIndex: it),
        ),
        date.hour);
  }

  _buildMinList() {
    return _buildPicker(
        List<Widget>.generate(
          12,
          (it) => TimePickerMinItem(minIndex: it * 5),
        ),
        _roundTo(date.minute, 5) ~/ 5);
  }

  _buildPicker(List<Widget> children, [initialItem = 0]) {
    return Picker(
      perspective: 0.000001,
      initialItem: initialItem,
      children: children,
      itemExtent: itemExtent,
      onSelectedItemChanged: (int value) {},
    );
  }
}

class TimePickerHourItem extends StatelessWidget {
  final int hourIndex;

  const TimePickerHourItem({Key key, this.hourIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: TimePickerItemText(_zeroLeftPad(hourIndex)),
      ),
    );
  }
}

class TimePickerMinItem extends StatelessWidget {
  final int minIndex;

  const TimePickerMinItem({Key key, this.minIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TimePickerItemText(_zeroLeftPad(minIndex)),
      ),
    );
  }
}

class TimePickerItemText extends StatelessWidget {
  final String text;

  const TimePickerItemText(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.0,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

String _zeroLeftPad(int it) {
  return it < 10 ? "0$it" : "$it";
}

int _roundTo(int it, int d) {
  if (it % d == 0) return it;
  return (d - it % d) + it;
}
