import 'package:flutter/widgets.dart';
import 'package:jetbooking/components/Picker.dart';

class TimePicker extends StatefulWidget {
  final double itemExtent = 30.0;
  final ValueChanged<DateTime> onSelectedDateChanged;
  final DateTime date;

  TimePicker({
    Key key,
    this.onSelectedDateChanged,
    date,
  })  : date = date ?? DateTime.now(),
        super(key: key);

  @override
  TimePickerState createState() {
    return new TimePickerState(initialDate: date);
  }
}

class TimePickerState extends State<TimePicker> {
  final DateTime initialDate;
  DateTime date;

  TimePickerState({this.initialDate})
      : date = initialDate,
        super();

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
      children: List<Widget>.generate(
        24,
        (it) => TimePickerHourItem(hourIndex: it),
      ),
      initialItem: date.hour,
      onSelectedDateChanged: (int value) => _updateDate(value, date.minute),
    );
  }

  _buildMinList() {
    return _buildPicker(
      children: List<Widget>.generate(
        12,
        (it) => TimePickerMinItem(minIndex: it * 5),
      ),
      initialItem: _roundTo(date.minute, 5) ~/ 5,
      onSelectedDateChanged: (int value) => _updateDate(date.hour, value * 5),
    );
  }

  void _updateDate(int hour, int minute) {
    setState(() {
      date = date.add(Duration(
        hours: hour - date.hour,
        minutes: minute - date.minute,
      ));

      if (widget.onSelectedDateChanged != null) {
        widget.onSelectedDateChanged(date);
      }
    });
  }

  _buildPicker({
    List<Widget> children,
    initialItem = 0,
    Function(int value) onSelectedDateChanged,
  }) {
    return Picker(
      perspective: 0.000001,
      initialItem: initialItem,
      children: children,
      itemExtent: widget.itemExtent,
      onSelectedItemChanged: onSelectedDateChanged,
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
