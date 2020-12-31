import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared/const/weather_search_api.dart' as weather;
import '../shared/models/location.dart';
import '../shared/repositories/get_weather_info.dart';
import 'search_controller.dart';
import 'widgets/city_card/city_card.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = SearchController(
      GetWeatherInfoRepository(Dio(BaseOptions(baseUrl: weather.BASE_URL))));

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          TextField(
            onChanged: _searchController.inputLocation,
            style: GoogleFonts.openSans(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
                hintText: "Search a city",
                hintStyle: GoogleFonts.openSans(
                    textStyle: TextStyle(
                  color: Colors.white,
                )),
                disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                )),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white60, width: 1)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.4))),
            autofocus: true,
          ),
          Expanded(
            child: StreamBuilder<List<LocationModel>>(
                stream: _searchController.suggestionsOutput,
                builder: (_, snapshot) =>
                    !snapshot.hasData || snapshot.data.length == 0
                        ? Center(
                            child: Text(
                              "There are no results for what you are typing",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 24),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(top: 30),
                            itemBuilder: (_, index) => CityCard(
                                locationModel: snapshot.data[index],
                                buildContext: context,
                                onTap: _searchController.selectLocation),
                            itemCount: snapshot.data.length)),
          )
        ]),
      ),
    ));
  }
}
