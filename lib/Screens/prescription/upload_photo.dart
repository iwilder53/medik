import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediq/Screens/widgets/title_text.dart';

import '../../helpers/calculate_pixels.dart';
import '../../navigation/navigators.dart';
import '../../navigation/routes.dart';

class PhotoUploadScreen extends StatelessWidget {
  const PhotoUploadScreen({super.key});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              height: getPixels(49, dw),
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
            Container(
              height: getPixels(242, dw),
              width: getPixels(350, dw),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 1,
                      offset: const Offset(1, 3), // changes position of shadow
                    ),
                  ],
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: const BorderRadius.all(Radius.circular(6.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UPLOAD',
                      style: GoogleFonts.lato(
                          color: const Color(0xff958A8A),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: getPixels(6, dw),
                    ),
                    Text(
                      'Please upload images of valid prescription from your doctor',
                      style: GoogleFonts.lato(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: getPixels(20, dw),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: getPixels(60, dw),
                        width: getPixels(204, dw),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(210, 24, 143, 121),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.38))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/camera.png',
                                  height: getPixels(25, dw),
                                  width: getPixels(25, dw),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    'Camera',
                                    style: GoogleFonts.lato(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: getPixels(44, dw),
                              child: const VerticalDivider(
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/gallery.png',
                                  height: getPixels(25, dw),
                                  width: getPixels(23, dw),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    'Gallery',
                                    style: GoogleFonts.lato(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: getPixels(16, dw),
                              height: getPixels(44, dw),
                              child: const VerticalDivider(
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/file.png',
                                  height: getPixels(25, dw),
                                  width: getPixels(23, dw),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    'Past Rx',
                                    style: GoogleFonts.lato(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2.0,
                    ),
                    SizedBox(
                      height: getPixels(80, dw),
                      //  width: getPixels(80, dw),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.0),
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            height: getPixels(76, dw),
                            width: getPixels(76, dw),
                            color: Colors.green,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            padding: EdgeInsets.all(8.0),
                            height: getPixels(76, dw),
                            width: getPixels(76, dw),
                            color: Colors.green,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            padding: EdgeInsets.all(8.0),
                            height: getPixels(76, dw),
                            width: getPixels(76, dw),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
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
            shape: const RoundedRectangleBorder(
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
            push(context, NamedRoute.photoUploadScreen);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
