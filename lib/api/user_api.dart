import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

changeProfilePhoto(context, userID, profileImage) async {
  var url = "http://192.168.0.157:8000/api/auth/changeProfilePhoto?";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  var request = http.MultipartRequest('POST', Uri.parse(url))
    ..files.add(
        await http.MultipartFile.fromPath('profileImage', profileImage.path));
  request.headers.addAll(headers);

  request.fields['userID'] = userID.toString();

  var response = await request.send();
  final respStr = await response.stream.bytesToString();
  if (response.statusCode == 200) {
  } else {}
}

getProfilePhoto(token, context, userID,) async {
  //set api url
  final queryParameters = {
    'userID': userID.toString(),
  };

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url = "http://192.168.0.157:8000/api/auth/getProfilePhoto?";
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
    print(jsonResponse);
    return jsonResponse;
  } else {
    print("Failedsss");
  }
}
