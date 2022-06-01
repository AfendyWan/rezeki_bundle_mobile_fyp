import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/model/user.dart';

changeProfilePhoto(context, userID, profileImage) async {
  var url = "http://192.168.0.157:8000/api/auth/changeProfilePhoto?";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  var request = http.MultipartRequest('POST', Uri.parse(url))
    ..files.add(
        await http.MultipartFile.fromPath('profileImage', profileImage.path));
  request.headers.addAll(headers);

  request.fields['userID'] = userID.toString();

  var response = await request.send();
  final respStr = await response.stream.bytesToString();
  if (response.statusCode == 200) {
  } else {}
}

getProfilePhoto(
  token,
  context,
  userID,
) async {
  //set api url
  final queryParameters = {
    'userID': userID.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url = "http://192.168.0.157:8000/api/auth/getProfilePhoto?";
  Uri uri = Uri.parse(url);
  final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS
  print(finalUri);
  final response = await http.get(
    finalUri,
    headers: header,
  );

  var respStr = await response.body;
  var jsonResponse = jsonDecode(respStr);

  //get api result
  if (response.statusCode == 200) {
    print(jsonResponse);
    return jsonResponse;
  } else {
    print("Failedsss");
  }
}

updateUserData(
  context,
  userID,
  firstName,
  lastName,
  email,
  gender,
  phoneNumber,
  postCode,
) async {
  var url = "http://192.168.0.157:8000/api/auth/updateUserData";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers.addAll(headers);
  request.fields['userID'] = userID.toString();
  request.fields['first_name'] = firstName.toString();
  request.fields['last_name'] = lastName.toString();
  request.fields['email'] = email.toString();
  request.fields['gender'] = gender.toString();
  request.fields['postcode'] = postCode;
  request.fields['phone_number'] = phoneNumber.toString();

  var response = await request.send();
  var respStr = await http.Response.fromStream(response);
  var jsonResponse = jsonDecode(respStr.body);
  print(jsonResponse);
  if (response.statusCode == 200) {
    var success = "success";
    return success;
  } else {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //  title: Text(error),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"))
            ],
          );
        });
  }
}

changeUserPassword(context, userID, newPassord, oldPassword) async {
  var url = "http://192.168.0.157:8000/api/auth/changeUserPassword";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };
 print(oldPassword);
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers.addAll(headers);
  request.fields['userID'] = userID.toString();

  request.fields['newPassword'] = newPassord;
  request.fields['oldPassword'] = oldPassword;

  var response = await request.send();
  var respStr = await http.Response.fromStream(response);
  var jsonResponse = jsonDecode(respStr.body);

  print(jsonResponse);
  if (response.statusCode == 200) {
    var results = "success";
    return results;
  } else if (response.statusCode == 402) {
    var results = "passwordNotMatch";
    return results;
  } else if (response.statusCode == 403) {
    var results = "validation";
    return results;
  } else {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //  title: Text(error),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"))
            ],
          );
        });
  }
}
