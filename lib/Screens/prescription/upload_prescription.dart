import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediq/Screens/widgets/title_text.dart';
import 'package:mediq/helpers/calculate_pixels.dart';

import '../../navigation/navigators.dart';
import '../../navigation/routes.dart';

class UploadPrescriptionScreen extends StatelessWidget {
  const UploadPrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: dw * 0.2,
        backgroundColor: const Color.fromARGB(238, 24, 143, 121),
        elevation: 0,
        title: const Text('Upload Prescription'),
      ),
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                height: getPixels(48, dw),
                //  width: getPixels(305, dw), //dw * 0.1,
                decoration: const BoxDecoration(
                    color: Color(0xffd7d0ff),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Flat',
                      style: GoogleFonts.lato(
                          fontSize: 13.01, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      ' 15% off*',
                      style: GoogleFonts.lato(
                          fontSize: 13.01, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      ' on Medicine Order',
                      style: GoogleFonts.lato(
                          fontSize: 13.01, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Upload Prescription',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      color: Color(0xff151921),
                      fontSize: 16.26,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  height: getPixels(164, dw),
                  width: getPixels(189, dw),
                  /*   decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(22.0)),
                      border: Border.all(width: 3.0, color: Color(0xff188f79))), */
                  child: Center(
                      child: Image.asset(
                          'assets/images/sample.png') /* Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          color: Colors.grey,
                          size: 54,
                        ),
                        Text(
                          'Select File',
                          style: GoogleFonts.urbanist(
                              fontSize: 16.26,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        )
                      ],
                    ), */
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/images/shield.svg',
                      height: dw * 0.15,
                      width: 31,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Your Attached Prescription will be \nsecure and Private.',
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              PrescritionBenefits(dw: dw),
              SizedBox(
                height: getPixels(120, dw),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 21),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(11.38))),
        //  width: dw * 0.8,
        height: getPixels(50, dw), // dw * 0.12,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(11.38))),
            backgroundColor: const Color(0xff0BAB7C),
            //onPrimary: Colors.black,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CONTINUE',
                style: GoogleFonts.lato(
                    fontSize: 14.6, fontWeight: FontWeight.w800),
              ),
              const Icon(Icons.chevron_right)
            ],
          ),
          onPressed: () {
            print('object');
            push(context, NamedRoute.photoUploadScreen);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class PrescritionBenefits extends StatelessWidget {
  const PrescritionBenefits({
    Key? key,
    required this.dw,
  }) : super(key: key);

  final double dw;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
            child: Text(
              'Why Upload a Prescription',
              textAlign: TextAlign.left,
              style: GoogleFonts.lato(
                  fontSize: 13.26, fontWeight: FontWeight.w700),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  'assets/images/mobile.svg',
                  width: dw * 0.05,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                    style: GoogleFonts.lato(
                      fontSize: 11.38,
                      fontWeight: FontWeight.w400,
                    ),
                    'Never Lose the Digital of your Prescription. It will be with\nyou wherever you go.'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/images/tataLabs.svg',
                  width: dw * 0.05,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                ),
                child: Text(
                    style: GoogleFonts.lato(
                      fontSize: 11.38,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                    ),
                    'Tata labs specialist will help you.'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/images/lock.svg',
                  width: dw * 0.05,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                    style: GoogleFonts.lato(
                      height: 1.4,
                      fontSize: 11.38,
                      fontWeight: FontWeight.w400,
                    ),
                    'Details from your Prescription are not shared with any \nthird Party.'),
              )
            ],
          )
        ],
      ),
    );
  }
}
