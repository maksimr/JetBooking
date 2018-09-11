import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jetbooking/components/Accordion.dart';
import 'package:jetbooking/components/InlineCalendar.dart';
import 'package:jetbooking/components/TimePicker.dart';
import 'package:jetbooking/components/VacantRooms.dart';
import 'package:jetbooking/components/Empty.dart';
import 'package:jetbooking/i18n.dart';
import 'package:jetbooking/screens/DetailsScreenController.dart';

class DetailsScreen extends StatelessWidget {
  final DetailsScreenController $ctrl;

  DetailsScreen({@required date, Key key})
      : $ctrl = DetailsScreenController(date),
        super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(DateFormat.MMMM().format($ctrl.date)),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Flex(
      direction: Axis.vertical,
      children: [
        _buildInlineCalendar(),
        Accordion(
          children: [
            _buildStartsDate(),
            _buildEndsDate(),
            _buildRecurring(),
            _buildOfflineRooms(),
          ].map((it) => _withDivider(it)).toList(),
        ),
        Expanded(
          child: _buildRoomsList(),
        )
      ],
    );
  }

  _buildRoomsList() {
    return StreamBuilder(
      stream: $ctrl.rooms,
      builder: _reliableBuilder((BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) return _buildErrorMessage(context, snapshot);
        final List rooms = snapshot.data;
        return VacantRooms(rooms: rooms);
      }),
    );
  }

  _buildErrorMessage(context, AsyncSnapshot snapshot) {
    final mTheme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          "${snapshot.error}",
          style: TextStyle(
            fontSize: 18.0,
            color: mTheme.errorColor,
          ),
        ),
      ),
    );
  }

  _buildInlineCalendar() {
    return StreamBuilder(
      stream: $ctrl.startDate,
      builder: _reliableBuilder(
        (BuildContext context, AsyncSnapshot snapshot) {
          final DateTime currentDate = snapshot.data;
          return InlineCalendar(
            seedDate: $ctrl.date,
            date: currentDate,
            onTap: (date) => $ctrl.startDate = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  currentDate.hour,
                  currentDate.minute,
                ),
          );
        },
      ),
    );
  }

  Widget _withDivider(child) {
    return Column(
      children: [child, Divider(height: 0.0)],
    );
  }

  _buildOfflineRooms() {
    return StreamBuilder(
      stream: $ctrl.hasTv,
      builder: _reliableBuilder((BuildContext context, AsyncSnapshot snapshot) {
        final hasTv = snapshot.data;
        return AccordionPane(
          title: GestureDetector(
            onTap: () => $ctrl.hasTv = !hasTv,
            child: _buildTitle(i18n("Offline rooms")),
          ),
          trailing: Switch(
            onChanged: (offline) => $ctrl.hasTv = !offline,
            value: !hasTv,
          ),
        );
      }),
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
    return StreamBuilder(
      stream: $ctrl.startDate,
      builder: _reliableBuilder((BuildContext context, AsyncSnapshot snapshot) {
        final startDate = snapshot.data;
        return _buildDateItem(
          i18n("Starts"),
          startDate,
          (date) => $ctrl.startDate = date,
        );
      }),
    );
  }

  _buildEndsDate() {
    return StreamBuilder(
      stream: $ctrl.endDate,
      builder: _reliableBuilder((BuildContext context, AsyncSnapshot snapshot) {
        return _buildDateItem(
            i18n("Ends"), snapshot.data, (date) => $ctrl.endDate = date);
      }),
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final mTheme = Theme.of(context);
        return Material(
          color: mTheme.primaryColor,
          textStyle: TextStyle(
            color: mTheme.primaryTextTheme.body2.color,
          ),
          child: SizedBox(
            height: 130.0,
            child: Stack(
              children: [
                Positioned.fill(
                  top: 44.0,
                  bottom: 45.0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: mTheme.accentColor),
                        bottom: BorderSide(color: mTheme.accentColor),
                      ),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.expand(height: 40.0),
                    ),
                  ),
                ),
                TimePicker(
                  date: date,
                  onSelectedDateChanged: onChange,
                ),
              ],
            ),
          ),
        );
      },
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

  AsyncWidgetBuilder _reliableBuilder(AsyncWidgetBuilder builder) {
    return (BuildContext context, AsyncSnapshot snapshot) {
      if (!snapshot.hasData) return Empty();
      return builder(context, snapshot);
    };
  }
}
