class UserShippingAddress {
  int? id;
  String? shipping_address;
  String? state;
  String? city;
  int? postcode;
  int? shipping_default_status;
  int? userID;

  UserShippingAddress({
    this.id,
    this.shipping_address,
    this.state,
    this.city,
    this.postcode,
    this.shipping_default_status,
    this.userID,
  });

  factory UserShippingAddress.fromJson(Map<String, dynamic> json) {
    return UserShippingAddress(
      id: json['id'],
      shipping_address: json['shipping_address'],
      state: json['state'],
      city: json['city'],
      postcode: json['postcode'],
      shipping_default_status: json['shipping_default_status'],
      userID: json['userID'],
    );
  }
}
