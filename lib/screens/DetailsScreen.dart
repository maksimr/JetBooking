import 'package:flutter/material.dart';
import 'package:jetbooking/components/Accordion.dart';

class DetailsScreen extends StatelessWidget {
  final DateTime date;

  DetailsScreen({@required this.date});

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
            AccordionPane(
              title: Text("Starts"),
              trailing: Text("${date.hour}:${date.minute}"),
            ),
          ],
        ),
      ],
    );
  }
}
