import 'package:test_flutter/models/Address.dart';
import 'package:test_flutter/models/Company.dart';

class User {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final Address address;
  final String? phone;
  final String? website;
  final Company company;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    required this.address,
    this.phone,
    this.website,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      id: parsedJson['id'],
      name: parsedJson['name'],
      username: parsedJson['username'],
      email: parsedJson['email'],
      address: Address.fromJson(parsedJson['address']),
      phone: parsedJson['phone'],
      website: parsedJson['website'],
      company: Company.fromJson(parsedJson['company']),
    );
  }
}
