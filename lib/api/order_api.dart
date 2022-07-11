import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/model/cart.dart';
import 'package:rezeki_bundle_mobile/model/cart_item.dart';
import 'package:rezeki_bundle_mobile/model/feedback.dart';
import 'package:rezeki_bundle_mobile/model/order.dart';
import 'package:rezeki_bundle_mobile/model/order_item.dart';

getUserOrderTransaction(token, userID) async {
  final queryParameters = {
    'userID': userID.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };
  //set api url
  var url = "http://192.168.0.157:8000/api/transaction/getUserOrderTransaction";

  Uri uri = Uri.parse(url);
  final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS

  print(finalUri);
  final response = await http.get(
    finalUri,
    headers: header,
  );

  //get api result
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    List<Order> orders =
        List<Order>.from(jsonResponse.map((model) => Order.fromJson(model)));

    return orders;
  } else {
    print("Failed");
  }
}

viewUserOrderItems(token, orderID) async {
  final queryParameters = {
    'orderID': orderID.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };
  //set api url
  var url = "http://192.168.0.157:8000/api/transaction/viewUserOrderItems";

  Uri uri = Uri.parse(url);
  final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS
  print("Getting user item");
  print(finalUri);
  final response = await http.get(
    finalUri,
    headers: header,
  );

  //get api result
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    List<OrderItem> ordersItem = List<OrderItem>.from(
        jsonResponse.map((model) => OrderItem.fromJson(model)));

    return ordersItem;
  } else {
    print("Failed");
  }
}
