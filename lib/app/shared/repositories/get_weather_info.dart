import 'package:dio/dio.dart';
import '../const/weather_search_api.dart';

import '../../shared/models/location.dart';
import 'get_weather_info_interface.dart';

class GetWeatherInfoRepository implements IGetWeatherInfo {
  final Dio dio;

  GetWeatherInfoRepository(this.dio);

  @override
  Future<LocationModel> getCurrentLocation(Map<String, dynamic> parameters) async {
    Response<Map<String, dynamic>> cityInfo;
    Response<Map<String, dynamic>> weatherInfo;

    String locationKey = parameters["location_key"];
    parameters.remove("location_key");

    try {
      cityInfo = await dio.get('$CITY_INFO_ENDPOINT/$locationKey',
          queryParameters: parameters);
    } on DioError catch (e) {
      print(e);

      return null;
    }

    try {
      weatherInfo = await dio.get('$CURRENT_CONDITIONS_ENDPOINT/$locationKey',
          queryParameters: parameters);
    } on DioError catch (e) {
      print(e.error);

      return null;
    }

    return LocationModel(
        name: cityInfo.data["LocalizedName"],
        administrativeArea: cityInfo.data["AdministrativeArea"]["LocalizedName"],
        locationKey: locationKey,
        weather: weatherInfo.data["WeatherText"],
        temperatureInCelsius: weatherInfo.data["Temperature"]["Metric"]["Value"]);
  }

  @override
  Future<List<LocationModel>> getMatchLocations(Map<String, dynamic> parameters) async {
    Response<List> response;

    try {
      response =
          await dio.get(CITIES_MATCH_ENDPOINT, queryParameters: parameters);
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
