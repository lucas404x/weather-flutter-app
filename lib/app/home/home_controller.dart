import '../shared/repositories/get_image_interface.dart';

class HomeController {
  final IGetImage _getImage;
  const HomeController(this._getImage);

  Future<String> getRandomImage(double size) =>
      _getImage.getRandomImage(size);

  Future<String> getImageByCountry(String countryName) =>
      _getImage.getImageByCountry(countryName);
}
