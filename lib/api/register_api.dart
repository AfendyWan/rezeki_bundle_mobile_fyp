import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/model/errors.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/api/APIRoute.dart';
import '../screens/Dashboard/dashboard.dart';

registerAcc(context, firstName, lastName, email, gender, phoneNumber,
    shippingAddress, postCode, states, city, password) async {
  var url = "http://192.168.0.157:8000/api/auth/register";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers.addAll(headers);
  request.fields['first_name'] = firstName.toString();
  request.fields['last_name'] = lastName.toString();
  request.fields['email'] = email.toString();
  request.fields['gender'] = gender.toString();
  request.fields['postcode'] = postCode;
  request.fields['phone_number'] = phoneNumber.toString();
  request.fields['shipping_address'] = shippingAddress.toString();
  request.fields['password'] = password.toString();
  request.fields['state'] = states.toString();
  request.fields['city'] = city.toString();
  var response = await request.send();
  var respStr = await http.Response.fromStream(response);
  var jsonResponse = jsonDecode(respStr.body);
  print(jsonResponse);
  if (response.statusCode == 200) {
    User? userdata = User.fromJson(jsonDecode(respStr.body));
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
