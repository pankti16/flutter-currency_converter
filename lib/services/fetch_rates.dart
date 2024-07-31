import 'dart:convert';

import 'package:currency_converter/models/currency_model.dart';
import 'package:currency_converter/models/rates_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:currency_converter/common/constants.dart';

Future<RatesModel> fetchRates() async {
  try {
    final response = await http.get(Uri.parse(kAllLatestApi));
    if (response.statusCode == 200) {
      return RatesModel.fromJSON(json.decode(response.body));
    } else {
      Fluttertoast.showToast(msg: "Error fetching rates, error status code: ${response.statusCode}");
      throw Exception("Error fetching rates, error status code: ${response.statusCode}");
    }
  } catch(e) {
    debugPrint(e.toString());
    Fluttertoast.showToast(msg: "Error fetching rates, ${e.toString()}");
    throw Exception("Error fetching rates, ${e.toString()}");
  }
}

Future<Map> fetchCurrencies() async {
  try {
    final response = await http.get(Uri.parse(kAllCurrencyApi));
    if (response.statusCode == 200) {
      return allCurrenciesFromJson(response.body);
    } else {
      Fluttertoast.showToast(msg: "Error fetching currencies, error status code: ${response.statusCode}");
      throw Exception("Error fetching currencies, error status code: ${response.statusCode}");
    }
  } catch(e) {
    debugPrint(e.toString());
    Fluttertoast.showToast(msg: "Error fetching currencies, ${e.toString()}");
    throw Exception("Error fetching currencies, ${e.toString()}");
  }
}
