import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../displayWeatherInfo/display_weather_page.dart';

import '../../../shared/models/location.dart';

class CityInfoCard extends StatelessWidget {
  final LocationModel city;
  final double width;

  const CityInfoCard({
    Key key,
    @required this.city,
    @required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.of(context).push(PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = Tween(begin: Offset(0, 1), end: Offset.zero)
                .chain(CurveTween(curve: Curves.ease));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) =>
              DisplayWeatherInfo(location: city),
        )),
        child: Container(
          width: width,
          decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(18)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(city.name,
                  style: GoogleFonts.openSans(
                      color: Colors.white, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
