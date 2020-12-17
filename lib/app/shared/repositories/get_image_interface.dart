abstract class IGetImage {
  Future<String> getImageByCountry(String countryName);
  Future<String> getRandomImage(double deviceSize);
}
