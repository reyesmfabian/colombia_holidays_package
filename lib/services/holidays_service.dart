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

    /// read the json file and convert it to a list of holidays.
    final response = await rootBundle.loadString(path);

    final yearsResult = await compute(_getyears, response);

    /// Get the holidays for the given year.
    final result = yearsResult.firstWhere((finYear) => finYear.year == year);

    /// Return the holidays for the given year.
    return result.holidays;
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
    if (month < 0 || month > 12) {
      throw ArgumentError('Month must be between 0 and 12');
    }

    /// Validate the day parameter, must be greater than 0 and less than 32.
    if (day < 0 || day > 31) {
      throw ArgumentError('Day must be between 1 and 31');
    }

    /// validate the year parameter, must be greater than 1900 and less than 2299.
    if (year < 1900 || year > 2299) {
      throw ArgumentError('Year must be between 1900 and 2299');
    }

    /// read the json file and convert it to a list of holidays.
    bool isHoliday = false;

    /// Parse two digits month
    String finalMoth = month < 10 ? '0$month' : '$month';

    /// Create the date string.
    final date = '$day/$finalMoth/$year';

    /// Read the json file and convert it to a list of holidays.
    final response = await rootBundle.loadString(path);

    /// Get the holidays.
    final yearsResult = await compute(_getyears, response);

    /// Check if the given date is a holiday.
    for (var year in yearsResult) {
      for (var holiday in year.holidays) {
        if (holiday.date == date) {
          isHoliday = true;
        }
      }
    }

    /// Return if the day is a holiday.
    return isHoliday;
  }

  /// **Convert the years to Json for manipulation**.
  ///

  List<Year> _getyears(String response) {
    /// Convert the json to a list of years.
    final json = jsonDecode(response);

    /// Convert the json to a list of years.
    final yearsResponse = YearsModel.fromJson(json);

    /// Return the list of years.
    return yearsResponse.years;
  }
}
