import 'package:flutter/material.dart';
import 'package:mediq/models/order_details.dart';

import 'cart_provider.dart';

class OrderDetailsProvider with ChangeNotifier {
  List<OrderDetails> orders = [];
  late OrderDetails currentOrder;

  generateOrder(Cart cart) {
    orders.insert(
        0,
        OrderDetails(
          orderId: DateTime.now().microsecond.toString(),
          timeStamp: DateTime.now().millisecondsSinceEpoch,
          statusCode: 0,
          itemsCount: cart.items.length,
          totalAmount: cart.total.toStringAsFixed(2),
          userId: 'user',
          items: cart.items,
        ));
    notifyListeners();
  }
}
