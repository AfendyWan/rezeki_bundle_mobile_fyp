

import 'package:rezeki_bundle_mobile/model/cart_item.dart';

class Cart {
  int? id;
  int? userID;
  String? totalPrice;
  int? cartItemQuantity;
  int? cartStatus;


  Cart({
    this.id,
    this.userID,
    this.totalPrice,
    this.cartItemQuantity,
    this.cartStatus,

  });

  factory Cart.fromJson(Map<String, dynamic> json) {

   
 
    return Cart(
        id: json['id'],
        userID: json['userID'],
        totalPrice: json['totalPrice'],
        cartItemQuantity: json['cartItemQuantity'],
        cartStatus: json['cartStatus'],
     );
  }
}
