import '../home/repositories/get_image_interface.dart';
import '../shared/const/image_api.dart';
import '../shared/const/weather_search_api.dart';
import '../shared/models/image.dart';
import '../shared/repositories/get_weather_info_interface.dart';

class DisplayWeatherController {
  IGetImage getImage;
  IGetWeatherInfo getWeatherInfo;

  DisplayWeatherController(this.getImage, this.getWeatherInfo);

  Future<ImageModel> getImageByLocation(String cityName) async {
    Map<String, dynamic> parameters = {
      'client_id': ACCESS_KEY,
      'query': cityName
    };

    return await getImage.getImageByCountry(parameters);
  }

  Future<Map<String, dynamic>> getLocationWeatherInfo(
      String locationKey) async {
    Map<String, dynamic> parameters = {
      'location_key': locationKey,
      'apikey': API_KEY
    };

    return await getWeatherInfo.getCurrentLocation(parameters);
  }
}
