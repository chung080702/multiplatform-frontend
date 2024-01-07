class User {
  String id;
  String telephone;
  String email;
  String role;
  String? imageId;

  User({
    required this.id,
    required this.telephone,
    required this.email,
    required this.role,
    this.imageId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        telephone: json['telephone'],
        email: json['email'],
        imageId: json["imageId"],
        role: json['role']);
  }
}
