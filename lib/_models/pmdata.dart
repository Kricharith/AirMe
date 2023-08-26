// To parse this JSON data, do
//
//     final pMdata = pMdataFromJson(jsonString);

import 'dart:convert';

PMdata pMdataFromJson(String str) => PMdata.fromJson(json.decode(str));

String pMdataToJson(PMdata data) => json.encode(data.toJson());

class PMdata {
  String? status;
  Data? data;

  PMdata({
    this.status,
    this.data,
  });

  factory PMdata.fromJson(Map<String, dynamic> json) => PMdata(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  int? aqi;
  int? idx;
  List<Attribution>? attributions;
  City? city;
  String? dominentpol;
  Iaqi? iaqi;
  Time? time;
  Forecast? forecast;
  Debug? debug;

  Data({
    this.aqi,
    this.idx,
    this.attributions,
    this.city,
    this.dominentpol,
    this.iaqi,
    this.time,
    this.forecast,
    this.debug,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        aqi: json["aqi"],
        idx: json["idx"],
        attributions: json["attributions"] == null
            ? []
            : List<Attribution>.from(
                json["attributions"]!.map((x) => Attribution.fromJson(x))),
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        dominentpol: json["dominentpol"],
        iaqi: json["iaqi"] == null ? null : Iaqi.fromJson(json["iaqi"]),
        time: json["time"] == null ? null : Time.fromJson(json["time"]),
        forecast: json["forecast"] == null
            ? null
            : Forecast.fromJson(json["forecast"]),
        debug: json["debug"] == null ? null : Debug.fromJson(json["debug"]),
      );

  Map<String, dynamic> toJson() => {
        "aqi": aqi,
        "idx": idx,
        "attributions": attributions == null
            ? []
            : List<dynamic>.from(attributions!.map((x) => x.toJson())),
        "city": city?.toJson(),
        "dominentpol": dominentpol,
        "iaqi": iaqi?.toJson(),
        "time": time?.toJson(),
        "forecast": forecast?.toJson(),
        "debug": debug?.toJson(),
      };
}

class Attribution {
  String? url;
  String? name;
  String? logo;

  Attribution({
    this.url,
    this.name,
    this.logo,
  });

  factory Attribution.fromJson(Map<String, dynamic> json) => Attribution(
        url: json["url"],
        name: json["name"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "name": name,
        "logo": logo,
      };
}

class City {
  List<double>? geo;
  String? name;
  String? url;
  String? location;

  City({
    this.geo,
    this.name,
    this.url,
    this.location,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        geo: json["geo"] == null
            ? []
            : List<double>.from(json["geo"]!.map((x) => x?.toDouble())),
        name: json["name"],
        url: json["url"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "geo": geo == null ? [] : List<dynamic>.from(geo!.map((x) => x)),
        "name": name,
        "url": url,
        "location": location,
      };
}

class Debug {
  DateTime? sync;

  Debug({
    this.sync,
  });

  factory Debug.fromJson(Map<String, dynamic> json) => Debug(
        sync: json["sync"] == null ? null : DateTime.parse(json["sync"]),
      );

  Map<String, dynamic> toJson() => {
        "sync": sync?.toIso8601String(),
      };
}

class Forecast {
  Daily? daily;

  Forecast({
    this.daily,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        daily: json["daily"] == null ? null : Daily.fromJson(json["daily"]),
      );

  Map<String, dynamic> toJson() => {
        "daily": daily?.toJson(),
      };
}

class Daily {
  List<O3>? o3;
  List<O3>? pm10;
  List<O3>? pm25;
  List<O3>? uvi;

  Daily({
    this.o3,
    this.pm10,
    this.pm25,
    this.uvi,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        o3: json["o3"] == null
            ? []
            : List<O3>.from(json["o3"]!.map((x) => O3.fromJson(x))),
        pm10: json["pm10"] == null
            ? []
            : List<O3>.from(json["pm10"]!.map((x) => O3.fromJson(x))),
        pm25: json["pm25"] == null
            ? []
            : List<O3>.from(json["pm25"]!.map((x) => O3.fromJson(x))),
        uvi: json["uvi"] == null
            ? []
            : List<O3>.from(json["uvi"]!.map((x) => O3.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "o3": o3 == null ? [] : List<dynamic>.from(o3!.map((x) => x.toJson())),
        "pm10": pm10 == null
            ? []
            : List<dynamic>.from(pm10!.map((x) => x.toJson())),
        "pm25": pm25 == null
            ? []
            : List<dynamic>.from(pm25!.map((x) => x.toJson())),
        "uvi":
            uvi == null ? [] : List<dynamic>.from(uvi!.map((x) => x.toJson())),
      };
}

class O3 {
  int? avg;
  DateTime? day;
  int? max;
  int? min;

  O3({
    this.avg,
    this.day,
    this.max,
    this.min,
  });

  factory O3.fromJson(Map<String, dynamic> json) => O3(
        avg: json["avg"],
        day: json["day"] == null ? null : DateTime.parse(json["day"]),
        max: json["max"],
        min: json["min"],
      );

  Map<String, dynamic> toJson() => {
        "avg": avg,
        "day":
            "${day!.year.toString().padLeft(4, '0')}-${day!.month.toString().padLeft(2, '0')}-${day!.day.toString().padLeft(2, '0')}",
        "max": max,
        "min": min,
      };
}

class Iaqi {
  Co? co;
  Co? h;
  Co? no2;
  Co? o3;
  Co? p;
  Co? pm10;
  Co? pm25;
  Co? so2;
  Co? t;
  Co? w;

  Iaqi({
    this.co,
    this.h,
    this.no2,
    this.o3,
    this.p,
    this.pm10,
    this.pm25,
    this.so2,
    this.t,
    this.w,
  });

  factory Iaqi.fromJson(Map<String, dynamic> json) => Iaqi(
        co: json["co"] == null ? null : Co.fromJson(json["co"]),
        h: json["h"] == null ? null : Co.fromJson(json["h"]),
        no2: json["no2"] == null ? null : Co.fromJson(json["no2"]),
        o3: json["o3"] == null ? null : Co.fromJson(json["o3"]),
        p: json["p"] == null ? null : Co.fromJson(json["p"]),
        pm10: json["pm10"] == null ? null : Co.fromJson(json["pm10"]),
        pm25: json["pm25"] == null ? null : Co.fromJson(json["pm25"]),
        so2: json["so2"] == null ? null : Co.fromJson(json["so2"]),
        t: json["t"] == null ? null : Co.fromJson(json["t"]),
        w: json["w"] == null ? null : Co.fromJson(json["w"]),
      );

  Map<String, dynamic> toJson() => {
        "co": co?.toJson(),
        "h": h?.toJson(),
        "no2": no2?.toJson(),
        "o3": o3?.toJson(),
        "p": p?.toJson(),
        "pm10": pm10?.toJson(),
        "pm25": pm25?.toJson(),
        "so2": so2?.toJson(),
        "t": t?.toJson(),
        "w": w?.toJson(),
      };
}

class Co {
  double? v;

  Co({
    this.v,
  });

  factory Co.fromJson(Map<String, dynamic> json) => Co(
        v: json["v"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "v": v,
      };
}

class Time {
  DateTime? s;
  String? tz;
  int? v;
  DateTime? iso;

  Time({
    this.s,
    this.tz,
    this.v,
    this.iso,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        s: json["s"] == null ? null : DateTime.parse(json["s"]),
        tz: json["tz"],
        v: json["v"],
        iso: json["iso"] == null ? null : DateTime.parse(json["iso"]),
      );

  Map<String, dynamic> toJson() => {
        "s": s?.toIso8601String(),
        "tz": tz,
        "v": v,
        "iso": iso?.toIso8601String(),
      };
}
