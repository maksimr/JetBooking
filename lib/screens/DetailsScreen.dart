import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jetbooking/components/Accordion.dart';

class DetailsScreen extends StatelessWidget {
  final DateTime date;
  final DateTime startDate;
  final DateTime endDate;

  DetailsScreen({@required this.date, Key key})
      : endDate = date.add(Duration(minutes: 30)),
        startDate = date,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Flex(
      direction: Axis.vertical,
      children: [
        Accordion(
          children: [
            _buildStartsDate(),
            _buildEndsDate(),
            _buildRecurring(),
            _buildOfflineRooms(),
          ],
        ),
      ],
    );
  }

  _buildOfflineRooms() {
    return AccordionPane(
      title: Text("Offline rooms"),
      trailing: Switch(
        onChanged: (_) => null,
        value: true,
      ),
    );
  }

  _buildRecurring() {
    return AccordionPane(
      title: Text("Recurring"),
      trailing: Switch(
        onChanged: (_) => null,
        value: false,
      ),
    );
  }

  _buildStartsDate() {
    return _buildDateItem("Starts", startDate);
  }

  _buildEndsDate() {
    return _buildDateItem("Ends", endDate);
  }

  _buildDateItem(titleText, date) {
    return AccordionPane(
      title: Text(titleText),
      trailing: _buildDateText(date),
    );
  }

  _buildDateText(date) {
    return Text(DateFormat.Hm().format(date));
  }
}
