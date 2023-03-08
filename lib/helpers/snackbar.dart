import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackBar(String s, BuildContext context) {
  final snackBar = SnackBar(
    content: Text(
      s,
      style: GoogleFonts.poppins(),
      textAlign: TextAlign.center,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
