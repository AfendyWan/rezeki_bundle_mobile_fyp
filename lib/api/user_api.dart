import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

changeProfilePhoto(context, userID, profileImage) async {
  var url = "http://192.168.0.157:8000/api/auth/changeProfilePhoto?";
   print("tess111t");
    print(profileImage);
  print(url);
   print(userID);
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };
 
  var request = http.MultipartRequest('POST', Uri.parse(url))..files.add(await http.MultipartFile.fromPath('profileImage', profileImage.path));
  request.headers.addAll(headers);

  request.fields['userID'] = userID.toString();

  var response = await request.send();
final respStr = await response.stream.bytesToString();
  if (response.statusCode == 200) {
    print("success get " + respStr.toString());
    print(respStr);
  } else {
    print("fail");
  }
}
