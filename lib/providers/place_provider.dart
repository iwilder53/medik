import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mediq/models/user.dart';

import '../helpers/loc_helper.dart';
import '../models/place.dart';

class TempAddress with ChangeNotifier {
  String line1;
  String landmark;
  TempAddress({required this.landmark, required this.line1});
}

class PlaceProvider with ChangeNotifier {
  late LatLng address;
  String tempAddress = 'unInitialized';

  final List<Place>? _items = [];
  List<Place>? get items {
    return [..._items!];
  }

  Future<String> addPlace(LatLng location) async {
    final address =
        await LocationHelper.getAddress(location.latitude, location.longitude);
    final updatedLocation = PlaceLocation(
        latitude: location.latitude,
        longitude: location.longitude,
        address: address);
    return address;
  }

  setLatLng(LatLng latLng) async {
    address = latLng;

    notifyListeners();
  }
  setTemp(String add){
    tempAddress = add;
    notifyListeners();
  }
}
