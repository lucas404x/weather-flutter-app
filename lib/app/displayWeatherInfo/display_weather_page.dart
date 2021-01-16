import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/app/shared/const/weather_search_api.dart'
    as weather;
import 'package:weather_app/app/shared/repositories/get_weather_info.dart';

import '../home/repositories/get_image.dart';
import '../shared/const/image_api.dart' as image;
import '../shared/models/image.dart';
import '../shared/models/location.dart';
import 'display_weather_controller.dart';

class DisplayWeatherInfo extends StatefulWidget {
  final LocationModel location;

  const DisplayWeatherInfo({Key key, @required this.location})
      : super(key: key);

  @override
  _DisplayWeatherInfoState createState() => _DisplayWeatherInfoState();
}

class _DisplayWeatherInfoState extends State<DisplayWeatherInfo>
    with TickerProviderStateMixin {
  DisplayWeatherController displayWeatherController;

  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    displayWeatherController = new DisplayWeatherController(
        GetImageRepository(Dio(BaseOptions(baseUrl: image.BASE_URL))),
        GetWeatherInfoRepository(Dio(BaseOptions(baseUrl: weather.BASE_URL))));

    animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _deviceInfo = MediaQuery.of(context);
    final _size = _deviceInfo.size;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: FutureBuilder<ImageModel>(
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.done
                      ? Stack(children: [
                          snapshot.hasData
                              ? Opacity(
                                  opacity: 0.3,
                                  child: BlurHash(
                                    hash: snapshot.data.blurHash,
                                    curve: Curves.ease,
                                    imageFit: BoxFit.cover,
                                    image: snapshot.data.urlWithResizedImage(
                                        _size.width,
                                        _size.height,
                                        _deviceInfo.devicePixelRatio),
                                  ))
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 128, horizontal: 16),
                            child: FutureBuilder<Map<String, dynamic>>(
                              future: displayWeatherController
                                  .getLocationWeatherInfo(
                                      widget.location.locationKey),
                              builder: (context, snapshot) => snapshot.hasData
                                  ? FadeTransition(
                                      opacity: animation,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            widget.location.name,
                                            textAlign: TextAlign.center,
                                            softWrap: true,
                                            style: GoogleFonts.raleway(
                                                color: Colors.white,
                                                fontSize: 36,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${snapshot.data["temperature"]}°",
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                              style: GoogleFonts.raleway(
                                                  color: Colors.white,
                                                  fontSize: 48,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data["weather"]}",
                                            textAlign: TextAlign.center,
                                            softWrap: true,
                                            style: GoogleFonts.raleway(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ))
                                  : Container(),
                            ),
                          )
                        ])
                      : Container(),
              future: displayWeatherController
                  .getImageByLocation(widget.location.name)),
        ),
      ),
    );
  }
}
