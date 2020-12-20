import '../shared/const/image_api.dart';
import '../shared/models/image.dart';
import 'repositories/get_image_interface.dart';

class HomeController {
  ImageModel _backgroundImage;

  IGetImage _getImage;
  HomeController(this._getImage);

  Future<ImageModel> getRandomImage() async {
    if (_backgroundImage != null) return _backgroundImage;

    Map<String, dynamic> parameters = {
      'query': 'cities',
      'client_id': ACCESS_KEY
    };

    _backgroundImage = await _getImage.getRandomImage(parameters);
    return _backgroundImage;
  }

  Future<String> getImageByCountry(String cityName) => null;
}
