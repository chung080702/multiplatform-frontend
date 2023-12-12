class User {
  String id;
  String telephone;
  String email;
  String role;

  User(
      {required this.id,
      required this.telephone,
      required this.email,
      required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['_id'], telephone: json['telephone'], email: json['email'], role: json['role']);
  }

}
