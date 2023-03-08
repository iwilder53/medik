import 'dart:async';
import 'package:flutter/material.dart';


class ShopAddressInputPage extends StatefulWidget {

  ShopAddressInputPage({Key? key,});

  @override
  _ShopAddressInputPageState createState() => _ShopAddressInputPageState();
}

class _ShopAddressInputPageState extends State<ShopAddressInputPage> {
 

  @override
  Widget build(BuildContext context) {
    var heightDimen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: heightDimen,
          ),
        ],
      ),
    );
  }
}
