
import 'package:rezeki_bundle_mobile/model/payment.dart';

class Order {
  int? id;
  String? orderDate;
  String? order_number;
  int? userID;
  int? paymentID;
  int? shipmentID;
  String? orderStatus;
  List<Payment>? payment;

  Order({
    this.id,
    this.orderDate,
    this.order_number,
    this.userID,
    this.paymentID,
    this.shipmentID,
    this.orderStatus,
    this.payment,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var list = json['payment'] as List;
  
    List<Payment> paymentList = list.map((i) => Payment.fromJson(i)).toList();
    return Order(
        id: json['id'],
        orderDate: json['orderDate'],
        order_number: json['order_number'],
        userID: json['userID'],
        paymentID: json['paymentID'],
        shipmentID: json['shipmentID'],
        orderStatus: json['orderStatus'],
        payment: paymentList);
  }
}
