import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rezeki_bundle_mobile/api/APIRoute.dart';

import 'dart:io';

import 'package:rezeki_bundle_mobile/main.dart';

import '../screens/Dashboard/dashboard.dart';

loginAcc(context, email, password) async {
  var url = "http://192.168.0.157:8000/api/auth/login";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers.addAll(headers);
  request.fields['email'] = email.toString();
  request.fields['password'] = password.toString();
  var response = await request.send();
  var respStr = await response.stream.bytesToString();
  var jsonResponse = jsonDecode(respStr);
  print(jsonResponse);
  if (response.statusCode == 200) {
    User? userdata = User.fromJson(jsonDecode(respStr));
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => DashboardScreen(
                  userdata: userdata,
                  token: userdata.token,
                )),
        (Route<dynamic> route) => false);
  } else {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(jsonResponse["errors"]),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"))
            ],
          );
        });
  }
}

logout(token, email, password, userID) async {
 

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    
  };

  final queryParameters = {
   
   'userID': userID.toString(),   
  
  };

    Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Bearer $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

   var url = "http://192.168.0.157:8000/api/auth/logout";

  Uri uri = Uri.parse(url);
  final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS
  print(finalUri);

  final response = await http.post(
    finalUri,
    headers: header,
  );

  var respStr = await response.body;
  var jsonResponse = jsonDecode(respStr);

  print(jsonResponse);
  if (response.statusCode == 200) {
    return "success";
  } else {}
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
