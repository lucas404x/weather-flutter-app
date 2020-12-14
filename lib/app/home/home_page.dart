import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_controller.dart';
import '../widgets/search_bar/search_bar.dart';

class HomePage extends StatelessWidget {
  final _homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return SafeArea(
      minimum: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 25.0),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: _size.width * .1,
                  width: _size.width * .1,
                  decoration:
                      BoxDecoration(color: Colors.white, shape: BoxShape.circle),
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
      );
  }
}
