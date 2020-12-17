import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'get_image_interface.dart';

class GetImageRepository implements IGetImage {
  String randomImageEndpoint;
  String imageByCountryEndpoint;
  String accessKey;

  Dio dio;

  GetImageRepository(
      {@required this.randomImageEndpoint,
      @required this.accessKey,
      @required this.dio});

  @override
  Future<String> getImageByCountry(String countryName) {
    throw UnimplementedError();
  }

  @override
  Future<String> getRandomImage(double deviceSize) async {
    Response response;
    String uri;

    try {
      response = await dio.get(_joinEndpointWithAccessKey(randomImageEndpoint));
    } on DioError catch (err) {
      print(randomImageEndpoint);
      print(err);

      return null;
    }

    uri = response.data["urls"]["raw"] + "&w=$deviceSize&dpr=2";    
    return uri;
  }

  String _joinEndpointWithAccessKey(String endpoint) {
    return "$endpoint?client_id=$accessKey";
  }
}
