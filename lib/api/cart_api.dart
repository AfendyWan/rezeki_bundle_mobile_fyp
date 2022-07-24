import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/api/APIRoute.dart';
import 'package:rezeki_bundle_mobile/components/result_error.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/cart.dart';
import 'package:rezeki_bundle_mobile/model/cart_item.dart';
import 'package:rezeki_bundle_mobile/model/category_sale_item.dart';
import 'package:rezeki_bundle_mobile/model/sale_item.dart';
import 'package:rezeki_bundle_mobile/model/sale_item_image.dart';

getUserCart(token, userID) async {
  
  //set api url
  final queryParameters = {
    'userID': userID.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url =  apiRequest + api["APICart"]["apiGetUserCart"];

  Uri uri = Uri.parse(url);
  final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS

  print(finalUri);
  final response = await http.get(
    finalUri,
    headers: header,
  );

  var respStr = await response.body;

  //get api result
  if (response.statusCode == 200) {
    if(response.body.isNotEmpty){
      Cart? cartItem = Cart.fromJson(jsonDecode(respStr));
      return cartItem;
    }else{
      throw ErrorGettingData("User cart data is empty");
    }   
  } else {
    throw ErrorGettingData('Error getting user cart data');
  }
}

getUserCartItem(token, userID) async {
  //set api url
  final queryParameters = {
    'userID': userID.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url = hostURL + "/api/cart/getUserCartItem?";

  Uri uri = Uri.parse(url);
  final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS

  final response = await http.get(
    finalUri,
    headers: header,
  );

  var respStr = await response.body;
  var jsonResponse = jsonDecode(respStr);

  //get api result
  if (response.statusCode == 200) {
    List<CartItem> cartItem = List<CartItem>.from(
        jsonResponse.map((model) => CartItem.fromJson(model)));

    return cartItem;
  } else {
    print("Failed");
  }
}

deleteCartItem(token, cartID, saleItemID) async {
  //set api url
  final queryParameters = {
    'cartID': cartID.toString(),
    'saleItemID': saleItemID.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url = hostURL + "/api/cart/deletCartItem?";

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
    return jsonResponse;
  } else {
    print("Failed");
  }
}

addCartItem(token, userID, saleItemID, quantity) async {
  //set api url
  final queryParameters = {
    'userID': userID.toString(),
    'saleItemID': saleItemID.toString(),
    'quantity': quantity.toString(),
  };

  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url = hostURL +"/api/cart/addCartItem?";

  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers.addAll(headers);
  request.fields['userID'] = userID.toString();
  request.fields['saleItemID'] = saleItemID.toString();
  request.fields['quantity'] = quantity.toString();
  var response = await request.send();

  //get api result
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.persistentConnection.toString());
      final res = await http.Response.fromStream(response);

    return response;
  } else {
    print("Failed");
  }
}
