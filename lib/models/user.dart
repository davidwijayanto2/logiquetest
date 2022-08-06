class User {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;

  User.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        title = map["title"],
        firstName = map["firstName"],
        lastName = map["lastName"],
        picture = map["picture"];
}
