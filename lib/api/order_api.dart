import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/api/APIRoute.dart';
import 'package:rezeki_bundle_mobile/components/result_error.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/order.dart';
import 'package:rezeki_bundle_mobile/model/order_item.dart';

class OrderService {


Future<List<Order>> getUserOrderTransaction(token, userID) async {    
    final queryParameters = {
      'userID': userID.toString(),
    };
    var response = await getAPIResponse(queryParameters: queryParameters, token: token,); 
    if (response.statusCode == 200) {
      if(response.body.isNotEmpty){
        return List<Order>.from(json.decode(response.body).map(
                (data) => Order.fromJson(data),
              ),
            );    
      }else{
        throw ErrorGettingData("User order data is empty");
      }   
    } else {
      throw ErrorGettingData('Error getting user order data');
    }
  }
}
// getUserOrderTransaction(token, userID) async {
//   Stopwatch stopwatch = new Stopwatch()..start();
//   final queryParameters = {
//     'userID': userID.toString(),
//   };

//   Map<String, String> header = {
//     HttpHeaders.authorizationHeader: "Token $token",
//     HttpHeaders.contentTypeHeader: "application/json"
//   };
//   //set api url
//   var url = hostURL + "/api/transaction/getUserOrderTransaction";

//   Uri uri = Uri.parse(url);
//   final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS

//   print(finalUri);
//   final response = await http.get(
//     finalUri,
//     headers: header,
//   );

//   //get api result
//   if (response.statusCode == 200) {
//         if(response.body.isNotEmpty){
//       var jsonResponse = jsonDecode(response.body);
//       List<Order> orders = List<Order>.from(jsonResponse.map((model) => Order.fromJson(model)));
//       print('getUserOrderTransaction() executed in ${stopwatch.elapsed}');
//       return orders;      
//     }else{
//       print("empty");
//     }      
//   } else {
//     print("Failed");
//   }
// }

getUserOrderTransaction(token, userID) async {
 
  final queryParameters = {
    'userID': userID.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };
  //set api url
  var url = hostURL + api["APIOrder"]["apiGetUserOrderTransaction"];

  Uri uri = Uri.parse(url);
  final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS

  final response = await http.get(
    finalUri,
    headers: header,
  );

  if (response.statusCode == 200) {
    if(response.body.isNotEmpty){
      var jsonResponse = jsonDecode(response.body);
      List<Order> orders = List<Order>.from(jsonResponse.map((model) => Order.fromJson(model)));
      
      return orders;      
    }else{
      throw ErrorGettingData("User order data is empty");
    }   
  } else {
    throw ErrorGettingData('Error getting user order data');
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
  var url = hostURL + "/api/transaction/viewUserOrderItems";

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
   
    List<OrderItem> ordersItem = List<OrderItem>.from(
        jsonResponse.map((model) => OrderItem.fromJson(model)));

    return ordersItem;
  } else {
    print("Failed");
  }
}
