import 'package:flutter/material.dart';
import 'package:mediq/models/user.dart';

class UserProvider with ChangeNotifier {
  late UserModel user;
  int selectedAddress = 0;
  void changeSelectedAdress(int index) {
    selectedAddress = index;
    notifyListeners();
  }

  login(int number) {
    user = UserModel(
        name: 'yash',
        addresses: [
          Address(
              fullName: 'Steve Smith',
              city: 'Bangalore City',
              line1: 'Bangalore Airport',
              line2: 'Cubbon Park',
              title: 'Home',
              pincode: 91709,
              state: 'MH')
        ],
        number: number);

    user.addresses.insert(
        0,
        Address(
            fullName: 'David Warner',
            city: 'Mumbai City',
            line1: 'Bangalore Airport',
            line2: 'Cubbon Park',
            title: 'home',
            pincode: 91709,
            state: 'KA'));
    print(user.number);
    //  notifyListeners();
  }

  void addAddress(Address address) {
    user.addresses.insert(0, address);
    notifyListeners();
  }
}
