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
