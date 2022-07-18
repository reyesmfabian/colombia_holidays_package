import 'dart:convert';

/// Convert a json string to HolidaysResponseModel
YearsModel yearsModelFromJson(String str) =>
    YearsModel.fromJson(json.decode(str));

/// Convert a HolidaysResponseModel to json string
String yearsModelToJson(YearsModel data) => json.encode(data.toJson());

/// Year Model response*.
///
///
class YearsModel {
  YearsModel({
    required this.years,
  });

  List<Year> years;

  /// Convert a json string to HolidaysResponseModel*
  factory YearsModel.fromJson(Map<String, dynamic> json) => YearsModel(
        years: List<Year>.from(json["years"].map((x) => Year.fromJson(x))),
      );

  /// Convert a HolidaysResponseModel to json string*
  Map<String, dynamic> toJson() => {
        "years": List<dynamic>.from(years.map((x) => x.toJson())),
      };
}

/// Year Model*
class Year {
  Year({
    required this.year,
    required this.holidays,
  });

  int year;
  List<Holiday> holidays;

  /// Convert a json string to Year
  factory Year.fromJson(Map<String, dynamic> json) => Year(
        year: json["year"],
        holidays: List<Holiday>.from(
            json["holidays"].map((x) => Holiday.fromJson(x))),
      );

  /// Convert a Year to json string
  Map<String, dynamic> toJson() => {
        "year": year,
        "holidays": List<dynamic>.from(holidays.map((x) => x.toJson())),
      };
}

/// Holiday Model
class Holiday {
  Holiday({
    required this.date,
    required this.name,
    required this.holidayStatic,
  });

  String date;
  String name;
  bool holidayStatic;

  /// Convert a json string to Holiday
  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
        date: json["date"],
        name: json["name"],
        holidayStatic: json["static"],
      );

  /// Convert a Holiday to json string
  Map<String, dynamic> toJson() => {
        "date": date,
        "name": name,
        "static": holidayStatic,
      };
}
