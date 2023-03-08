import 'package:flutter/material.dart';

class MedicineItemDetails with ChangeNotifier {
  String? itemId;
  String? itemName;
  String? itemMrp;
  String? quantity; //eg 10ml , 10 tabs, bottle of 1 injection etc..
  String? cover;
  String? imageUrl;
  String? itemSalts;
  String? itemDescription;
  bool inCart = false;
  List<String>? categories;
  late String? selectedCategory = categories![0];
  List<String>? count;
  late String? selectedCount = count![0] ;

  MedicineItemDetails(
      {this.quantity,
      this.itemId,
      this.itemName,
      this.imageUrl,
      this.itemDescription,
      this.itemMrp,
      this.itemSalts,
      this.cover,
      this.categories,
      this.count});

  void addToCart() {
    inCart = true;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      "itemId": itemId,
      "itemName": itemName,
      "itemMrp": itemName,
      "quantity": quantity,
      "imageUrl": imageUrl,
      "cover": cover,
      "itemSalts": itemSalts,
      "itemDescription": itemDescription
    };
  }

  factory MedicineItemDetails.fromJson(Map<String, dynamic> json) {
    return MedicineItemDetails(
      itemId: json['itemId'],
      itemName: json['itemName'],
      imageUrl: json['imageUrl'],
      itemDescription: json['itemDescription'],
      itemMrp: json['itemSalts'],
      cover: json['cover'],
      itemSalts: json['itemSalts'],
      quantity: json['quantity'],
    );
  }
}
