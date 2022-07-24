import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/constants.dart';
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

  var url = hostURL + "/api/wishList/isWishList?";
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

toggleWishList(token, userID, saleItemID, wishListStatus) async {
  //set api url
  final queryParameters = {
    'userID': userID.toString(),
    'saleItemID': saleItemID.toString(),
    'liked': wishListStatus.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url = hostURL + "/api/wishList/toggleWishList?";
  Uri uri = Uri.parse(url);
  final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS

  final response = await http.get(
    finalUri,
    headers: header,
  );

  print(finalUri);
  var respStr = await response.body;
  var jsonResponse = jsonDecode(respStr);

  //get api result
  if (response.statusCode == 200) {
    return jsonResponse;
  } else {
    print("Failed");
  }
}

getUserWishList(id) async {
  //set api url
  var url =
      hostURL + "/api/wishList/getUserWishList/" + id.toString();

  //initiate api
  var response = await http.get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
  });

  //get api result
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    List<SaleItem> saleItem = List<SaleItem>.from(
        jsonResponse.map((model) => SaleItem.fromJson(model)));

    return saleItem;
  } else {
    print("Failed");
  }
}
