import '../models/image.dart';

abstract class IGetImage {
  Future<ImageModel> getImageByCountry(Map<String, dynamic> parameters);
  Future<ImageModel> getRandomImage(Map<String, dynamic> parameters);
}
