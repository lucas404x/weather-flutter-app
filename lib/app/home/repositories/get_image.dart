import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../../shared/models/image.dart';

import 'get_image_interface.dart';

class GetImageRepository implements IGetImage {
  final String endpoint;
  final Dio dio;

  const GetImageRepository({@required this.endpoint, @required this.dio});

  @override
  Future<ImageModel> getImageByCountry(Map<String, dynamic> parameters) {
    throw UnimplementedError();
  }

  @override
  Future<ImageModel> getRandomImage(Map<String, dynamic> parameters) async {
    Response response;

    try {
      response = await dio.get(endpoint, queryParameters: parameters);
    } on DioError catch (err) {
      print(endpoint);
      print(err);

      return null;
    }

    return ImageModel.fromMap(response.data);
  }
}
