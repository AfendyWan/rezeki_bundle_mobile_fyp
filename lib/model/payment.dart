class Payment {
  int? id;
  String? totalPrice;
  String? subTotalPrice;
  String? shippingPrice;
  String? paymentStatus;
  String? remark;
  int? cart_id;
  int? order_id;
  int? userID;
  String? paymentDate;
  
  Payment({
    this.id, this.totalPrice, this.subTotalPrice,
    this.shippingPrice, this.paymentStatus, this.remark,
    this.cart_id, this.order_id, this.userID, this.paymentDate,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'], totalPrice: json['totalPrice'], subTotalPrice: json['subTotalPrice'],
      shippingPrice: json['shippingPrice'], paymentStatus: json['paymentStatus'], remark: json['remark'],
      cart_id: json['cart_id'], order_id: json['order_id'], userID: json['userID'], paymentDate: json['paymentDate'],
    );
  }
}
