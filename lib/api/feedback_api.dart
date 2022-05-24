import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/model/cart.dart';
import 'package:rezeki_bundle_mobile/model/cart_item.dart';
import 'package:rezeki_bundle_mobile/model/feedback.dart';

getAllUserFeedback(token) async {
  //set api url
  var url = "http://192.168.0.157:8000/api/feedback/getUsersFeedback";

  //initiate api
  var response = await http.get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
  });

  //get api result
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    List<Feedbacks> feedback = List<Feedbacks>.from(
        jsonResponse.map((model) => Feedbacks.fromJson(model)));

    return feedback;
  } else {
    print("Failed");
  }
}