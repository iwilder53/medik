import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediq/helpers/calculate_pixels.dart';
import 'package:mediq/navigation/navigators.dart';
import 'package:mediq/navigation/routes.dart';

class UploadPrescriptionBanner extends StatelessWidget {
  const UploadPrescriptionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    double dw = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      width: dw,
      height: dw * 0.36,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          color: Color(0xffe8f3f1)),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(26.0, 21, 0.0, 0.0),
                child: Text(
                  'Order Quickly With\nPrescription',
                  style: GoogleFonts.inter(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 26.0, top: 16, bottom: 16.0),
                decoration: BoxDecoration(
                    color: Color(0xff199a8e),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                height: dw * 0.0773,
                width: dw * 0.362,
                child: TextButton(
                    onPressed: () =>
                        push(context, NamedRoute.uploadPrescriptionScreen),
                    child: Text(
                      'Upload Prescription',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1),
                    )),
              )
            ],
          ),
          Align(
            heightFactor: 2,
            alignment: Alignment.topRight,
            child: Image.asset(
              'assets/images/pills.png',
              width: dw * 0.32,
              height: dw * 0.56,
            ),
          )
        ],
      ),
    );
  }
}
