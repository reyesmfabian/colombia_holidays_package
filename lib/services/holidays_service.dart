import 'dart:convert';

import 'package:colombia_holidays/models/holidays_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ColombiaHolidays {
  /// Local Json file path
  final path = 'packages/colombia_holidays/assets/holidays.json';

  ///

  /// **This function returns a list of holidays for a given year**.
  ///
  /// Args:
  /// * [year]: The year for which you want to get the holidays....
  ///
  Future<List<Holiday>> getHolidays({required int year}) async {
    /// Validate the year parameter, must be greater than 1900 and less than 2299.
    if (year < 1900 || year > 2299) {
      throw ArgumentError('Year must be between 1900 and 2299');
    }

    /// Get the list of holidays
    final yearsResult = await _loadYears();

    /// Find the holidays for the given year.
    final result = yearsResult.firstWhere((finYear) => finYear.year == year);

    /// Return a copy of the holidays for the given year, so the cache can't be modified.
    return result.holidays
        .map((holiday) => Holiday.fromJson(holiday.toJson()))
        .toList();
  }

  /// **Checks if the given date is a holiday.
  ///
  /// Args:
  /// * [day]: Day of the month.
  /// * [month]: Month of the year.
  /// * [year]: year.
  ///
  Future<bool> isHoliday(
      {required int day, required int month, required int year}) async {
    /// Validate the month parameter, must be greater than 0 and less than 13.
    if (month < 1 || month > 12) {
      throw ArgumentError('Month must be between 1 and 12');
    }

    /// Validate the day parameter, must be greater than 0 and less than 32.
    if (day < 1 || day > 31) {
      throw ArgumentError('Day must be between 1 and 31');
    }

    /// validate the year parameter, must be greater than 1900 and less than 2299.
    if (year < 1900 || year > 2299) {
      throw ArgumentError('Year must be between 1900 and 2299');
    }

    /// Create the date string with the same dd/MM/yyyy format of the json file.
    final date = '${day.toString().padLeft(2, '0')}/'
        '${month.toString().padLeft(2, '0')}/$year';

    /// Get the holidays of the given year.
    final holidays = await getHolidays(year: year);

    /// Return if the day is a holiday.
    return holidays.any((holiday) => holiday.date == date);
  }

  /// Parsed years, loaded only once.
  static Future<List<Year>>? _years;

  /// **Read the json file and convert it to a list of years**.
  Future<List<Year>> _loadYears() {
    return _years ??= rootBundle
        .loadString(path)
        .then((response) => compute(_getyears, response))
        .catchError((Object error, StackTrace stackTrace) {
      _years = null;
      Error.throwWithStackTrace(error, stackTrace);
    });
  }

  /// **Convert the years to Json for manipulation**.
  static List<Year> _getyears(String response) {
    /// Convert the json to a list of years.
    final json = jsonDecode(response);

    /// Convert the json to a list of years.
    final yearsResponse = YearsModel.fromJson(json);

    /// Return the list of years.
    return yearsResponse.years;
  }
}
