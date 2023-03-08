import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediq/helpers/calculate_pixels.dart';

// ignore: must_be_immutable
class TitleText extends StatelessWidget {
  String title;
  bool button;
  TitleText({required this.button, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 16.0, vertical: getPixels(12, dw)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight
                    .w600), //const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.right,
          ),
          button
              ? Text(
                  'See all',
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff199a8e)),
                  textAlign: TextAlign.right,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
