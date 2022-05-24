import 'package:rezeki_bundle_mobile/model/feedback_image.dart';

class Feedbacks {
  int? id;
  String? feedbackTitle;
  String? feedbackDescription;
  int? sale_item_id;
  int? order_id;
  int? payment_id;
  int? userID;
  List<FeedbackImage>? feedbackImages;

  Feedbacks({
    this.id,
    this.feedbackTitle,
    this.feedbackDescription,
    this.sale_item_id,
    this.order_id,
    this.payment_id,
    this.userID,
    this.feedbackImages,
  });

  factory Feedbacks.fromJson(Map<String, dynamic> json) {
    var list = json['feedback_image'] as List;
  
    List<FeedbackImage> imagesList = list.map((i) => FeedbackImage.fromJson(i)).toList();
    return Feedbacks(
        id: json['id'],
        feedbackTitle: json['feedbackTitle'],
        feedbackDescription: json['feedbackDescription'],
        sale_item_id: json['sale_item_id'],
        order_id: json['order_id'],
        payment_id: json['payment_id'],
        userID: json['userID'],
        feedbackImages: imagesList);
  }
}
