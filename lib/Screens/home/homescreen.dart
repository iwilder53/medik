// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mediq/Screens/widgets/badge.dart';
import 'package:mediq/Screens/widgets/prescription_banner.dart';
import 'package:mediq/Screens/widgets/product_grid.dart';
import 'package:mediq/Screens/widgets/title_text.dart';
import 'package:mediq/helpers/calculate_pixels.dart';
import 'package:mediq/navigation/arguments.dart';
import 'package:mediq/navigation/navigators.dart';
import 'package:mediq/navigation/routes.dart';
import 'package:mediq/providers/cart_provider.dart';
import 'package:mediq/providers/place_provider.dart';
import 'package:mediq/providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../../helpers/loc_helper.dart';
import '../../providers/user_provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreenArguments args;
  HomeScreen({required this.args, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false)
        .login(widget.args.mobNumber);
    super.initState();
  }

//  TempAddress address = TempAddress(landmark: 'landmark', line1: 'line');
  String tempAddress = 'unInitialized';

  Future<String> setLocation() async {
    LocationData loc;
    try {
      loc = await Location().getLocation();
      if (tempAddress != 'unInitialized') {
        return tempAddress;
      }

      tempAddress =
          await LocationHelper.getAddress(loc.latitude!, loc.longitude!);
      Provider.of<PlaceProvider>(context, listen: false)
          .setLatLng(LatLng(loc.latitude!, loc.longitude!));
      Provider.of<PlaceProvider>(context, listen: false).setTemp(tempAddress);
      return tempAddress;
    } on Exception catch (e) {
      // TODO
      showDialog(
          context: context,
          builder: ((context) {
            return const AlertDialog(
              content: Text('Please enable location to continue'),
            );
          }));
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width;
    final popularProducts =
        Provider.of<ProductsProvider>(context).popularProducts;
    final cartItems = Provider.of<Cart>(context).items.length;
    final productsOnsale =
        Provider.of<ProductsProvider>(context).productsOnsale;
    final user = Provider.of<UserProvider>(context)
        .user
        .addresses[Provider.of<UserProvider>(context).selectedAddress];

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            Container(
              height: getPixels(28, dw),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      child: Image.asset(
                        'assets/images/scan.png',
                        height: getPixels(20, dw),
                        width: getPixels(20, dw),
                      ),
                      onTap: () {},
                    ),
                  ),
                  GestureDetector(
                    child: cartItems == 0
                        ? Image.asset(
                            'assets/images/cart.png',
                            height: getPixels(20, dw),
                            width: getPixels(20, dw),
                          )
                        : CartBadge(dw: dw, cartItems: cartItems),
                    onTap: () => push(context, NamedRoute.checkoutScreen),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      child: Image.asset(
                        'assets/images/user.png',
                        height: getPixels(20, dw),
                        width: getPixels(20, dw),
                      ),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        pushReplacement(context, NamedRoute.loginScreen);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
          toolbarHeight: dw * 0.2,
          backgroundColor: const Color.fromARGB(210, 24, 143, 121),
          elevation: 0,
          //  leadingWidth: 320,

          title: Container(
            width: 370,
            //  margin: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: setLocation(),
              builder: (context, snapshot) {
                if (tempAddress != 'unInitialized') {
                  return Text(
                    'Deliver To :  ${tempAddress.split(',')[0]}\n${tempAddress.split(',')[3]} ',
                    style: GoogleFonts.lato(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  );
                } else {
                  return Text(
                    'Fetching location',
                    style: GoogleFonts.lato(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  );
                }
              },
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(clipBehavior: Clip.none, children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  color: Color.fromARGB(210, 24, 143, 121),
                ),
                height: dw * 0.06,
              ),
              Column(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 1.5,
                              //  offset: Offset(1, 1), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.81)),
                      width: dw * 0.8,
                      child: Center(
                        child: TextField(
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(12.0),
                            fillColor: Colors.white,
                            hintText: 'Search drugs,category',
                            hintStyle: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xffadadad)),
                            isDense: true,
                            prefixIconConstraints:
                                const BoxConstraints(maxHeight: 40),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/images/search_light.svg',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: getPixels(13, dw),
                    ),
                    const UploadPrescriptionBanner(),
                    TitleText(
                      title: 'Popular Product',
                      button: true,
                    ),
                    ProductGrid(
                      dw: dw,
                      products: popularProducts,
                    ),
                    TitleText(
                      title: 'Products on Sale',
                      button: true,
                    ),
                    ProductGrid(
                      dw: dw,
                      products: productsOnsale,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CartBadge extends StatelessWidget {
  const CartBadge({
    Key? key,
    required this.dw,
    required this.cartItems,
  }) : super(key: key);

  final double dw;
  final int cartItems;

  @override
  Widget build(BuildContext context) {
    return Badge(
      child: Image.asset(
        'assets/images/cart.png',
        height: getPixels(20, dw),
        width: getPixels(20, dw),
      ),
      color: Colors.white,
      value: cartItems.toString(),
    );
  }
}
