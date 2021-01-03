import 'package:flutter/material.dart';

class LocationModel {
  final String name;
  final String locationKey;
  final String administrativeArea;

  LocationModel({
    @required this.name,
    @required this.locationKey,
    @required this.administrativeArea,
  });

  factory LocationModel.fromMap(Map data) => LocationModel(
      name: data['name'],
      locationKey: data['locationKey'],
      administrativeArea: data['administrativeArea']);

  Map<String, dynamic> toMap() => {
        'name': name,
        'locationKey': locationKey,
        'administrativeArea': administrativeArea
      };
}
