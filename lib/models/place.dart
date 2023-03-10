import 'dart:io';
import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double? latitude;
  final double? longitude;
  final String? address;

  const PlaceLocation(
      {required this.latitude, required this.longitude, this.address});
}

class Place {
  final String? id;
  final String? title;
  final File? imageUrl;
  final PlaceLocation? location;

  Place(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.location});
}
