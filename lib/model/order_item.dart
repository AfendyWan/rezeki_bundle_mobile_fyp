import 'package:rezeki_bundle_mobile/model/sale_item.dart';

class OrderItem {
  int? id;
  int? quantity;
  String? orderPrice;
  int? order_id;

  String? itemName;
   String? imageUrl;
     int? sale_item_id;
  OrderItem({
    this.id,
    this.quantity,
    this.orderPrice,
    this.order_id,
    this.itemName,
    this.imageUrl,
    this.sale_item_id,
   
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
   
    return OrderItem(
        id: json['id'],
        quantity: json['quantity'],
        orderPrice: json['orderPrice'],
        order_id: json['order_id'],
        itemName: json['itemName'],
        imageUrl: json['url'],
        sale_item_id: json['sale_item_id'],
      );
  }
}
