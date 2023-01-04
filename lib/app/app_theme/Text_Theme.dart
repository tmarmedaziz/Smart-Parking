import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Text_Theme{
static var style1 = GoogleFonts.dmSans(
  textStyle: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 6,
  ),
);
static var style2 = GoogleFonts.dmSans(
  textStyle: TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    height: 1.2,
  ),
);

static var style3 = GoogleFonts.dmSans(
  textStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.2,
  ),
);
}



const kDefaultShadow = BoxShadow(
  offset: Offset(0, 0),
  blurRadius: 20,
  color: Colors.black26,
);

var kLightShadow = BoxShadow(
  offset: Offset(0, 3),
  blurRadius: 15,
  color: Colors.grey.shade500,
);
