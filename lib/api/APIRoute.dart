import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
String apiRequest = "http://192.168.0.157:8000";

Map api = {
  "APISaleItem": {
    "apiShowAllSaleItem": "/api/saleItem/showAllSaleItem/",
  },
  "APICart": {
    "apiGetUserCart": "/api/cart/getUserCart?",
  },
 "APIOrder": {
    "apiGetUserOrderTransaction": "/api/transaction/getUserOrderTransaction",
  },
};

  getAPIResponse({  
    required String token,
    Map<String, String>? queryParameters,
  }) async {
    Map<String, String> header = {
      HttpHeaders.authorizationHeader: "Token $token",
      HttpHeaders.contentTypeHeader: "application/json"
    };
    //set api url
    var url = apiRequest + api["APIOrder"]["apiGetUserOrderTransaction"];

    Uri uri = Uri.parse(url);
    final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS

    final response = await http.get(
      finalUri,
      headers: header,
    );
   
    return response;
  }