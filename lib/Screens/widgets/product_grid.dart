// ignore_for_file: must_be_immutable

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediq/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../helpers/calculate_pixels.dart';
import '../../models/cart.dart';
import '../../models/medicine_details.dart';
import '../../navigation/navigators.dart';
import 'cart_products.dart';

class ProductGrid extends StatefulWidget {
  double dw;
  List<MedicineItemDetails> products;
  ProductGrid({required this.dw, required this.products, super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);
    return Container(
      padding: const EdgeInsets.only(left: 8.0),
      height: widget.dw * 0.44,
      width: widget.dw,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          scrollDirection: Axis.horizontal,
          itemCount: widget.products.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(right: 24.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                border: Border.all(
                    color: const Color.fromARGB(255, 232, 243, 241),
                    width: 2.0),
              ),
              height: widget.dw * 0.44,
              width: widget.dw * 0.334,
              //  color: Colors.blue,
              child: GridTile(
                header: Row(
                  children: [
                    const Spacer(),
                    Container(
                      alignment: Alignment.topRight,
                      height: widget.dw * 0.05,
                      width: widget.dw * 0.109,
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(8.0)),
                          color: Color.fromARGB(255, 125, 187, 26)),
                      child: Center(
                        child: Text(
                          '10% OFF',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: widget.dw * 0.0106,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        widget.products[index].imageUrl ?? '',
                        height: widget.dw * 0.2266,
                        width: widget.dw * 0.16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 1.0),
                            child: Text(
                              widget.products[index].itemName ?? '',
                              style: GoogleFonts.inter(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            widget.products[index].quantity ?? '',
                            style: GoogleFonts.inter(
                                height: 1.6,
                                color: const Color(0xff958A8A),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    widget.products[index].inCart
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: getPixels(6, widget.dw)),
                              height: getPixels(26, widget.dw),
                              decoration: const BoxDecoration(
                                  color: const Color(0xff199A8E),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                'Added to cart',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ))
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '₹${widget.products[index].itemMrp}',
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      //  '₹${products[index].itemMrp}',
                                      'MRP 100',

                                      style: GoogleFonts.roboto(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationStyle:
                                              TextDecorationStyle.dashed,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                        padding: const EdgeInsets.all(4),
                                        onPressed: () {
                                          setState(() {
                                            {
                                              widget.products[index]
                                                  .addToCart();
                                              cartProvider.addItem(
                                                  widget.products[index]);
                                            }
                                            if (widget.products[index].cover ==
                                                'tabs') {
                                              bottomModalMedicineQuantity(
                                                  context,
                                                  widget.dw,
                                                  cartProvider.items[0],
                                                  index);
                                              //  return;
                                            }
                                          });
                                        },
                                        icon: Icon(
                                            size: widget.dw * 0.068,
                                            Icons.add_box_rounded,
                                            color: const Color(0xff199A8E))),
                                  )
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Column dropDowns(int index) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              border: Border.all(width: 0.5, color: const Color(0xff958A8A))),
          height: widget.dw * 0.042,
          width: widget.dw * 0.264,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset(
                  'assets/images/polygon.svg',
                  height: 3,
                  width: 5,
                ),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              isExpanded: true,
              value: widget.products[index].selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  widget.products[index].selectedCategory = newValue!;
                });
              },
              items: widget.products[index].categories!.map((items) {
                return DropdownMenuItem(
                  value: items,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      items,
                      style: GoogleFonts.inter(fontSize: 10),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const Divider(height: 4),
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(width: 0.5, color: const Color(0xff958A8A))),
          height: widget.dw * 0.042,
          width: widget.dw * 0.264,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset(
                  'assets/images/polygon.svg',
                  height: 3,
                  width: 5,
                ),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              isExpanded: true,
              value: widget.products[index].selectedCount,
              onChanged: (newValue) {
                setState(() {
                  widget.products[index].selectedCount = newValue!;
                });
              },
              items: widget.products[index].count!.map((items) {
                return DropdownMenuItem(
                  value: items,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Qnt $items',
                        style: GoogleFonts.inter(fontSize: 10)),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  bottomModalMedicineQuantity(
      BuildContext context, double dw, CartItem product, int index) {
    bool isSaved = false;
    Future future = showModalBottomSheet<void>(
        //  isDismissible: false,
        shape: const RoundedRectangleBorder(
            side: BorderSide(width: 0.01),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22), topRight: Radius.circular(22))),
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: getPixels(240, dw),
            child: Stack(children: [
              Positioned(
                top: getPixels(16, dw),
                right: 2,
                child: IconButton(
                  icon: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.2,
                              color: const Color.fromARGB(255, 33, 81, 255)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(150))),
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 16.0,
                      )),
                  onPressed: () {
                    Provider.of<Cart>(context, listen: false).removeItem(0);
                    pop(context);
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: dw * 0.09,
                  ),
                  SizedBox(
                    // width: getPixels(100, dw),
                    height: getPixels(32, dw),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ' ${product.title}',
                          style: GoogleFonts.lato(
                            color: const Color(0xff958A8A),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          textHeightBehavior: TextHeightBehavior(),
                        ),
                        SizedBox(
                          width: getPixels(6, dw),
                        ),
                        Text(
                          ' ${product.medicince.selectedCount} in a ${product.medicince.selectedCategory}',
                          style: GoogleFonts.lato(
                              fontSize: 12,
                              color: const Color(0xff958A8A),
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '',
                          style: GoogleFonts.lato(
                              fontSize: 12,
                              color: const Color(0xff958A8A),
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 10), //only(top: 8.0, left: 2, bottom: 8),
                    child: Text(
                      'Fill according to your Requirement.',
                      style: GoogleFonts.lato(
                          fontSize: 16, fontWeight: FontWeight.w600),
                      //  textAlign: TextAlign.start,
                    ),
                  ),
                  const DottedLine(
                    dashColor: Colors.grey,
                    dashGapLength: 1,
                  ),
                  SizedBox(
                    height: dw * 0.03,
                  ),
                  quantityButtons(
                    index: index,
                    product: product,
                    dw: dw,
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          elevation:
                              MaterialStateProperty.resolveWith((states) => 0),
                          shape: MaterialStateProperty.resolveWith((states) =>
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => const Color(0xff1892FA))),
                      onPressed: () => {isSaved = true, pop(context)},
                      child: const Text('Save')),
                ),
              )
            ]),
          );
        });
    future.then((value) => {
          isSaved
              ? null
              : Provider.of<Cart>(context, listen: false).removeItem(0)
        });
  }
}
