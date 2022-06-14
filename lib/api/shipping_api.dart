import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/model/user_shipping_address.dart';

getDefaultShippingAddress(token, userID) async {
  //set api url
  final queryParameters = {
    'userID': userID.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url = "http://192.168.0.157:8000/api/shipment/getDefaultShippingAddress";

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
    UserShippingAddress? userShippingAddress =
        UserShippingAddress.fromJson(jsonDecode(respStr));

    return userShippingAddress;
  } else {
    print("Failed");
  }
}

getALlUserShippingAddress(token, userID) async {
  //set api url
  final queryParameters = {
    'userID': userID.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url = "http://192.168.0.157:8000/api/shipment/getALlUserShippingAddress";

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
    List<UserShippingAddress> userShippingAddress =
        List<UserShippingAddress>.from(
            jsonResponse.map((model) => UserShippingAddress.fromJson(model)));
    print(userShippingAddress);
    return userShippingAddress;
  } else {
    print("Failed");
  }
}
