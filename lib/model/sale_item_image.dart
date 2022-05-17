class SaleItemImage {
  int? id;
  String? url;
  int? sale_item_id;
  int? sale_item_category_id;

 

  SaleItemImage({this.id, this.url, this.sale_item_id, this.sale_item_category_id, });

  factory SaleItemImage.fromJson(Map<String, dynamic> json) {
    return SaleItemImage(id: json['id'], url: json['url'], sale_item_id: json['sale_item_id'], sale_item_category_id: json['sale_item_category_id']);
  }
}
