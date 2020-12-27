import 'package:flutter/material.dart';

class LocationModel {
  final String name;
  final String locationKey;
  final String administrativeArea;
  final String weather;
  final double temperatureInCelsius;

  LocationModel(
      {@required this.name,
      @required this.locationKey,
      @required this.administrativeArea,
      @required this.weather,
      @required this.temperatureInCelsius});

  Map<String, dynamic> toMap() => {
        'name': name,
        'locationKey': locationKey,
        'administrativeArea': administrativeArea,
        'weather': weather,
        'temperatureInCelsius': temperatureInCelsius
      };
}
