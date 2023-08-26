import 'dart:convert';

import 'package:airme/_models/PMdata.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class PmTrackerService with ChangeNotifier {
  String _api = '';
  PMdata? aqiData;
  PmTrackerService(String api) {
    this.api = api;
    print(this.api);
  }
  String get api => this._api;

  set api(String newApi) {
    _api = newApi;
    notifyListeners();
  }

  Future<PMdata?> getPmTrackerData() async {
    final response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      notifyListeners();
      var res = PMdata.fromJson(jsonDecode(response.body));
      this.aqiData = res;
      print('yes');
      return res;
    } else {
      print('no');
      return null;
    }
  }
}
