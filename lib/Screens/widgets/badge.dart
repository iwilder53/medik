import 'package:flutter/material.dart';
import 'package:mediq/helpers/calculate_pixels.dart';

class Badge extends StatelessWidget {
  const Badge({
    super.key,
    required this.child,
    required this.value,
    required this.color,
  });

  final Widget child;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width;
    return Container(
      height: getPixels(28, dw),
      width: getPixels(28, dw),
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
          Align(
            /* right: 0.05,
            top: 0.05, */
            alignment: Alignment.topRight,
            child: Container(
              width: getPixels(14, dw),
              //  padding: const EdgeInsets.all(2.0),
              // color: Theme.of(context).accentColor,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10.0),
                shape: BoxShape.circle,
                color: color != null ? color : Theme.of(context).accentColor,
              ),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
