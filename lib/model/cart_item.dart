class CartItem {
  int? id;
  int? quantity;
  int? cart_id;
  int? sale_item_id;
  String? itemName;
  int? itemCategory;
  int? itemStock;
  String? itemPrice;
  String? itemPromotionPrice;
  int? itemPromotionStatus;
  int? itemActivationStatus;
  String? image_url;
  String? itemTotalPrice;
  CartItem(
      {this.id,
      this.quantity,
      this.cart_id,
      this.sale_item_id,
      this.itemName,
      this.itemCategory,
      this.itemStock,
      this.itemPrice,
      this.itemPromotionPrice,
      this.itemPromotionStatus,
      this.itemActivationStatus,
      this.image_url,
      this.itemTotalPrice});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    double totalPrice = 0;
    String inString;
    if (json['itemPromotionStatus'] == 1) {
      var tempItemPrice = double.parse(json['itemPromotionPrice']);
      totalPrice = tempItemPrice * json['quantity'];
       inString = totalPrice.toStringAsFixed(2); //
    } else {
      var tempItemPrice = double.parse(json['itemPrice']);
      totalPrice = tempItemPrice * json['quantity'];
      inString = totalPrice.toStringAsFixed(2); //
    }

    return CartItem(
        id: json['id'],
        quantity: json['quantity'],
        cart_id: json['cart_id'],
        sale_item_id: json['sale_item_id'],
        itemName: json['itemName'],
        itemCategory: json['itemCategory'],
        itemStock: json['itemStock'],
        itemPrice: json['itemPrice'],
        itemPromotionPrice: json['itemPromotionPrice'],
        itemPromotionStatus: json['itemPromotionStatus'],
        itemActivationStatus: json['itemActivationStatus'],
        image_url: json['url'],
        itemTotalPrice: inString.toString());
  }
}
