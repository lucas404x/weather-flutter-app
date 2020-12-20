import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../shared/models/location.dart';
import 'get_weather_info_interface.dart';

class GetWeatherInfoRepository implements IGetWeatherInfo {
  final String getMatchLocationsEndpoint;
  final Dio dio;

  GetWeatherInfoRepository(
      {@required this.getMatchLocationsEndpoint, @required this.dio});

  @override
  Future<LocationModel> getCurrentLocation(Map parameters) => null;

  @override
  Future<List<LocationModel>> getMatchLocations(Map parameters) async {
    Response<List> response;

    try {
      response =
          await dio.get(getMatchLocationsEndpoint, queryParameters: parameters);
    } on DioError catch (e) {
      print(e);

      return null;
    }

    return response.data
        .map((e) => LocationModel(
            name: e["LocalizedName"],
            locationKey: e["Key"],
            administrativeArea: e["AdministrativeArea"]["LocalizedName"],
            weather: null,
            temperatureInCelsius: null))
        .cast<LocationModel>()
        .toList();
  }
}
