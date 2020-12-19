import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'search_controller.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = SearchController(TextEditingController());

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
            controller: _searchController.textEditingController,
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
          StreamBuilder(
            stream: _searchController.suggestionsOutput,
            builder: (_, snapshot) => Container(),
          )
        ]),
      ),
    ));
  }
}
