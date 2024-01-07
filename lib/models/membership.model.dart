class Membership {
  final String id;
  final String accountId;
  final String groupId;
  final String role;
  final int status;

  Membership(
      {required this.id,
      required this.accountId,
      required this.groupId,
      required this.role,
      required this.status});

  factory Membership.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'accountId': String accountId,
        'groupId': String groupId,
        'role': String role,
        'status': int status
      } =>
        Membership(
            id: id,
            accountId: accountId,
            groupId: groupId,
            role: role,
            status: status),
      _ => throw const FormatException('Failed to load Membership.')
    };
  }
}
