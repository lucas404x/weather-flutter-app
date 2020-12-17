import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

import '../shared/const/image_api.dart';
import '../shared/repositories/get_image.dart';
import '../widgets/search_bar/search_bar.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  final _homeController = HomeController(GetImageRepository(
      dio: Dio(BaseOptions(baseUrl: BASE_URL)),
      accessKey: ACCESS_KEY,
      randomImageEndpoint: GET_RANDOM_IMAGE_ENDPOINT));

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Stack(
      children: [
        FutureBuilder(
            future: _homeController.getRandomImage(_size.height),
            builder: (_, snapshot) => snapshot.hasData
                ? FadeInImage.memoryNetwork(
                    width: _size.width,
                    height: _size.height,
                    fit: BoxFit.fill,
                    placeholder: kTransparentImage,
                    image: snapshot.data)
                : Container(
                    color: Colors.black,
                  )),
        SafeArea(
          minimum: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 25.0),
          child: Scaffold(
            body: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: _size.width * .1,
                    width: _size.width * .1,
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                  ),
                ),
                SizedBox(
                  height: _size.height * .1,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hello Matt',
                      style: GoogleFonts.montserrat(
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Check the weather by the city',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    )),
                SizedBox(
                  height: _size.height * .06,
                ),
                SearchBar(
                  width: _size.width,
                  height: _size.height * .07,
                ),
                SizedBox(height: _size.height * .2),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'My locations',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
