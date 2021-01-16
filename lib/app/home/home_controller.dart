import 'package:flutter/foundation.dart';

import '../shared/const/image_api.dart';
import '../shared/const/weather_search_api.dart';
import '../shared/data/storage_interface.dart';
import '../shared/errors/storage_exception.dart';
import '../shared/models/image.dart';
import '../shared/models/location.dart';
import '../shared/models/user.dart';
import '../shared/repositories/get_weather_info_interface.dart';
import 'repositories/get_image_interface.dart';

class HomeController {
  HomeController(
      {@required this.getWeatherInfo,
      @required this.getImage,
      @required this.storage,
      @required this.userModel});

  ImageModel _backgroundImage;

  IGetWeatherInfo getWeatherInfo;
  IGetImage getImage;
  IStorage storage;

  UserModel userModel;

  List<ImageModel> _listImages;
  List<ImageModel> get listImages => _listImages;

  Future<Stream<List<LocationModel>>> getUserLocations() async {
    Stream<List<LocationModel>> userLocations;

    try {
      userLocations = storage.getAllLocations(userModel);
    } on StorageException catch (e) {
      if (e.runtimeType == UserDoesNotExists) {
        await storage.createUser(userModel);
        userLocations = storage.getAllLocations(userModel);
      }
    }
    
    return userLocations;
  }

  Future<Map<String, dynamic>> getLocation(LocationModel location) async {
    Map parameters = {
      'api_key': API_KEY,
      'location_key': location.locationKey,
    };

    return await getWeatherInfo.getCurrentLocation(parameters);
  }

  Future<ImageModel> getRandomImage() async {
    if (_backgroundImage != null) return _backgroundImage;

    Map<String, dynamic> parameters = {
      'query': 'cities',
      'client_id': ACCESS_KEY,
      'per_page': 1
    };

    _backgroundImage = await getImage.getRandomImage(parameters);
    return _backgroundImage;
  }
}
