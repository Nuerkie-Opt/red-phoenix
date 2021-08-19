import 'package:flutter/material.dart';

class DiscountTag extends StatelessWidget {
  final num discountPercentage;
  const DiscountTag({Key? key, required this.discountPercentage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
        child: Text(
          '${discountPercentage.toString()}% OFF',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ));
  }
}
