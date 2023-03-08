// ignore_for_file: camel_case_types

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediq/helpers/calculate_pixels.dart';
import 'package:mediq/models/cart.dart';
import 'package:mediq/navigation/navigators.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';

class CartProductsWidget extends StatelessWidget {
  final CartItem product;
  final int index;
  const CartProductsWidget(
      {required this.index, required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: const BorderRadius.all(Radius.circular(6.0))),
      width: getPixels(334, dw),
      height: getPixels(102, dw),
      child: Stack(
        children: [
          Positioned(
            top: 0.0,
            left: 0.0,
            child: IconButton(
                splashRadius: 1,
                onPressed: () =>
                    Provider.of<Cart>(context, listen: false).removeItem(index),
                icon: SvgPicture.asset(
                  'assets/images/delete.svg',
                  color: Colors.red,
                )),
          ),
          Positioned(
            left: getPixels(52, dw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  product.imageUrl,
                  height: getPixels(48, dw),
                  width: getPixels(48, dw),
                ),
                SizedBox(
                  width: getPixels(42, dw),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: getPixels(16, dw)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: getPixels(4, dw), bottom: getPixels(8, dw)),
                        child: Text(
                          product.medicince.cover == 'tabs'
                              ? product.medicince.selectedCount!.toString()
                              : product.medicince.quantity.toString(),
                          style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xffADADAD)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                Provider.of<Cart>(context, listen: false)
                                    .decreaseQuantity(index),
                            child: Container(
                                constraints: const BoxConstraints(
                                    maxHeight: 20,
                                    minHeight: 18,
                                    maxWidth: 20,
                                    minWidth: 18),
                                padding: const EdgeInsets.only(bottom: 0.0),
                                child: Image.asset(
                                  'assets/images/minus.png',
                                )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              product.quantity.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          IconButton(
                              constraints: const BoxConstraints(
                                  maxHeight: 20,
                                  minHeight: 18,
                                  maxWidth: 20,
                                  minWidth: 18),
                              padding: const EdgeInsets.all(2.0),
                              splashRadius: 2,
                              onPressed: () =>
                                  Provider.of<Cart>(context, listen: false)
                                      .increaseQuantity(index),
                              icon: Image.asset('assets/images/plus.png'))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '₹${(double.parse(product.price) * product.quantity).toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            top: getPixels(0, dw),
            right: getPixels(0, dw),
            child: product.medicince.cover == 'tabs'
                ? IconButton(
                    splashRadius: 1,
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      product.medicince.cover == 'tabs'
                          ? bottomModalMedicineQuantity(context, dw)
                          : null;
                    },
                    icon: SvgPicture.asset(
                      'assets/images/edit.svg',
                      height: getPixels(18, dw),
                      color: Colors.blueGrey,
                      width: getPixels(18, dw),
                    ) /* const Icon(
                Icons.edit,
                color: Color.fromARGB(105, 173, 173, 173),
              ), */
                    )
                : SizedBox(),
          ),
        ],
      ),
    );
  }

  Future<void> bottomModalMedicineQuantity(BuildContext context, double dw) {
    return showModalBottomSheet<void>(
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            height: getPixels(200, dw),
            child: Stack(children: [
              Align(
                alignment: Alignment.topRight,
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
                    pop(context);
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: dw * 0.07,
                  ),
                  SizedBox(
                    // width: getPixels(100, dw),
                    height: getPixels(16, dw),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            ' ${product.title}',
                            style: GoogleFonts.lato(
                                color: const Color(0xff958A8A),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          width: getPixels(8, dw),
                        ),
                        Text(
                          ' ${product.medicince.selectedCount}',
                          style: GoogleFonts.lato(
                              fontSize: 10,
                              color: const Color(0xff958A8A),
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          ' in a ${product.medicince.selectedCategory}',
                          style: GoogleFonts.lato(
                              fontSize: 10,
                              color: const Color(0xff958A8A),
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 2, bottom: 8),
                    child: Text(
                      'Fill according to your Requirement.',
                      style: GoogleFonts.lato(
                          fontSize: 14, fontWeight: FontWeight.w600),
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
                  padding: const EdgeInsets.all(13.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.resolveWith((states) =>
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => const Color(0xff1892FA))),
                      onPressed: () => pop(context),
                      child: const Text('Save')),
                ),
              )
            ]),
          );
        });
  }
}

class quantityButtons extends StatefulWidget {
  const quantityButtons({
    Key? key,
    required this.dw,
    required this.index,
    required this.product,
  }) : super(key: key);
  final double dw;
  final int index;
  final CartItem product;

  @override
  State<quantityButtons> createState() => _quantityButtonsState();
}

class _quantityButtonsState extends State<quantityButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: Text(
                'Quantity',
                textAlign: TextAlign.start,
                style: GoogleFonts.lato(
                    fontSize: 14,
                    color: const Color(0xff958A8A),
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              alignment: Alignment.centerRight,
              width: widget.dw * 0.25,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints.tight(Size(
                      getPixels(30, widget.dw),
                      getPixels(30, widget.dw),
                    )),
                    child: RawMaterialButton(
                        padding: const EdgeInsets.all(2.0),
                        onPressed: () {
                          Provider.of<Cart>(context, listen: false)
                              .decreaseQuantity(widget.index);
                          setState(() {});
                        },
                        child: Container(
                            width: getPixels(38, widget.dw),
                            height: getPixels(38, widget.dw),
                            decoration: const BoxDecoration(
                                color: Color(0xff199A8E),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(150))),
                            child: Image.asset(
                              'assets/images/minus.png',
                              color: Colors.white,
                              //  height: 6,
                              // width: 6,
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.product.quantity.toString(),
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ),
                  Container(
                      constraints: BoxConstraints.tight(Size(
                        getPixels(26, widget.dw),
                        getPixels(26, widget.dw),
                      )),
                      child: RawMaterialButton(
                        onPressed: () {
                          Provider.of<Cart>(context, listen: false)
                              .increaseQuantity(widget.index);
                          setState(() {});
                        },
                        fillColor: Color(0xff199A8E),
                        child: Icon(
                          Icons.add,
                          size: 18.0,
                          color: Colors.white,
                        ),
                        shape: CircleBorder(),
                      )),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 22.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Strip/Tab',
              textAlign: TextAlign.start,
              style: GoogleFonts.lato(
                  fontSize: 14,
                  color: const Color(0xff958A8A),
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  border:
                      Border.all(width: 0.5, color: const Color(0xff958A8A))),
              height: widget.dw * 0.08,
              width: getPixels(
                  widget.product.medicince.selectedCategory!.length * 12,
                  widget.dw), // widget.dw * 0.21,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  iconSize: 16,
                  style: GoogleFonts.lato(
                      fontSize: 12, fontWeight: FontWeight.w500),
                  borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                  isExpanded: true,
                  value: widget.product.medicince.selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      widget.product.medicince.selectedCategory = newValue!;
                    });
                  },
                  items: widget.product.medicince.categories!.map((items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          widget.product.quantity > 1 ? '${items}s' : items,
                          style: GoogleFonts.inter(
                              fontSize: 12, color: Colors.black),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
