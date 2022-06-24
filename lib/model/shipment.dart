class Shipment {
  int? id;
  String? shippingAddress;
  String? shippingOption;
  String? shippingLocalDateTime;
  String? shippingStatus;
  String? shippingCourier;
  String? shippingTrackingNumber;
  int? cart_id;
  int? payment_id;
  int? userID;
  int? orderID;
  Shipment({this.id, this.shippingAddress, this.shippingOption, this.shippingLocalDateTime, this.shippingStatus, this.shippingCourier, this.shippingTrackingNumber, this.cart_id, this.payment_id, this.userID, this.orderID,});

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      id: json['id'], 
      shippingAddress: json['shippingAddress'],
      shippingOption: json['shippingOption'], 
      shippingLocalDateTime: json['shippingLocalDateTime'],
      shippingStatus: json['shippingStatus'], 
      shippingCourier: json['shippingCourier'],
      shippingTrackingNumber: json['shippingTrackingNumber'], 
      cart_id: json['cart_id'],
      payment_id: json['payment_id'], 
      userID: json['userID'],
      orderID: json['orderID'],

    );
  }
}
