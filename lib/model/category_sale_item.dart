class CategorySaleItem {
  int? id;
  String? name;
  String? description;
  int? quantity;
  String? url;

  CategorySaleItem({
    this.id,
    this.name,
    this.description,
    this.quantity,
    this.url,
  });

  factory CategorySaleItem.fromJson(Map<String, dynamic> json) {
  
    return CategorySaleItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      url: json['url'],
    );
  }
}
