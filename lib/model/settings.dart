class Setting {
  String? key;
  String? value;
 

  Setting({this.key, this.value, });

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(key: json['key'], value: json['value']);
  }
}
