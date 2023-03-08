import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediq/providers/order_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../widgets/billing_summary.dart';
import '../widgets/title_text.dart';

class OrderCreatedScreen extends StatelessWidget {
  const OrderCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<Cart>(context);

    final orderProvider = Provider.of<OrderDetailsProvider>(context).orders[0];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(238, 24, 143, 121),
        elevation: 0,
        title: const Text('Orders'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: dw * 0.275,
              width: dw,
              child: SvgPicture.asset('assets/images/delivery.svg'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Order ID: 3354654654526'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Order Date: Feb 16,2023'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Estimated Delivery: Feb 17,2023'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TitleText(button: false, title: 'Billing Summary'),
          ),
          Container(
            child: Column(children: [
              billingSummary(
                  'Subtotal', cartProvider.subTotal.toStringAsFixed(2), null),
              billingSummary('Discount',
                  '-${cartProvider.discount.toStringAsFixed(2)}', null),
              billingSummary(
                  'Shipping', cartProvider.shipping.toStringAsFixed(2), null),
              billingSummary('Tax', cartProvider.tax.toStringAsFixed(2),
                  GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w600)),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '₹${orderProvider.totalAmount}',
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
