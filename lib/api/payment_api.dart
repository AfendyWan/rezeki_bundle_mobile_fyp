import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// submitPayment(token, userID, paymentReceipt, totalPrice, subTotalPrice, shippingPrice, deliveryOptionName, couriers, date, time ) async {
//   String deliveryDateTime = date + time;
//   //set api url
//   final queryParameters = {
//    'userID': userID.toString(),
//    'totalPrice': totalPrice.toString(),
//    'subTotalPrice': subTotalPrice.toString(),
//    'shippingPrice': shippingPrice.toString(),
//    'deliveryOptionName': deliveryOptionName.toString(),
//    'couriers': couriers.toString(),
//    'deliveryDateTime': deliveryDateTime.toString(),
//     'paymentReceipt': paymentReceipt.path
//   };

//   Map<String, String> header = {
//     HttpHeaders.authorizationHeader: "Token $token",
//     HttpHeaders.contentTypeHeader: "application/json"
//   };

//   var url = "http://192.168.0.157:8000/api/payment/submitPayment";

//   Uri uri = Uri.parse(url);
//   final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS

//   print(finalUri);
//   final response = await http.get(
//     finalUri,
//     headers: header,
//   );

//   var respStr = await response.body;
//   var jsonResponse = jsonDecode(respStr);

//   //get api result
//   if (response.statusCode == 200) {
//     var results = "success";
//     return results;
//   } else {
//     print("Failed");
//   }
// }
submitPayment(token, userID, paymentReceipt, totalPrice, subTotalPrice,
    shippingPrice, deliveryOptionName, couriers, date, time) async {
  String deliveryDateTime = date + " " + time;
  //set api url

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url = "http://192.168.0.157:8000/api/payment/submitPayment";

  var request = http.MultipartRequest('POST', Uri.parse(url))
    ..files.add(
        await http.MultipartFile.fromPath('paymentReceipt', paymentReceipt.path));
  request.headers.addAll(header);

  request.fields['userID'] = userID.toString();
  request.fields['totalPrice'] = totalPrice.toString();
  request.fields['subTotalPrice'] = subTotalPrice.toString();
  request.fields['shippingPrice'] = shippingPrice.toString();
  request.fields['deliveryOptionName'] = deliveryOptionName.toString();
  request.fields['couriers'] = couriers.toString();
  request.fields['deliveryDateTime'] = deliveryDateTime.toString();

  var response = await request.send();
  print(request);
  final respStr = await response.stream.bytesToString();
  print(respStr);
  //get api result
  if (response.statusCode == 200) {
    print("object send");
    var results = "success";
    return results;
  } else {
    print("Failed");
  }
}
