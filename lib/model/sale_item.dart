class SaleItem {
  int? id;
  int? itemID;
  String? itemName;
  String? itemDescription;

  int? itemCategory;
  int? itemStock;
  String? itemColor;
  String? itemSize;
  String? itemBrand;
  String? itemPrice;
  
  int? itemPromotionStatus;
  String? itemPromotionPrice;
  String? itemPromotionStartDate;
  String? itemPromotionEndDate;
  int? itemActivationStatus;

  String? url;

  SaleItem({this.id, this.itemID, this.itemName, this.itemDescription, this.itemCategory, this.itemStock, this.itemColor, this.itemSize, 
  this.itemBrand, this.itemPrice, this.itemPromotionStatus, this.itemPromotionPrice, this.itemPromotionStartDate,
  this.itemPromotionEndDate, this.itemActivationStatus, this.url});

 factory SaleItem.fromJson(Map<String, dynamic> json) {
  
    return SaleItem(
      id: json['id'],
      itemID: json['itemID'],
      itemName: json['itemName'],
      itemDescription: json['itemDescription'],
      itemCategory: json['itemCategory'],
      itemStock: json['itemStock'],
      itemColor: json['itemColor'],
      itemSize: json['itemSize'],
      itemBrand: json['itemBrand'],
      itemPrice: json['itemPrice'], 
      itemPromotionStatus: json['itemPromotionStatus'],
      itemPromotionPrice: json['itemPromotionPrice'], 
      itemPromotionStartDate: json['itemPromotionStartDate'], 
      itemPromotionEndDate: json['itemPromotionEndDate'],
      itemActivationStatus: json['itemActivationStatus'],
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
