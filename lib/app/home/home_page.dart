import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared/const/image_api.dart' as image;
import '../shared/const/weather_search_api.dart' as weather;
import '../shared/data/firestore_database.dart';
import '../shared/models/image.dart';
import '../shared/models/location.dart';
import '../shared/models/user.dart';
import '../shared/repositories/get_weather_info.dart';
import 'home_controller.dart';
import 'repositories/get_image.dart';
import 'widgets/search_bar/search_bar.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;

  HomePage({Key key, @required this.userModel}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _homeController;

  @override
  void initState() {
    _homeController = HomeController(
        getWeatherInfo: GetWeatherInfoRepository(
            Dio(BaseOptions(baseUrl: weather.BASE_URL))),
        getImage: GetImageRepository(
          Dio(BaseOptions(baseUrl: image.BASE_URL)),
        ),
        storage: FirestoreDatabase(FirebaseFirestore.instance),
        userModel: widget.userModel);

    _homeController.getUserLocations();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _deviceInfo = MediaQuery.of(context);

    final _width = _deviceInfo.size.width;
    final _height = _deviceInfo.size.height;
    final _dpr = _deviceInfo.devicePixelRatio;

    return Stack(
      children: [
        FutureBuilder<ImageModel>(
          future: _homeController.getRandomImage(),
          builder: (_, snapshot) => snapshot.hasData
              ? Opacity(
                  opacity: .3,
                  child: AspectRatio(
                      aspectRatio: .9,
                      child: BlurHash(
                        curve: Curves.easeInOutBack,
                        imageFit: BoxFit.cover,
                        image: snapshot.data
                            .urlWithResizedImage(_width, _height, _dpr),
                        hash: snapshot.data.blurHash,
                      )))
              : Container(
                  color: Colors.black,
                ),
        ),
        SafeArea(
          minimum: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 25.0),
          child: Scaffold(
            body: Column(
              children: [
                SizedBox(height: 100),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hi ${_homeController.userModel.name ?? "there"}!👋",
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
                  height: _height * .06,
                ),
                SearchBar(
                  width: _width,
                  height: _height * .07,
                  userModel: _homeController.userModel,
                ),
                SizedBox(height: _height * .16),
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
                ),
                StreamBuilder<List<LocationModel>>(
                    stream: _homeController.userLocations,
                    builder: (_, snapshot) => snapshot.hasData
                        ? Expanded(
                            child: ListView.builder(
                            itemBuilder: (_, index) => Text(
                              snapshot.data[index].name,
                              style: TextStyle(color: Colors.white),
                            ),
                            itemCount: snapshot.data.length,
                          ))
                        : Container(
                            color: Colors.transparent,
                          ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
