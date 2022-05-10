class City {
  int? id;
  String? citiesName;
  int? statesId;

  City({this.id, this.citiesName, this.statesId,});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(id: json['id'], citiesName: json['cities_name'], statesId: json['states_id']);
  }
}
