import 'package:colombia_holidays/colombia_holidays.dart';
import 'package:flutter/foundation.dart';

void main() async {
  /// Create an instance
  ///
  ColombiaHolidays holidays = ColombiaHolidays();

  /// **This function returns a list of holidays for a given year**.
  ///
  /// Args:
  /// * [year]: The year for which you want to get the holidays....
  ///

  final holidaysByYear = await holidays.getHolidays(year: 2020);
  for (var holiday in holidaysByYear) {
    if (kDebugMode) {
      print(holiday.date);
    }
  }
  // Result is a List of Holidays
  /// **Checks if the given date is a holiday.
  ///
  /// Args:
  /// * [day]: Day of the month.
  /// * [month]: Month of the year.
  /// * [year]: year.
  ///
  final isHoliday = await holidays.isHoliday(day: 20, month: 12, year: 2022);

  if (kDebugMode) {
    print(isHoliday);
  }
}
