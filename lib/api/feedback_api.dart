import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/cart.dart';
import 'package:rezeki_bundle_mobile/model/cart_item.dart';
import 'package:rezeki_bundle_mobile/model/feedback.dart';
import 'package:rezeki_bundle_mobile/model/feedback_image.dart';

getAllUserFeedback(token) async {
  //set api url
  var url = hostURL + "/api/feedback/getUsersFeedback";

  //initiate api
  var response = await http.get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
  });

  //get api result
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    List<Feedbacks> feedback = List<Feedbacks>.from(
        jsonResponse.map((model) => Feedbacks.fromJson(model)));

    return feedback;
  } else {
    print("Failed");
  }
}

getUserFeedbackImages(token) async {
  //set api url
  final queryParameters = {};
  print("object");
  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };
  print("object1");
  var url = hostURL + "/api/feedback/getFeedbackImages";

  var request = http.MultipartRequest('GET', Uri.parse(url));
  request.headers.addAll(headers);

  var response = await request.send();

  if (response.statusCode == 200) {

    final res = await http.Response.fromStream(response);
    var jsonResponse = jsonDecode(res.body);
 
    // var jsonResponse = res.body;
    List<FeedbackImage> feedbackImages = List<FeedbackImage>.from(
        jsonResponse.map((model) => FeedbackImage.fromJson(model)));
    // print(feedbackImages);
    return feedbackImages;
  } else {
    print("Failed");
  }
}

addFeedback(token, order_id, feedbackTitle, feedbackDescription, userId,
    sale_item_id,images,) async {
 
  
  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Token $token",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  var url = hostURL + "/api/feedback/addFeedback";

  // var request = http.MultipartRequest('POST', Uri.parse(url))
  //   ..files.add(
  //       await http.MultipartFile.fromPath('images', images.path));
  var request = http.MultipartRequest('POST', Uri.parse(url));

  request.headers.addAll(header);

  request.fields['order_id'] = order_id.toString();
  request.fields['feedbackTitle'] = feedbackTitle.toString();
  request.fields['feedbackDescription'] = feedbackDescription.toString();
  request.fields['userId'] = userId.toString();
  request.fields['sale_item_id'] = sale_item_id.toString();

  if (images != null) {
    List<http.MultipartFile> newList = [];

    for (int i = 0; i < images.length; i++) {
      var multipartFile = await http.MultipartFile.fromPath(
          'images[]', images[i].path);

      newList.add(multipartFile);
    }
 
    request.files.addAll(newList);
  }

  var response = await request.send();
 

  //get api result
  if (response.statusCode == 200) {

    var results = "success";
     print(results);
    return results;
  } else {
    print("Failed to add feedback");
  }
}