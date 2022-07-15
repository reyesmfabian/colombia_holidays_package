import 'package:colombia_holidays/colombia_holidays.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('HolidaysService', () {
    // Create an instance
    //

    test('getHolidays', () async {
      ColombiaHolidays holidays = ColombiaHolidays();
      final holidaysByYear = await holidays.getHolidays(year: 2022);

      for (var holiday in holidaysByYear) {
        expect(holiday.date, isNotNull);
      }
    });

    test('isHoliday', () async {
      ColombiaHolidays holidays = ColombiaHolidays();
      final isHoliday =
          await holidays.isHoliday(day: 25, month: 12, year: 2022);
      expect(isHoliday, isNotNull);
    });
  });
}
