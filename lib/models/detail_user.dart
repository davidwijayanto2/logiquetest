class DetailUser {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;
  String? gender;
  String? email;
  String? dateOfBirth;
  String? phone;
  Map<String, dynamic>? location;
  String? registerDate;
  String? updatedDate;

  DetailUser.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        title = map["title"],
        firstName = map["firstName"],
        lastName = map["lastName"],
        picture = map["picture"],
        gender = map["gender"],
        email = map["email"],
        dateOfBirth = map["dateOfBirth"],
        phone = map["phone"],
        location = map["location"],
        registerDate = map["registerDate"],
        updatedDate = map["updatedDate"];
}
