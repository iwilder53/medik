
import 'package:mediq/models/cart.dart';

import 'medicine_details.dart';

class OrderDetails {
  String? orderId;
  int? timeStamp;
  int? statusCode;
  int? itemsCount;
  String? totalAmount;
  int? fulfillCode;
  String? updatedAt;
  String? userId;
  List<CartItem>? items;

  bool prescriptionRequired;

  OrderDetails(
      {this.orderId,
      this.timeStamp,
      this.statusCode,
      this.itemsCount,
      this.totalAmount,
      this.items,
      this.userId,
      this.fulfillCode = 0,
      this.updatedAt,
      this.prescriptionRequired = false});

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "timeStamp": timeStamp,
      "statusCode": statusCode,
      "itemsCount": itemsCount,
      "amount": totalAmount,
      "userId": userId,
      "fulfillCode": fulfillCode,
      'items': items?.map((e) => e.toJson()).toList(),
      "updatedAt": updatedAt,
      'prescriptionRequired': false
    };
  }

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
        orderId: json['orderId'],
        userId: json['userId'],
        timeStamp: json['timeStamp'],
        statusCode: json['statusCode'],
        itemsCount: json['itemsCount'],
        totalAmount: json['amount'],
        items: List<CartItem>.from(
            json['items'].map((model) => CartItem.fromJson(model))),
        fulfillCode: json['fulfillCode'],
        updatedAt: json['updatedAt'],
        prescriptionRequired: json['prescriptionRequired']);
  }
}
