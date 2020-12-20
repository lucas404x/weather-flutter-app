import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../shared/const/weather_search_api.dart' as weather;
import '../shared/models/location.dart';
import 'repositories/get_weather_info_interface.dart';

class SearchController {
  SearchController(this.getWeatherInfo) {
    _inputQuery
        .debounceTime(Duration(milliseconds: 650))
        .listen(_searchMatchLocations);
  }

  final IGetWeatherInfo getWeatherInfo;

  final _inputQuery = BehaviorSubject<String>();

  final _suggestions = BehaviorSubject<List<LocationModel>>.seeded([]);
  Stream<List> get suggestionsOutput => _suggestions.stream;

  void inputLocation(String location) => _inputQuery.add(location);

  Future<void> _searchMatchLocations(String query) async {
    print('searching $query');
    if (query.isEmpty) {
      _suggestions.add([]);
      return;
    }

    Map<String, dynamic> parameters = {'apikey': weather.API_KEY, 'q': query};
    List<LocationModel> suggestions =
        await getWeatherInfo.getMatchLocations(parameters);

    _suggestions.add(suggestions);
  }

  Future<void> selectLocation(BuildContext context, LocationModel location) async {
    print(location.locationKey);
    Navigator.pop(context);
  }

  void dispose() {
    _inputQuery.close();
    _suggestions.close();
  }
}
