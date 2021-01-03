import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../search/search_page.dart';
import '../../../shared/models/user.dart';

class SearchBar extends StatelessWidget {
  final double width;
  final double height;

  final UserModel userModel;

  const SearchBar(
      {Key key, @required this.width, @required this.height, @required this.userModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: Colors.white.withOpacity(0),
        borderRadius: BorderRadius.circular(30),
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => SearchPage(userModel))),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Search a city',
                    style: GoogleFonts.montserrat(color: Colors.white)),
                Icon(Icons.search, color: Colors.white)
              ],
            ),
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(30)),
          width: width,
          height: height,
        ),
      ),
    );
  }
}
