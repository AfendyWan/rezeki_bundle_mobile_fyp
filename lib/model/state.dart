class Negeri {
  int? id;
  String? statesName;
 

  Negeri({this.id, this.statesName, });

  factory Negeri.fromJson(Map<String, dynamic> json) {
    return Negeri(id: json['id'], statesName: json['states_name']);
  }
}
