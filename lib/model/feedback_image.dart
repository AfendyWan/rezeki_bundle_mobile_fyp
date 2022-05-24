class FeedbackImage {
  int? id;
  String? url;
  int? feedback_id;

  FeedbackImage({this.id, this.url, this.feedback_id,});

  factory FeedbackImage.fromJson(Map<String, dynamic> json) {
    return FeedbackImage(id: json['id'], url: json['url'], feedback_id: json['feedback_id']);
  }
}
