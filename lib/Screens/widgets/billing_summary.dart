import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Padding billingSummary(String leading, String trailing, TextStyle? style) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          leading,
          style: style ??
              GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w400),
        ),
        Text(
          '₹${trailing}',
          style: style ??
              GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
