import 'package:flutter/material.dart';

import '../models/medicine_details.dart';

class ProductsProvider with ChangeNotifier {
  final List<MedicineItemDetails> _popularProducts = [
    MedicineItemDetails(
        itemId: '3',
        itemName: 'Wysolone 10mg',
        itemMrp: '40.99',
        quantity: '10 tabs',
        cover: 'tabs',
        categories: ['Strip', 'Bottle'],
        imageUrl: 'assets/images/tab.png',
        count: ['5', '10']),
    MedicineItemDetails(
      itemId: '2',
      itemName: 'Bodrex Herbal',
      itemMrp: '80.99',
      quantity: '100 ml',
      categories: ['Bottle'],
      cover: 'Bottle',
      imageUrl: 'assets/images/bottle.png',
    ),
    MedicineItemDetails(
        itemId: '1',
        itemName: 'Konidin',
        itemMrp: '50.99',
        quantity: '3 pcs',
        imageUrl: 'assets/images/pcs.png',
        categories: ['Strip', 'Bottle']),
  ];
  final List<MedicineItemDetails> _productsOnSale = [
    MedicineItemDetails(
        itemId: '4',
        itemName: 'Wysolone 10mg',
        itemMrp: '40.99',
        quantity: '10 tabs',
        cover: 'tabs',
        categories: ['Strip', 'Bottle'],
        imageUrl: 'assets/images/tab.png',
        count: ['5', '10']),
    MedicineItemDetails(
      itemId: '5',
      itemName: 'Bodrex Herbal',
      itemMrp: '80.99',
      quantity: '100 ml',
      categories: ['Bottle'],
      cover: 'Bottle',
      imageUrl: 'assets/images/bottle.png',
    ),
    MedicineItemDetails(
        itemId: '6',
        itemName: 'Konidin',
        itemMrp: '50.99',
        quantity: '3 pcs',
        imageUrl: 'assets/images/pcs.png',
        categories: ['Strip', 'Bottle']),
  ];
  List<MedicineItemDetails> get popularProducts {
    return [..._popularProducts];
  }

  List<MedicineItemDetails> get productsOnsale {
    return [..._productsOnSale];
  }

  medicineAdded(MedicineItemDetails med) {
    int i =
        _popularProducts.indexWhere((element) => element.itemId == med.itemId);
    _popularProducts[i].inCart = true;
    notifyListeners();
  }
}
