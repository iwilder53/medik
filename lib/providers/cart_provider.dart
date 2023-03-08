import 'package:flutter/material.dart';
import 'package:mediq/models/medicine_details.dart';

import '../models/cart.dart';

class Cart with ChangeNotifier {
  List<CartItem> items = [];
  double discount = 10.0;
  double subTotal = 0;
  double shipping = 0;
  double tax = 0;
  double itemCount = 0;
  double total = 0;

  removeItem(int index) {
    final item = items.removeAt(index);
    item.medicince.inCart = false;
    adjustPrices();
    notifyListeners();
  }

  notify() => notifyListeners();
  adjustPrices() {
    subTotal = 0;

    itemCount = 0;
    total = 0;
    items.forEach(
      (element) {
        subTotal += double.parse(element.price) * element.quantity;
        //    int.parse(element.quantity.split(' ')[0]);
        itemCount += element.quantity;
      },
    );
    items.isEmpty ? total = 0.00 : total = subTotal + shipping + tax - discount;

    notifyListeners();
  }

  increaseQuantity(int index) {
    final item = items.elementAt(index);

    item.quantity++;
    adjustPrices();
    notifyListeners();
  }

  decreaseQuantity(int index) {
    final item = items.elementAt(index);
    if (item.quantity == 1) {
      return;
    }
    item.quantity--;
    adjustPrices();
    notifyListeners();
  }

  increaseCount(int index) {
    int count = 1;
    final item = items.elementAt(index);
    if (item.medicince.selectedCount != null) {
      String tempCount = item.medicince.selectedCount!;
      count = int.parse(tempCount);
    }
    if (count == 1) {
      return;
    }
    count++;
    item.medicince.selectedCount = count.toString();
    notifyListeners();
  }

  decreaseCount(int index) {
    int count = 1;
    final item = items.elementAt(index);
    if (item.medicince.selectedCount != null) {
      String tempCount = item.medicince.selectedCount!;
      count = int.parse(tempCount);
    }
    if (count == 1) {
      return;
    }
    count--;
    item.medicince.selectedCount = count.toString();
    notifyListeners();
  }

  addItem(MedicineItemDetails product) {
    items.insert(
        0,
        CartItem(
            imageUrl: product.imageUrl!,
            id: product.itemId!,
            title: product.itemName!,
            quantity: 1,
            price: product.itemMrp!,
            medicince: product));
    adjustPrices();
    notifyListeners();
    items.forEach((element) {
      print(element.title);
    });
  }
}
