class Errors {
  String? postcode;
  String? password;

  Errors(
      {this.postcode,
      this.password,
  });

factory Errors.fromJson(Map<String, dynamic> parsedJson) {
  
  return  Errors(
      postcode: parsedJson['postcode'],
      password: parsedJson['password'],
  );
}
}


