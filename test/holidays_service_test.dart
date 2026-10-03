import 'package:colombia_holidays/colombia_holidays.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('HolidaysService', () {
    final holidays = ColombiaHolidays();

    test('getHolidays', () async {
      final holidaysByYear = await holidays.getHolidays(year: 2020);

      expect(holidaysByYear, hasLength(18));
      for (var holiday in holidaysByYear) {
        expect(holiday.date, isNotNull);
      }
    });

    test('getHolidays returns the official 2025 holidays', () async {
      final dates = (await holidays.getHolidays(year: 2025))
          .map((holiday) => holiday.date)
          .toSet();

      expect(dates, {
        '01/01/2025',
        '06/01/2025',
        '24/03/2025',
        '17/04/2025',
        '18/04/2025',
        '01/05/2025',
        '02/06/2025',
        '23/06/2025',
        '30/06/2025',
        '20/07/2025',
        '07/08/2025',
        '18/08/2025',
        '13/10/2025',
        '03/11/2025',
        '17/11/2025',
        '08/12/2025',
        '25/12/2025',
      });
    });

    test('Holy week is correct when Easter is on April 18 (2049)', () async {
      expect(await holidays.isHoliday(day: 15, month: 4, year: 2049), isTrue);
      expect(await holidays.isHoliday(day: 16, month: 4, year: 2049), isTrue);
      expect(await holidays.isHoliday(day: 22, month: 4, year: 2049), isFalse);
    });

    test('Holy week is correct after 2099', () async {
      // Easter 2100 is March 28.
      expect(await holidays.isHoliday(day: 25, month: 3, year: 2100), isTrue);
      expect(await holidays.isHoliday(day: 26, month: 3, year: 2100), isTrue);
    });

    test('isHoliday', () async {
      expect(await holidays.isHoliday(day: 25, month: 12, year: 2022), isTrue);
      expect(await holidays.isHoliday(day: 26, month: 12, year: 2022), isFalse);
    });

    test('isHoliday works with single digit days', () async {
      expect(await holidays.isHoliday(day: 1, month: 1, year: 2024), isTrue);
      expect(await holidays.isHoliday(day: 8, month: 1, year: 2024), isTrue);
      expect(await holidays.isHoliday(day: 2, month: 1, year: 2024), isFalse);
    });

    test('isHoliday rejects invalid dates', () {
      expect(() => holidays.isHoliday(day: 0, month: 1, year: 2024),
          throwsArgumentError);
      expect(() => holidays.isHoliday(day: 1, month: 0, year: 2024),
          throwsArgumentError);
      expect(() => holidays.getHolidays(year: 1899), throwsArgumentError);
    });

    test('modifying the result does not affect later calls', () async {
      final first = await holidays.getHolidays(year: 2024);
      first.first.date = 'changed';
      first.clear();

      final second = await holidays.getHolidays(year: 2024);
      expect(second, hasLength(18));
      expect(second.first.date, '01/01/2024');
    });
  });
}
