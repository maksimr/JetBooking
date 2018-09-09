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

  set endDate(DateTime newEndDate) {
    final currentStartDate = _startDateSubject.value;

    if (newEndDate.isBefore(currentStartDate)) {
      newEndDate = DateTime(
        currentStartDate.year,
        currentStartDate.month,
        currentStartDate.day + 1,
        newEndDate.hour,
        newEndDate.minute,
      );
    } else if (newEndDate.difference(currentStartDate) > Duration(days: 1)) {
      newEndDate = DateTime(
        currentStartDate.year,
        currentStartDate.month,
        currentStartDate.day,
        newEndDate.hour,
        newEndDate.minute,
      );
    }

    _endDateSubject.add(newEndDate);
  }

  get hasTv => _hasTvSubject.stream;

  set hasTv(value) => _hasTvSubject.add(value);
}
