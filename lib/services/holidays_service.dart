import 'dart:convert';

import 'package:colombia_holidays/models/holidays_response_model.dart';
import 'package:flutter/services.dart';

class ColombiaHolidays {
  final path = 'packages/colombia_holidays/assets/holidays.json';

  Future<List<Holiday>> getHolidays({required int year}) async {
    year < 1900 ? throw ArgumentError('Year must be greater than 1900') : null;
    final response = await rootBundle.loadString(path);
    final json = jsonDecode(response);
    final yearsResponse = YearsModel.fromJson(json);
    final result =
        yearsResponse.years.firstWhere((finYear) => finYear.year == year);
    return result.holidays;
  }

  Future<bool> isHoliday(
      {required int day, required int month, required int year}) async {
    month < 0 || month > 12
        ? throw ArgumentError('Month must be between 0 and 12')
        : null;
    day < 0 || day > 31
        ? throw ArgumentError('Day must be between 1 and 31')
        : null;
    year < 1900 ? throw ArgumentError('Year must be greater than 1900') : null;

    bool isHoliday = false;
    String finalMoth = month < 10 ? '0$month' : '$month';
    final date = '$day/$finalMoth/$year';
    final response = await rootBundle.loadString(path);
    final json = await jsonDecode(response);
    final yearsResponse = YearsModel.fromJson(json);
    for (var year in yearsResponse.years) {
      for (var holiday in year.holidays) {
        if (holiday.date == date) {
          isHoliday = true;
        }
      }
    }
    return isHoliday;
  }
}