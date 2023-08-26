// To parse this JSON data, do
//
//     final pmCity = pmCityFromJson(jsonString);

import 'dart:convert';

PmCity pmCityFromJson(String str) => PmCity.fromJson(json.decode(str));

String pmCityToJson(PmCity data) => json.encode(data.toJson());

class PmCity {
  String? status;
  List<Datum>? data;

  PmCity({
    this.status,
    this.data,
  });

  factory PmCity.fromJson(Map<String, dynamic> json) => PmCity(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? uid;
  String? aqi;
  Time? time;
  Station? station;

  Datum({
    this.uid,
    this.aqi,
    this.time,
    this.station,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uid: json["uid"],
        aqi: json["aqi"],
        time: json["time"] == null ? null : Time.fromJson(json["time"]),
        station:
            json["station"] == null ? null : Station.fromJson(json["station"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "aqi": aqi,
        "time": time?.toJson(),
        "station": station?.toJson(),
      };
}

class Station {
  String? name;
  List<double>? geo;
  String? url;
  Country? country;

  Station({
    this.name,
    this.geo,
    this.url,
    this.country,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        name: json["name"],
        geo: json["geo"] == null
            ? []
            : List<double>.from(json["geo"]!.map((x) => x?.toDouble())),
        url: json["url"],
        country: countryValues.map[json["country"]],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "geo": geo == null ? [] : List<dynamic>.from(geo!.map((x) => x)),
        "url": url,
        "country": countryValues.reverse[country],
      };
}

enum Country { IN }

final countryValues = EnumValues({"IN": Country.IN});

class Time {
  Tz? tz;
  DateTime? stime;
  int? vtime;

  Time({
    this.tz,
    this.stime,
    this.vtime,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        tz: tzValues.map[json["tz"]],
        stime: json["stime"] == null ? null : DateTime.parse(json["stime"]),
        vtime: json["vtime"],
      );

  Map<String, dynamic> toJson() => {
        "tz": tzValues.reverse[tz],
        "stime": stime?.toIso8601String(),
        "vtime": vtime,
      };
}

enum Tz { THE_0530 }

final tzValues = EnumValues({"+05:30": Tz.THE_0530});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
