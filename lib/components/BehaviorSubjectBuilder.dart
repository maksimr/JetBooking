import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class BehaviorSubjectBuilder<T> extends StatelessWidget {
  final AsyncWidgetBuilder<T> builder;
  final BehaviorSubject<T> subject;

  BehaviorSubjectBuilder({
    @required this.subject,
    @required this.builder,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      initialData: subject.value,
      stream: subject.stream,
      builder: this.builder,
    );
  }
}
