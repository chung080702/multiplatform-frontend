class Membership {
  final String id;
  final String accountId;
  final String groupId;
  final String status;
  final String role;

  Membership(
      {required this.id,
      required this.accountId,
      required this.groupId,
      required this.status,
      required this.role});

  factory Membership.fromJson(Map<String, dynamic> json) {
    String role = 'None';
    if (json['role'] != null) {
      role = json['role'];
    }
    return Membership(
        id: json['_id'],
        accountId: json['accountId'],
        groupId: json['groupId'],
        status: json['status'],
        role: role);
  }
}
