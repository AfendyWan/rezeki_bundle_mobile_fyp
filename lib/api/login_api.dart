import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rezeki_bundle_mobile/api/APIRoute.dart';



import 'package:rezeki_bundle_mobile/main.dart';

import '../screens/Dashboard/dashboard.dart';

loginAcc(context, username, password) async {
  print(username);
  print(password);
  var url = Uri.https(apiRequest, api["APIAuth"]["apiLogin"]);
  print(url);
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"username": username, "password": password}));
  var jsonResponse = jsonDecode(response.body);
  print(jsonResponse);

  if (response.statusCode == 200) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('password', password);

    print(jsonResponse["access_token"]);
    print(jsonResponse["user"]);
    var token = jsonResponse["access_token"];
    User userdata = User.fromJson(jsonResponse["user"]);
   
    print("Login");
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => DashboardScreen(
                  userdata: userdata,
                  token: token,
                
                )),
        (Route<dynamic> route) => false);
  } else {
    print("Login Failed");
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(jsonResponse["error"]),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text("OK"))
            ],
          );
        });
  }
}







storeFCMToken(id, fcmToken) async {
  print(id);
  print(fcmToken);
  var url = Uri.https(apiRequest, api["APIAuth"]["apiFCM"]);
  print(url);
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"id": id, "fcm_token": fcmToken}));

  var jsonResponse = jsonDecode(response.body);
  print(jsonResponse);

  if (response.statusCode == 200) {
    print("Success");
  } else {
    print("Failed");
  }
}

destroyFCMToken(id) async {
  print(id);
  var url = Uri.https(apiRequest, api["APIAuth"]["apiDestroyFCM"]);
  print(url);
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"id": id}));

  var jsonResponse = jsonDecode(response.body);
  print(jsonResponse);

  if (response.statusCode == 200) {
    print("Success");
  } else {
    print("Failed");
  }
}

refreshDetails(token, id) async {
  var url = Uri.https(apiRequest, api["APIAuth"]["apiMe"] + id.toString());
  print(url);
  var response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer " + token
    },
  );

  var jsonResponse = jsonDecode(response.body);

  if (response.statusCode == 200) {
    print("Success");
    return jsonResponse;
  } else {
    print("Failed");
  }
}
