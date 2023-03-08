import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediq/Screens/widgets/title_text.dart';
import 'package:mediq/models/payment_methods.dart';
import 'package:mediq/models/user.dart';
import 'package:mediq/navigation/navigators.dart';
import 'package:mediq/navigation/routes.dart';
import 'package:mediq/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';

class ConfirmAddressScreen extends StatefulWidget {
  const ConfirmAddressScreen({super.key});

  @override
  State<ConfirmAddressScreen> createState() => _ConfirmAddressScreenState();
}

class _ConfirmAddressScreenState extends State<ConfirmAddressScreen> {
  int addressGroupValue = 0;
  List<PaymentMethod> paymentMethods = [
    PaymentMethod(
        icon: 'assets/images/visa.png', selectedPayment: false, name: 'Visa'),
    PaymentMethod(
        icon: 'assets/images/paypal.png',
        selectedPayment: false,
        name: 'PayPal'),
    PaymentMethod(
        icon: 'assets/images/googlepay.png',
        selectedPayment: false,
        name: 'Google Pay'),
    PaymentMethod(
        icon: 'assets/images/applepay.png',
        selectedPayment: false,
        name: 'Apple Pay'),
  ];
  int selectedPayment = 0;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);
    final dw = MediaQuery.of(context).size.width;
    final userProvider = Provider.of<UserProvider>(context);
    final userProviderModdable =
        Provider.of<UserProvider>(context, listen: false);
    createOrder() {
      print('object');
      Provider.of<OrderDetailsProvider>(context, listen: false)
          .generateOrder(cartProvider);
      print(Provider.of<OrderDetailsProvider>(context, listen: false).orders);
    }

    final containers = userProvider.user.addresses.length;

    return Scaffold(
      appBar: AppBar(  shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: const Color.fromARGB(217, 24, 143, 121),
        elevation: 0,
        title: const Text('ORDER'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              height: dw * 0.25,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: SvgPicture.asset('assets/images/stepper.svg')

                    /*  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  //  color: const Color.fromARGB(238, 24, 143, 121),
                                  border: Border.all(
                                    width: 0.1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0))),
                              height: 50,
                              width: 50,
                              child:Svg,
                            ),
                            const Text('Delivery')
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(238, 24, 143, 121),
                              border: Border.all(
                                width: 0.1,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0))),
                          height: 50,
                          width: 50,
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(238, 24, 143, 121),
                              border: Border.all(
                                width: 0.1,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0))),
                          height: 50,
                          width: 50,
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        )
                      ]), */
                    ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                  'Total :  ${Provider.of<Cart>(context, listen: false).total.toStringAsFixed(2)}'),
            ),
            TitleText(button: false, title: 'Address'),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  border:
                      Border.all(width: 1.0, color: const Color(0xffadadad)),
                  borderRadius: const BorderRadius.all(Radius.circular(6.0))),
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              height: dw * 0.25,
              child: Stack(children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Color(0xffADB3BC),
                    ),
                    onPressed: () => push(context, NamedRoute.adressesScreen),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: dw * 0.1,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            userProvider.user
                                .addresses[userProvider.selectedAddress].city,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                          ),
                          child: Text(
                            userProvider.user.number.toString(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 154, 160, 168)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 6),
                          child: Text(
                            '${userProvider.user.addresses[userProviderModdable.selectedAddress].city.toUpperCase()} ${userProvider.user.addresses[userProviderModdable.selectedAddress].pincode}',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 165, 170, 178)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: dw,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: dw * 0.5,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24.0))),
                    child: ElevatedButton(
                      onPressed: () =>
                          push(context, NamedRoute.newAddressScreen),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(238, 24, 143, 121),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.green)))),
                      child: Row(
                        children: const [
                          Text(
                            'Add New',
                            style: TextStyle(fontSize: 12),
                          ),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TitleText(button: false, title: 'Payment Method'),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  border:
                      Border.all(width: 1.0, color: const Color(0xffadadad)),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0))),
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              height: dw * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.delivery_dining_outlined,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      'Cash On Delivery',
                      style: GoogleFonts.lato(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            /*   Container(
              height: paymentMethods.length * (dw * 0.17),
              width: dw,
              decoration: BoxDecoration(
                  border:
                      Border.all(width: 1.0, color: const Color(0xffadadad)),
                  borderRadius: const BorderRadius.all(Radius.circular(6.0))),
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: paymentMethods.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: EdgeInsets.all(12.0),
                      height: dw * 0.1,
                      child: ListTile(
                        leading: Image.asset(paymentMethods[index].icon),
                        title: Text(paymentMethods[index].name),
                        trailing: Radio(
                            value: index,
                            groupValue: selectedPayment,
                            onChanged: ((value) {
                              if (value != null) {
                                selectedPayment = value;
                              }
                              setState(() {});
                            })),
                      ),
                    );
                  })),
            ), */
            const SizedBox(
              height: 150,
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(16.0),
        width: dw * 0.9,
        height: dw * 0.22,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(238, 24, 143, 121),
            ),
            child: const Text('Checkout'),
            onPressed: () {
              createOrder();

              push(context, NamedRoute.orderCreatedScreen);
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
