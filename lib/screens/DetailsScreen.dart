import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jetbooking/components/BehaviorSubjectBuilder.dart';
import 'package:rxdart/rxdart.dart';
import 'package:jetbooking/components/Accordion.dart';
import 'package:jetbooking/components/InlineCalendar.dart';
import 'package:jetbooking/components/TimePicker.dart';
import 'package:jetbooking/components/VacantRooms.dart';
import 'package:jetbooking/i18n.dart';

class DetailsScreen extends StatelessWidget {
  final DateTime date;
  final BehaviorSubject<DateTime> $$startDate;
  final BehaviorSubject<DateTime> $$endDate;
  final BehaviorSubject<bool> $$hasTv;

  DetailsScreen({@required this.date, Key key})
      : $$startDate = BehaviorSubject<DateTime>(seedValue: date),
        $$endDate = BehaviorSubject<DateTime>(
            seedValue: date.add(Duration(minutes: 30))),
        $$hasTv = BehaviorSubject<bool>(seedValue: false),
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
        Expanded(
          child: StreamBuilder(
            stream: Observable.merge([
              $$startDate.stream,
              $$endDate.stream,
              $$hasTv.stream,
            ]),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return VacantRooms(
                hasTv: $$hasTv.value,
                startTime: $$startDate.value,
                endTime: $$endDate.value,
              );
            },
          ),
        )
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
      trailing: BehaviorSubjectBuilder(
        subject: $$hasTv,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final hasTv = snapshot.data;
          return Switch(
            onChanged: (offline) => $$hasTv.add(!offline),
            value: !hasTv,
          );
        },
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
    return BehaviorSubjectBuilder(
      subject: $$startDate,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final startDate = snapshot.data;
        return _buildDateItem(
          i18n("Starts"),
          startDate,
          (date) {
            final endDate = $$endDate.value;
            final duration = endDate.difference(startDate);
            $$startDate.add(date);
            $$endDate.add(date.add(duration));
          },
        );
      },
    );
  }

  _buildEndsDate() {
    return BehaviorSubjectBuilder(
      subject: $$endDate,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return _buildDateItem(
          i18n("Ends"),
          snapshot.data,
          (date) => $$endDate.add(date),
        );
      },
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
}
