import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primary = const Color(0xffF1FAEE);

class Style{
  static Color bgColor = primary;
  static TextStyle loadingStyle = GoogleFonts.inter(
    fontSize: 32,
    letterSpacing: 2,
    fontWeight: FontWeight.bold,
    color: const Color(0xff442f24 )
  );
  static TextStyle loadingTeamStyle = GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: const Color(0xff442f24 )
  );
  static TextStyle headingStyle = GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white
  );
  static TextStyle headingStyle2 = GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: const Color(0xff442f24)
  );
  static TextStyle headingStyle3 = GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.w500,
      color: const Color(0xff1D3557),
  );
  static TextStyle numberStyle = GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.black,
  );
  static TextStyle numberStyle2 = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle numberStyle3 = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

}