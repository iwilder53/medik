import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediq/Screens/widgets/cart_products.dart';
import 'package:mediq/Screens/widgets/title_text.dart';
import 'package:mediq/helpers/calculate_pixels.dart';
import 'package:mediq/navigation/navigators.dart';
import 'package:mediq/navigation/routes.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/user_provider.dart';
import '../widgets/location_widget.dart';
import '../widgets/billing_summary.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  selectPayment() {
    print('select payment');
  }

  @override
  Widget build(BuildContext context) {
    selectAddress() {
      //TODO : impement select address
      print('Select Address ');
      push(context, NamedRoute.adressesScreen);
    }

    final userProvider = Provider.of<UserProvider>(context);
    final dw = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<Cart>(context);
    final cartItems = cartProvider.items;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        toolbarHeight: dw * 0.2,
        backgroundColor: const Color.fromARGB(238, 24, 143, 121),
        elevation: 0,
        centerTitle: true,
        title: const Text('Order Confirmation'),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: dw * 0.4,
                  ),
                  Center(
                      child: Container(
                          height: getPixels(100, dw),
                          child: Image.asset(
                              'assets/images/cart_illustartion.png'))),
                  SizedBox(
                    height: getPixels(60, dw),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.all(18),
                    child: Column(children: [
                      Text(
                        'Your Cart Is Empty',
                        style: GoogleFonts.lato(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Looks like you haven’t added anything to your cart yet',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: () => pop(context),
                        child: Container(
                          height: getPixels(55, dw),
                          width: getPixels(194, dw),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40.0)),
                            color: const Color.fromARGB(238, 24, 143, 121),
                          ),
                          child: Center(
                              child: Text(
                            'Go Shop',
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.white),
                          )),
                        ),
                      )
                    ]),
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: TitleText(
                      title: 'Cart',
                      button: false,
                    ),
                  ),
                  cartItems.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Your Cart is Empty'),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          height: cartItems.length * (dw * 0.32),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              return CartProductsWidget(
                                product: cartProvider.items[index],
                                index: index,
                              );
                            },
                          ),
                        ),
                  const Divider(
                    thickness: 0.6,
                    color: Color(0xffADADAD),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: TitleText(button: false, title: 'Select Address'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: LocationWidget(
                      dw: dw,
                      button: true,
                      gestureTapCallback: selectAddress,
                      title: userProvider
                          .user.addresses[userProvider.selectedAddress].title
                          .toUpperCase(),
                      leading: SvgPicture.asset('assets/images/location.svg'),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 4.0, right: 4.0, top: 4),
                    child: TitleText(button: false, title: 'Payment Method'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: LocationWidget(
                      dw: dw,
                      gestureTapCallback: selectPayment,
                      title: 'COD',
                      leading: const Icon(Icons.credit_card),
                      button: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 4),
                    child: TitleText(button: false, title: 'Billing Summary'),
                  ),
                  Container(
                    child: Column(
                      children: [
                        billingSummary('Subtotal',
                            cartProvider.subTotal.toStringAsFixed(2), null),
                        billingSummary(
                            'Discount',
                            '-${cartProvider.discount.toStringAsFixed(2)}',
                            GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff0BAB7C))),
                        billingSummary('Shipping',
                            cartProvider.shipping.toStringAsFixed(2), null),
                        billingSummary(
                            'Tax',
                            cartProvider.tax.toStringAsFixed(2),
                            GoogleFonts.lato(
                                fontSize: 12, fontWeight: FontWeight.w400)),
                        const Divider(
                          thickness: 2.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Grand Total',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                '₹${cartProvider.total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getPixels(60, dw),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
      floatingActionButton: cartItems.isEmpty
          ? SizedBox()
          : Container(
              width: dw * 0.8,
              height: dw * 0.12,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  backgroundColor: const Color(0xff0BAB7C),
                  //onPrimary: Colors.black,
                ),
                child: Center(
                  child: Text(
                    'Confirm',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                onPressed: () {
                  push(context, NamedRoute.confirmAddressScreen);
                },
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
