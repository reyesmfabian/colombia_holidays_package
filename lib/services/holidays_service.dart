import 'dart:convert';

import 'package:colombia_holidays/models/holidays_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ColombiaHolidays {
  final path = 'packages/colombia_holidays/assets/holidays.json';

  ///

  /// **Esta función devuelve una lista de días festivos para un año determinado**
  ///
  /// Args:
  ///   * [year]: El año para el que desea obtener los festivos..
  ///
  Future<List<Holiday>> getHolidays({required int year}) async {
    year < 1900 ? throw ArgumentError('Year must be greater than 1900') : null;
    final response = await rootBundle.loadString(path);
    final yearsResult = await compute(_getyears, response);
    final result = yearsResult.firstWhere((finYear) => finYear.year == year);
    return result.holidays;
  }

  /// **Comprueba si la fecha dada es un día festivo.**
  ///
  /// Args:
  ///   * [day]: Día del mes.
  ///   * [month]: Mes del año.
  ///   * [year]: Mes del año.
  ///

  Future<bool> isHoliday(
      {required int day, required int month, required int year}) async {
    month < 0 || month > 12
        ? throw ArgumentError('Month must be between 0 and 12')
        : null;
    if (day < 0 || day > 31) {
      throw ArgumentError('Day must be between 1 and 31');
    }
    if (year < 1900 || year > 2299) {
      throw ArgumentError('Year must be between 1900 and 2299');
    }

    bool isHoliday = false;
    String finalMoth = month < 10 ? '0$month' : '$month';
    final date = '$day/$finalMoth/$year';
    final response = await rootBundle.loadString(path);
    final yearsResult = await compute(_getyears, response);
    for (var year in yearsResult) {
      for (var holiday in year.holidays) {
        if (holiday.date == date) {
          isHoliday = true;
        }
      }
    }
    return isHoliday;
  }

  List<Year> _getyears(String response) {
    final json = jsonDecode(response);
    final yearsResponse = YearsModel.fromJson(json);
    return yearsResponse.years;
  }
}
