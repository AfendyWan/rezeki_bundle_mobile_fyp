import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/model/category_sale_item.dart';

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
