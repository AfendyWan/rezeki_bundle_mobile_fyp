import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/city.dart';
import 'package:rezeki_bundle_mobile/model/settings.dart';
import 'package:rezeki_bundle_mobile/model/state.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rezeki_bundle_mobile/api/APIRoute.dart';

import 'package:rezeki_bundle_mobile/main.dart';

import '../screens/Dashboard/dashboard.dart';

getAllStates() async {
  var url = hostURL + "/api/settings/showAllStates";

  var response = await http.get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
  });

  //get api result
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    List<Negeri> negeri =
        List<Negeri>.from(jsonResponse.map((model) => Negeri.fromJson(model)));
    return negeri;
  } else {
    print("Failed");
  }
}

getAllCities() async {
  var url = hostURL + "/api/settings/showAllCities";

  var response = await http.get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
  });

  //get api result
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    List<City> city =
        List<City>.from(jsonResponse.map((model) => City.fromJson(model)));

    return city;
  } else {
    print("Failed");
  }
}

getAdminSettings() async {
  var url = hostURL + "/api/settings/getAdminSettings";

  var response = await http.get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
  });


  //get api result
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    List<Setting> setting = List<Setting>.from(
        jsonResponse.map((model) => Setting.fromJson(model)));
  print(setting);
    return setting;
  } else {
    print("Failed");
  }
}

getAdminAnnouncement() async {
  var url = hostURL + "/api/settings/getAdminAnnouncement";

  var response = await http.get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
  });


  //get api result
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

   
  print(jsonResponse);
    return jsonResponse;
  } else {
    print("Failed");
  }
}
