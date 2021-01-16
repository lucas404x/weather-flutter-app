import 'package:dio/dio.dart';

import '../../shared/const/image_api.dart';
import '../../shared/models/image.dart';
import 'get_image_interface.dart';

class GetImageRepository implements IGetImage {
  final Dio dio;

  const GetImageRepository(this.dio);

  @override
  Future<ImageModel> getImageByCountry(Map<String, dynamic> parameters) async {
    Response response;

    try {
      response = await dio.get(GET_IMAGE_BY_NAME_ENDPOINT,
          queryParameters: parameters);
    } on DioError catch (err) {
      print("errorInfo: ${err.response.data}, ${err.response.realUri}");
      return null;
    }

    return ImageModel.fromMap(response.data["results"][0]);
  }

  @override
  Future<ImageModel> getRandomImage(Map<String, dynamic> parameters) async {
    Response response;
    try {
      response = await dio.get(GET_IMAGE_ENDPOINT, queryParameters: parameters);
    } on DioError catch (err) {
      print("errorInfo: ${err.response.data}, ${err.response.realUri}");

      return null;
    }

    return ImageModel.fromMap(response.data);
  }
}
