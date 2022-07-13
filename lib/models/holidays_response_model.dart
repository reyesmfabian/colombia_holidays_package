import 'dart:convert';

YearsModel yearsModelFromJson(String str) =>
    YearsModel.fromJson(json.decode(str));

String yearsModelToJson(YearsModel data) => json.encode(data.toJson());

class YearsModel {
  YearsModel({
    required this.years,
  });

  List<Year> years;

  factory YearsModel.fromJson(Map<String, dynamic> json) => YearsModel(
        years: List<Year>.from(json["years"].map((x) => Year.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "years": List<dynamic>.from(years.map((x) => x.toJson())),
      };
}

class Year {
  Year({
    required this.year,
    required this.holidays,
  });

  int year;
  List<Holiday> holidays;

  factory Year.fromJson(Map<String, dynamic> json) => Year(
        year: json["year"],
        holidays: List<Holiday>.from(
            json["holidays"].map((x) => Holiday.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "holidays": List<dynamic>.from(holidays.map((x) => x.toJson())),
      };
}

class Holiday {
  Holiday({
    required this.date,
    required this.name,
    required this.holidayStatic,
  });

  String date;
  String name;
  bool holidayStatic;

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
        date: json["date"],
        name: json["name"],
        holidayStatic: json["static"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "name": name,
        "static": holidayStatic,
      };
}
