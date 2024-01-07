class Membership {
  final String id;
  final String accountId;
  final String groupId;
  final String status;

  Membership(
      {required this.id,
      required this.accountId,
      required this.groupId,
      required this.status});

  factory Membership.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'accountId': String accountId,
        'groupId': String groupId,
        'status': String status
      } =>
        Membership(
            id: id, accountId: accountId, groupId: groupId, status: status),
      _ => throw const FormatException('Failed to load Membership.')
    };
  }
}
