class Request {
  String id;
  String phone;
  String email;
  String title;
  String description;
  String image;
  String createdAt;
  String status;

  Request({
    required this.id,
    required this.phone,
    required this.email,
    required this.title,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.status,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    String tmpImage = '';
    List<dynamic> images = json['imageIds'];
    if (images.isNotEmpty) {
      tmpImage = json['imageIds'][0];
    }
    return Request(id: json['_id'], phone: json['accountId']['telephone'], email: json['accountId']['email'], title: json['title'], description: json['description'], image: tmpImage, createdAt: json['createAt'], status: json['status']);
  }
}