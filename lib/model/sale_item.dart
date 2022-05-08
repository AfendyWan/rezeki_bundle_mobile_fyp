class SaleItem {
  int? id;
  String? itemName;
  int? itemCategory;
  int? itemStock;
  String? itemPrice;

  SaleItem({this.id, this.itemName, this.itemCategory, this.itemStock, this.itemPrice});

  factory SaleItem.fromJson(Map<String, dynamic> json) {
    return SaleItem(id: json['id'], itemName: json['itemName'], itemCategory: json['itemCategory'], itemStock: json['itemStock'], itemPrice: json['itemPrice']);
  }
}
