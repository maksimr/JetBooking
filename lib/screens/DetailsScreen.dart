import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jetbooking/components/Accordion.dart';
import 'package:jetbooking/components/InlineCalendar.dart';
import 'package:jetbooking/components/TimePicker.dart';
import 'package:jetbooking/i18n.dart';

class DetailsScreen extends StatefulWidget {
  final DateTime date;

  DetailsScreen({@required this.date});

  @override
  _DetailsScreenState createState() => _DetailsScreenState(date: date);
}

class _DetailsScreenState extends State<DetailsScreen> {
  final DateTime date;
  DateTime startDate;
  DateTime endDate;

  _DetailsScreenState({@required this.date, Key key})
      : endDate = date.add(Duration(minutes: 30)),
        startDate = date,
        super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(DateFormat.MMMM().format(date)),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Flex(
      direction: Axis.vertical,
      children: [
        InlineCalendar(date: date),
        Accordion(
          children: [
            _buildStartsDate(),
            _buildEndsDate(),
            _buildRecurring(),
            _buildOfflineRooms(),
          ].map((it) => _withDivider(it)).toList(),
        ),
      ],
    );
  }

  Widget _withDivider(child) {
    return Column(
      children: [child, Divider(height: 0.0)],
    );
  }

  _buildOfflineRooms() {
    return AccordionPane(
      title: _buildTitle(i18n("Offline rooms")),
      trailing: Switch(
        onChanged: (_) => null,
        value: true,
      ),
    );
  }

  _buildRecurring() {
    return AccordionPane(
      title: _buildTitle(i18n("Recurring")),
      trailing: Switch(
        onChanged: (_) => null,
        value: false,
      ),
    );
  }

  _buildStartsDate() {
    return _buildDateItem(
      i18n("Starts"),
      startDate,
      (date) => setState(() => startDate = date),
    );
  }

  _buildEndsDate() {
    return _buildDateItem(
      i18n("Ends"),
      endDate,
      (date) => setState(() => endDate = date),
    );
  }

  _buildDateItem(titleText, date, onChange) {
    return AccordionPane(
      title: _buildTitle(titleText),
      trailing: _buildDateText(date),
      child: _buildTimePicker(date, onChange),
    );
  }

  _buildTimePicker(date, onChange) {
    return SizedBox(
      height: 130.0,
      child: TimePicker(
        date: date,
        onSelectedDateChanged: onChange,
      ),
    );
  }

  _buildTitle(text) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Text(
          text,
          style: Theme.of(context).textTheme.headline,
        );
      },
    );
  }

  _buildDateText(date) {
    return Text(DateFormat.Hm().format(date));
  }
}
