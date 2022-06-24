import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/model/shipment.dart';
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

updateUserShipping(token, fullName, phoneNumber, shipmentID, userID, shipping_address, state, city,
    postcode, shipping_default_status) async {
  //set api url
  final queryParameters = {
    'id': shipmentID.toString(),
    'userID': userID.toString(),
    'fullName': fullName.toString(),
    'phoneNumber': phoneNumber.toString(),
    'shipping_address': shipping_address,
    'state': state.toString(),
    'city': city.toString(),
    'postcode': postcode.toString(),
    'shipping_default_status': shipping_default_status.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url = "http://192.168.0.157:8000/api/shipment/updateUserShipping";

  Uri uri = Uri.parse(url);
  final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS

  print(finalUri);
  final response = await http.post(
    finalUri,
    headers: header,
  );

  var respStr = await response.body;
  var jsonResponse = jsonDecode(respStr);

  //get api result
  if (response.statusCode == 200) {
    var results = "success";
    return results;
  } else {
    print("Failed");
  }
}

addUserShippingAddress(token, fullName, phoneNumber, userID, shipping_address, state, city, postcode,
    shipping_default_status) async {
  //set api url
  final queryParameters = {
    'userID': userID.toString(),
     'fullName': fullName.toString(),
    'phoneNumber': phoneNumber.toString(),
    'shipping_address': shipping_address,
    'state': state.toString(),
    'city': city.toString(),
    'postcode': postcode.toString(),
    'shipping_default_status': shipping_default_status.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url = "http://192.168.0.157:8000/api/shipment/addUserShippingAddress";

  Uri uri = Uri.parse(url);
  final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS

  print(finalUri);
  final response = await http.post(
    finalUri,
    headers: header,
  );

  var respStr = await response.body;
  var jsonResponse = jsonDecode(respStr);

  //get api result
  if (response.statusCode == 200) {
    var results = "success";
    return results;
  } else {
    print("Failed");
  }
}

deleteUserShippingAddress(
    token, userID, shipmentID, shipping_default_status) async {
  //set api url
  final queryParameters = {
    'userID': userID.toString(),
    'shipmentID': shipmentID.toString(),
    'shipping_default_status': shipping_default_status.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url = "http://192.168.0.157:8000/api/shipment/deleteUserShippingAddress";

  Uri uri = Uri.parse(url);
  final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS

  print(finalUri);
  final response = await http.post(
    finalUri,
    headers: header,
  );

  var respStr = await response.body;
  var jsonResponse = jsonDecode(respStr);

  //get api result
  if (response.statusCode == 200) {
    var results = "success";
    return results;
  } else {
    print("Failed");
  }
}

getUserShipment(
  token,
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

  var url = "http://192.168.0.157:8000/api/shipment/getUserShipment";

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
    List<Shipment> shipmentList = List<Shipment>.from(
        jsonResponse.map((model) => Shipment.fromJson(model)));
    print(shipmentList);
    return shipmentList;
  } else {
    print("Failed");
  }
}
