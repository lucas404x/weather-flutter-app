import '../shared/const/image_api.dart';
import '../shared/models/image.dart';
import '../shared/repositories/get_image_interface.dart';

class HomeController {
  final IGetImage _getImage;
  const HomeController(this._getImage);

  Future<ImageModel> getRandomImage() async {
    Map<String, dynamic> parameters = {
      'query': 'cities',
      'client_id': ACCESS_KEY
    };

    ImageModel image = await _getImage.getRandomImage(parameters);
    return image;
  }

  Future<String> getImageByCountry(String countryName) => null;
}
