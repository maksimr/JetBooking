import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:jetbooking/controllers/DetailsScreenController.dart';

import '../http.dart';
import '../api/vc.dart';

void main() {
  DateTime date;
  DetailsScreenController $ctrl;

  setUp(() {
    date = DateTime(2018, 1, 1, 11, 30);
    dumbZone(() => $ctrl = DetailsScreenController(date));
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

  test(
      'should automatically correct end date and move it to the next day if end date less than start date',
      () {
    final newEndDate = date.add(Duration(hours: -1));

    $ctrl.endDate = newEndDate;

    expect($ctrl.startDate, emitsInOrder([date]));
    expect(
        $ctrl.endDate,
        emitsInOrder([
          DateTime(
            date.year,
            date.month,
            date.day + 1,
            newEndDate.hour,
            newEndDate.minute,
          )
        ]));
  });

  test(
      'should automatically correct end date and move it to start day if diffirence between end and start dates more than one day',
      () {
    final newEndDate = date.add(Duration(days: 1, minutes: 30));

    $ctrl.endDate = newEndDate;

    expect($ctrl.startDate, emitsInOrder([date]));
    expect(
        $ctrl.endDate,
        emitsInOrder([
          DateTime(
            date.year,
            date.month,
            date.day,
            newEndDate.hour,
            newEndDate.minute,
          )
        ]));
  });

  test('should load vacant rooms', () {
    runHttpZoned((client) {
      final startTime = date;
      final endTime = startTime.add(Duration(minutes: 30));
      final rooms = [createRoomMock()];

      when(client.getUrl(vcVacantRoomsUrlFor(startTime, endTime)))
          .thenAnswer(response(toJson(rooms)));

      expect(DetailsScreenController(date).rooms, emitsInOrder([rooms]));
    });
  });
}
