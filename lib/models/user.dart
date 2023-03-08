import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String name = '';
  int number;
  List<Address> addresses = [];

  UserModel({
    required this.name,
    required this.addresses,
    required this.number,
  });
}

class Address with ChangeNotifier {
  String fullName;
  String line1;
  String line2;
  String city;
  String state;
  String title;
  int pincode;
  Address(
      {required this.fullName,
      required this.city,
      required this.line1,
      required this.line2,
      required this.title,
      required this.pincode,
      required this.state});
}
