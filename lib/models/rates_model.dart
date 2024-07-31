import 'dart:convert';

class RatesModel {
  final String disclaimer;
  final String license;
  final int timestamp;
  final String base;
  final Map<String, double> rates;

  RatesModel({required this.disclaimer, required this.license, required this.timestamp, required this.base, required this.rates});

  factory RatesModel.fromJSON(Map<String, dynamic> json) {
    return RatesModel(
      disclaimer: json['disclaimer'],
      license: json['license'],
      timestamp: json['timestamp'],
      base: json['base'],
      rates: Map.from(json['rates']).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'disclaimer': disclaimer,
      'license': license,
      'timestamp': timestamp,
      'base': base,
      'rates': json.encode(rates),
    };
  }
}