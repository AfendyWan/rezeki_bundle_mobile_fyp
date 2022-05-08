class User {
  int? id;
  String? first_name;
  String? last_name;
  String? email;
  int? role;
  String? gender;
  String? phone_number;
  int? postcode;
  String? password;

  User({this.id, this.first_name, this.last_name, this.email, this.role, this.gender, this.phone_number, this.postcode, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], first_name: json['first_name'], email: json['email'], role: json['role'], gender: json['gender'], phone_number: json['phone_number'], postcode: json['postcode'],  password: json['password'], );
  }
}
