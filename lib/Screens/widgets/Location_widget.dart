import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationWidget extends StatelessWidget {
  LocationWidget({
    Key? key,
    required this.dw,
    required this.button,
    required this.leading,
    required this.title,
    required this.gestureTapCallback,
  }) : super(key: key);
  final VoidCallback gestureTapCallback;
  final double dw;
  final Widget leading;
  final String title;
  final bool button;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: dw,
      height: dw * 0.15,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
        color: Colors.white,
        border: Border.all(width: 0.5, color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: () => gestureTapCallback(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                leading,
                SizedBox(
                  width: dw * 0.05,
                ),
                Text(
                  title,
                  style: GoogleFonts.lato(
                      //  letterSpacing: 0.04,
                      color: Color.fromARGB(255, 12, 32, 51),
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            button
                ? Text(
                    'Change',
                    style: GoogleFonts.lato(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
