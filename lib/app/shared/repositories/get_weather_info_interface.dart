import '../../shared/models/location.dart';

abstract class IGetWeatherInfo {
  Future<Map<String, dynamic>> getCurrentLocation(Map<String, dynamic> parameters);
  Future<List<LocationModel>> getMatchLocations(Map<String, dynamic> parameters);
}
