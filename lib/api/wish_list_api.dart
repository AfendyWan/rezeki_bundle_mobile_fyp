import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/model/category_sale_item.dart';
import 'package:rezeki_bundle_mobile/model/sale_item.dart';
import 'package:rezeki_bundle_mobile/model/sale_item_image.dart';

getIsWishList(token, userID, saleItemID) async {
  //set api url
  final queryParameters = {
    'userID': userID.toString(),
    'saleItemID': saleItemID.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url = "http://192.168.0.157:8000/api/wishList/isWishList?";
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
      return jsonResponse;
  } else {
    print("Failed");
  }
}
