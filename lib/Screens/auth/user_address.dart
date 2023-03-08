import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediq/helpers/calculate_pixels.dart';
import 'package:mediq/navigation/navigators.dart';
import 'package:mediq/navigation/routes.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class AdressesScreen extends StatefulWidget {
  const AdressesScreen({super.key});

  @override
  State<AdressesScreen> createState() => _AdressesScreenState();
}

class _AdressesScreenState extends State<AdressesScreen> {
  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width;
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        toolbarHeight: dw * 0.2,
        backgroundColor: const Color.fromARGB(238, 24, 143, 121),
        elevation: 0,
        title: Text('Shipping Addresses',
            style: GoogleFonts.lato(fontWeight: FontWeight.w700)),
      ),

      backgroundColor: Colors.white, // Color.fromARGB(255, 240, 240, 240),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: userProvider.user.addresses.length *
                  getPixels(180, dw), //* (dw * 0.42),
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: userProvider.user.addresses.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 1),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.2,
                              blurRadius: 4,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ],
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6.0))),
                      height: getPixels(140, dw), //dw * 0.35,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  userProvider.user.addresses[index].fullName,
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Edit',
                                      style: GoogleFonts.lato(
                                          color: const Color(0xffDB3022),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ],
                            ),
                            Text(userProvider.user.addresses[index].line1),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                style: GoogleFonts.lato(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                                '${userProvider.user.addresses[index].line2},${userProvider.user.addresses[index].pincode},${userProvider.user.addresses[index].city}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: getPixels(20, dw),
                                  width: getPixels(20, dw),
                                  child: Checkbox(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return const Color(0xff188F79)
                                              .withOpacity(.80);
                                        }
                                        return const Color(0xff188F79)
                                            .withOpacity(.80);
                                      }),
                                      value:
                                          index == userProvider.selectedAddress,
                                      onChanged: (value) {
                                        if (value != null) {
                                          Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .changeSelectedAdress(index);

                                          //  setState(() {});
                                        }
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'Use as the shipping address',
                                    style: GoogleFonts.lato(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: getPixels(36, dw),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FloatingActionButton(
                    elevation: 2,
                    backgroundColor: const Color.fromARGB(210, 24, 143, 121),
                    onPressed: () {
                      push(context, NamedRoute.newAddressScreen);
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(
              height: getPixels(120, dw),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24.0))),
        height: dw * 0.125,
        width: dw * 0.8,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff0BAB7C),
              //onPrimary: Colors.black,
            ),
            onPressed: () => pop(context),
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
            )),
      ),
    );
  }
}
