import 'package:colombia_holidays/colombia_holidays.dart';

void main() async {
  ColombiaHolidays holidays = ColombiaHolidays();

// Get all holidays by Year
  final holidaysByYear = await holidays.getHolidays(year: 2020);
  // Result is a List of Holidays
  print(holidaysByYear);

// Check if a date is a holiday
  final isHoliday = await holidays.isHoliday(day: 20, month: 12, year: 2022);
  // Result is a bool
  print(isHoliday);
}
