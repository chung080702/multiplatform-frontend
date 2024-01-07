import 'package:multiplatform_app/models/event.model.dart';
import 'package:multiplatform_app/models/membership.model.dart';

class Group {
  final String id;
  final String name;
  final String description;
  final String imageId;
  final int memberNumber;
  final List<Membership> membership;
  List<Event> events = [];

  Group(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageId,
      required this.memberNumber,
      required this.membership});

  factory Group.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'name': String name,
        'description': String description,
        'imageId': String imageId,
        'memberNumber': int memberNumber,
        'membership': List<Membership> membership
      } =>
        Group(
            id: id,
            name: name,
            description: description,
            imageId: imageId,
            memberNumber: memberNumber,
            membership: membership),
      _ => throw const FormatException('Failed to load Group.')
    };
  }
}
