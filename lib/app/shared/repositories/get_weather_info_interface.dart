import '../../shared/models/location.dart';

abstract class IGetWeatherInfo {
  Future<LocationModel> getCurrentLocation(Map<String, dynamic> parameters);
  Future<List<LocationModel>> getMatchLocations(Map<String, dynamic> parameters);
}
