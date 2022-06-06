import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/model/category_sale_item.dart';
import 'package:rezeki_bundle_mobile/model/sale_item.dart';
import 'package:rezeki_bundle_mobile/model/sale_item_image.dart';

getSaleItemImages(id) async {
  //set api url
  var url = "http://192.168.0.157:8000/api/saleItem/showSaleItemImages/" +
      id.toString();
  print(url);

  //initiate api
  var response = await http.get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
  });

  //get api result
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    List<SaleItemImage> saleItemImages = List<SaleItemImage>.from(
        jsonResponse.map((model) => SaleItemImage.fromJson(model)));

    return saleItemImages;
  } else {
    print("Failed");
  }
}

getSaleItemList(id) async {
  //set api url
  var url = "http://192.168.0.157:8000/api/saleItem/showSaleItemList/" +
      id.toString();

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

getSaleItemCategory() async {
  //set api url
  var url = "http://192.168.0.157:8000/api/saleItem/showAllSsaleItemCategory";

  //initiate api
  var response = await http.get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
  });

  //get api result
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    List<CategorySaleItem> saleItemCategory = List<CategorySaleItem>.from(
        jsonResponse.map((model) => CategorySaleItem.fromJson(model)));
    return saleItemCategory;
  } else {
    print("Failed");
  }
}

getFirstThreeSaleItemCategory() async {
  //set api url
  var url =
      "http://192.168.0.157:8000/api/saleItem/showFirstThreeSaleItemCategory";

  //initiate api
  var response = await http.get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
  });

  //get api result
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    List<CategorySaleItem> saleItemCategory = List<CategorySaleItem>.from(
        jsonResponse.map((model) => CategorySaleItem.fromJson(model)));
    return saleItemCategory;
  } else {
    print("Failed");
  }
}

getPromotionSaleItemList() async {
  //set api url
  var url = "http://192.168.0.157:8000/api/saleItem/showSaleItemPromotionList/";

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

searchSaleItem(token, saleItemName) async {
  //set api url
  final queryParameters = {
    'saleItemName': saleItemName.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url = "http://192.168.0.157:8000/api/saleItem/searchSaleItem?";

  Uri uri = Uri.parse(url);
  final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS

  final response = await http.post(
    finalUri,
    headers: header,
  );

  var respStr = response.body;
  var jsonResponse = jsonDecode(respStr);

  //get api result
  if (response.statusCode == 200) {
    List<SaleItem> saleItem = List<SaleItem>.from(
        jsonResponse.map((model) => SaleItem.fromJson(model)));

    return saleItem;
  } else {
    print("Failed");
  }
}