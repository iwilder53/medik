// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediq/Screens/auth/add_address.dart';
import 'package:mediq/Screens/auth/login.dart';
import 'package:mediq/Screens/auth/user_address.dart';
import 'package:mediq/Screens/checkout/address.dart';
import 'package:mediq/Screens/checkout/checkout.dart';
import 'package:mediq/Screens/checkout/order_confirmed.dart';
import 'package:mediq/Screens/home/homescreen.dart';
import 'package:mediq/Screens/prescription/upload_photo.dart';
import 'package:mediq/Screens/prescription/upload_prescription.dart';
import 'package:mediq/Screens/widgets/prescription_banner.dart';
import 'package:mediq/navigation/arguments.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NamedRoute.homeScreen:
      return _getPageRoute(HomeScreen(
        args: settings.arguments as HomeScreenArguments,
      ));
    case NamedRoute.checkoutScreen:
      return _getPageRoute(const CheckoutScreen());
    case NamedRoute.uploadPrescriptionScreen:
      return _getPageRoute(const UploadPrescriptionScreen());
    case NamedRoute.photoUploadScreen:
      return _getPageRoute(const PhotoUploadScreen());

    case NamedRoute.confirmAddressScreen:
      return _getPageRoute(const ConfirmAddressScreen());
    case NamedRoute.adressesScreen:
      return _getPageRoute(const AdressesScreen());
    case NamedRoute.orderCreatedScreen:
      return _getPageRoute(const OrderCreatedScreen());
    case NamedRoute.loginScreen:
      return _getPageRoute(const LoginScreen());
    case NamedRoute.newAddressScreen:
      return _getPageRoute(NewAddressScreen(
        address: '',
      ));
    default:
      return _getPageRoute(const LoginScreen());
  }
}

PageRoute _getPageRoute(Widget screen) {
  return CupertinoPageRoute(builder: (context) => screen);
}
