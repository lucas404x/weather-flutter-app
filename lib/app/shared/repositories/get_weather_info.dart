import 'package:dio/dio.dart';
import '../const/weather_search_api.dart';

import '../../shared/models/location.dart';
import 'get_weather_info_interface.dart';

class GetWeatherInfoRepository implements IGetWeatherInfo {
  final Dio dio;

  GetWeatherInfoRepository(this.dio);

  @override
  Future<Map<String, dynamic>> getCurrentLocation(
      Map<String, dynamic> parameters) async {
    Response weatherInfo;

    String locationKey = parameters["location_key"];
    parameters.remove("location_key");

    try {
      weatherInfo = await dio.get('$CURRENT_CONDITIONS_ENDPOINT/$locationKey',
          queryParameters: parameters);
    } on DioError catch (e) {
      print(e.error);

      return null;
    }

    print(weatherInfo.data);

    return {
      "weather": weatherInfo.data[0]["WeatherText"],
      "temperature": weatherInfo.data[0]["Temperature"]["Metric"]["Value"]
    };
  }

  @override
  Future<List<LocationModel>> getMatchLocations(
      Map<String, dynamic> parameters) async {
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
            ))
        .cast<LocationModel>()
        .toList();
  }
}
