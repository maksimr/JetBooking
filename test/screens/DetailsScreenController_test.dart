import 'package:test/test.dart';
import 'package:jetbooking/screens/DetailsScreenController.dart';

void main() {
  DateTime date;
  DetailsScreenController $ctrl;

  setUp(() {
    date = DateTime(2018, 1, 1, 11, 30);
    $ctrl = DetailsScreenController(date);
  });

  test('should create controller', () {
    expect($ctrl, isNotNull);
  });

  test('should set default values', () {
    expect($ctrl.startDate, emitsAnyOf([TypeMatcher<DateTime>()]));
    expect($ctrl.endDate, emitsAnyOf([TypeMatcher<DateTime>()]));
    expect($ctrl.hasTv, emitsAnyOf([TypeMatcher<bool>()]));
  });

  test('should set default duration equals to 30 minutes', () {
    expect($ctrl.startDate, emitsInOrder([date]));
    expect($ctrl.endDate, emitsInOrder([date.add(Duration(minutes: 30))]));
  });

  test('should set default tv equals to false', () {
    expect($ctrl.hasTv, emitsInOrder([false]));
  });

  test('should change end date(preserve duration) if we change start date', () {
    final duration = Duration(minutes: 30);
    final newStartDate = date.add(Duration(hours: 1));

    $ctrl.startDate = newStartDate;

    expect($ctrl.startDate, emitsInOrder([newStartDate]));
    expect($ctrl.endDate,
        emitsInOrder([date.add(duration), newStartDate.add(duration)]));
  });

  test('should change end date', () {
    final newEndDate = date.add(Duration(hours: 1));

    $ctrl.endDate = newEndDate;

    expect($ctrl.startDate, emitsInOrder([date]));
    expect($ctrl.endDate, emitsInOrder([newEndDate]));
  });
}
