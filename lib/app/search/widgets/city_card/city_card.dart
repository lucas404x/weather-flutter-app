import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/models/location.dart';

class CityCard extends StatelessWidget {
  final BuildContext buildContext;
  final LocationModel locationModel;
  final Function(BuildContext, LocationModel) onTap;

  const CityCard(
      {Key key,
      @required this.buildContext,
      @required this.locationModel,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(buildContext, locationModel),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.white,
          )),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Text(
            '${locationModel.name} - ${locationModel.administrativeArea}',
            style: GoogleFonts.openSans(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
