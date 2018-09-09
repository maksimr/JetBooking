import 'package:rxdart/rxdart.dart';

class DetailsScreenController {
  final DateTime date;

  BehaviorSubject<DateTime> _startDateSubject;
  BehaviorSubject<DateTime> _endDateSubject;
  BehaviorSubject<bool> _hasTvSubject;
  BehaviorSubject<Duration> _durationSubject;

  DetailsScreenController(this.date) {
    _startDateSubject = BehaviorSubject<DateTime>(seedValue: date);
    _durationSubject = BehaviorSubject(seedValue: Duration(minutes: 30));
    _hasTvSubject = BehaviorSubject<bool>(seedValue: false);
    _endDateSubject = BehaviorSubject<DateTime>(
        seedValue: _startDateSubject.value.add(_durationSubject.value));

    startDate.withLatestFrom<Duration, DateTime>(
      _durationSubject.stream,
      (DateTime startDate, Duration duration) {
        return startDate.add(duration);
      },
    ).listen((date) => endDate = date);

    endDate.withLatestFrom<DateTime, Duration>(
      startDate,
      (DateTime endDate, DateTime starDate) {
        return endDate.difference(starDate);
      },
    ).listen((duration) => _durationSubject.add(duration));
  }

  get startDate => _startDateSubject.stream;

  set startDate(value) => _startDateSubject.add(value);

  get endDate => _endDateSubject.stream;

  set endDate(value) => _endDateSubject.add(value);

  get hasTv => _hasTvSubject.stream;

  set hasTv(value) => _hasTvSubject.add(value);
}
