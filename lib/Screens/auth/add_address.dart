import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediq/helpers/calculate_pixels.dart';
import 'package:mediq/helpers/snackbar.dart';
import 'package:mediq/models/user.dart';
import 'package:mediq/navigation/navigators.dart';
import 'package:mediq/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mediq/providers/place_provider.dart';

class NewAddressScreen extends StatefulWidget {
  const NewAddressScreen({super.key, required this.address});
  final String? address;

  @override
  State<NewAddressScreen> createState() => _NewAddressScreenState();
}

bool saveAddress = true;

class _NewAddressScreenState extends State<NewAddressScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  String? address;
  TextEditingController addressController = TextEditingController();
  List<String> addressItems = [];
  Set<Marker> markers = {};
  TextEditingController addressLineController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController fullAddressController = TextEditingController();
  late GoogleMapController mapController;
  @override
  void initState() {
    address =
        widget.address ?? 'Please Drop Pin on Map or Choose Current Location';
    addressController.text = widget.address ?? 'Not Selected';
    addressItems.add('Not Selected');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _selectPosition(LatLng latLng) async {
      markers.add(Marker(
          markerId: MarkerId(Random().nextInt(1).toString()),
          position: latLng));

      final location = await Provider.of<PlaceProvider>(context, listen: false)
          .addPlace(latLng);
      addressItems = location.split(',');
      print(location);
      fullAddressController.text = location.toString();
      addressLineController.text = addressItems[0];
      landmarkController.text = addressItems[1];

      setState(() {});
    }

    final dw = MediaQuery.of(context).size.width;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userProviderReadOnly = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        toolbarHeight: dw * 0.2,
        backgroundColor: const Color.fromARGB(238, 24, 143, 121),
        elevation: 0,
        centerTitle: true,
        title: const Text('New Address'),
      ),
      body: Container(
        height: dw * 2,
        child: SingleChildScrollView(
          child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //  color: Colors.red,
                height: dw * 0.8,
                child: Stack(
                  children: [
                    GoogleMap(
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        mapType: MapType.normal,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                          mapController = controller;
                        },
                        onTap: _selectPosition,
                        markers: markers,
                        initialCameraPosition: CameraPosition(
                            target: Provider.of<PlaceProvider>(context,
                                    listen: false)
                                .address,
                            zoom: 16)),
                    /*    Positioned(
                      bottom: 20,
                      left: 20,
                      child: GestureDetector(
                        onTap: () async {
                          await _getCurrentLocationData();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.gps_fixed_sharp,
                            size: 20.5,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ) */
                  ],
                ), //ShopAddressInputPage(),
              ),
              Container(
                height: getPixels(520, dw),
                padding: const EdgeInsets.all(12.0),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Address*',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                    ),
                    Container(
                      height: getPixels(48, dw),
                      decoration: BoxDecoration(
                          color: const Color(0xffE8ECF2),
                          border: Border.all(
                            width: 0.01,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0))),
                      child: TextField(
                        readOnly: true,
                        controller: fullAddressController,
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w400, fontSize: 12),
                            hintText: 'Full address',
                            contentPadding: const EdgeInsets.all(8.0),
                            border: InputBorder.none),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'House Number/ Building Name*',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                    ),
                    Container(
                      height: getPixels(48, dw),
                      decoration: BoxDecoration(
                          color: const Color(0xffE8ECF2),
                          border: Border.all(
                            width: 0.01,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0))),
                      child: TextField(
                        controller: addressLineController,
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w400, fontSize: 12),
                            hintText: 'House Number / Flat / Block No.',
                            contentPadding: const EdgeInsets.all(8.0),
                            border: InputBorder.none),
                      ),
                    ),
                    const Divider(
                      thickness: 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Landmark*',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffE8ECF2),
                          border: Border.all(
                            width: 0.01,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0))),
                      child: TextField(
                        controller: landmarkController,
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w400, fontSize: 12),
                            hintText: 'e.g. Near ABC School',
                            contentPadding:
                                const EdgeInsets.only(left: 8.0, bottom: 4),
                            border: InputBorder.none),
                      ),
                    ),
                    const Divider(
                      thickness: 0.1,
                    ),
                    SizedBox(
                      width: dw,
                      height: dw * 0.275,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Full Name*',
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ),
                              Container(
                                width: dw * 0.4,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE8ECF2),
                                    border: Border.all(
                                      width: 0.1,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0))),
                                child: TextField(
                                  controller: fullNameController,
                                  decoration: const InputDecoration(
                                      hintText: '',
                                      contentPadding: EdgeInsets.all(8.0),
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: dw * 0.1,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Address Title*',
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ),
                              Container(
                                width: dw * 0.4,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE8ECF2),
                                    border: Border.all(
                                      width: 0.1,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0))),
                                child: TextField(
                                  controller: titleController,
                                  decoration: InputDecoration(
                                      hintText: 'e.g. Home',
                                      hintStyle: GoogleFonts.inter(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                      contentPadding: const EdgeInsets.only(
                                          left: 8.0, bottom: 4),
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: saveAddress,
                            onChanged: ((value) {
                              print(value);
                              if (value != null) {
                                saveAddress = value;
                              }
                              setState(() {});
                            })),
                        Text(
                          'Save shipping address',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      width: dw * 0.4,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: dw * 0.2,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: dw * 0.87,
        height: dw * 0.2,
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff0BAB7C),
            //onPrimary: Colors.black,
          ),
          onPressed: () {
            if (fullNameController.text == '' || titleController.text == '') {
              showSnackBar('Enter all required fields', context);
              return;
            }
            String pinCode = '';
            try {
              pinCode = addressItems[3].split(' ')[2];
            } catch (e) {
              pinCode = addressItems[4].split(' ')[2];
            }
            print(addressController.text);

            userProvider.addAddress(Address(
                fullName: fullNameController.text,
                city: addressItems[3],
                line1: addressLineController.text,
                line2: landmarkController.text,
                pincode: int.parse(pinCode),
                title: titleController.text.trim(),
                state: addressItems[4].split(' ')[0]));
            userProvider.selectedAddress = 0;
            pop(context);
          },
          child: Text(
            'SAVE ADDRESS',
            style: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
