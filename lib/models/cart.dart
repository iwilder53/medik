import 'package:flutter/material.dart';
import 'package:mediq/models/medicine_details.dart';

class CartItem {
  final String id;
  final String title;
  int quantity;
  final String price;
  final String imageUrl;
  final MedicineItemDetails medicince;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price,
      required this.imageUrl,
      required this.medicince});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "quantity": quantity,
      "imageUrl": imageUrl,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        id: json['id'],
        title: json['title'],
        imageUrl: json['imageUrl'],
        quantity: json['quantity'],
        price: json['price'],
        medicince: json['']);
  }
}
