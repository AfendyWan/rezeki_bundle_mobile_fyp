class SaleItem {
 int? id;
  String? itemName;

  int? itemCategory;
  int? itemStock;
  String? itemColor;
  String? itemSize;
  String? itemBrand;
  double? itemPrice;
  
  int? itemPromotionStatus;
  double? itemPromotionPrice;
  String? itemPromotionStartDate;
  String? itemPromotionEndDate;
  int? itemActivationStatus;

  String? url;

  SaleItem({this.id, this.itemName, this.itemCategory, this.itemStock, this.itemColor, this.itemSize, 
  this.itemBrand, this.itemPrice, this.itemPromotionStatus, this.itemPromotionPrice, this.itemPromotionStartDate,
  this.itemPromotionEndDate, this.itemActivationStatus, this.url});

 factory SaleItem.fromJson(Map<String, dynamic> json) {
  
    return SaleItem(
      id: json['sale_item_category_id'],
      itemName: json['itemName'],
      itemCategory: json['itemCategory'],
      itemStock: json['itemStock'],
      url: json['url'],
    );
  }
  // factory SaleItem.fromJson(Map<String, dynamic> json) {
  //   return SaleItem(id: json['id'], itemName: json['itemName'], itemCategory: json['itemCategory'], itemStock: json['itemStock'], itemColor: json['itemColor'],
  //   itemSize: json['itemSize'], itemBrand: json['itemBrand'], itemPrice: json['itemPrice'], itemPromotionStatus: json['itemPromotionStatus'], 
  //   itemPromotionPrice: json['itemPromotionPrice'], itemPromotionStartDate: json['itemPromotionStartDate'], itemPromotionEndDate: json['itemPromotionEndDate'],
  //   itemActivationStatus: json['itemActivationStatus'], url: json['url'], 
    
  //   );
  // }
}
