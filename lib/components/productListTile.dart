import 'package:ecommerceproject/models/product.dart';
import 'package:flutter/material.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
            //color: Color(0xFFF5D4DA),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Image.asset(product.productImage),
            Text(product.name),
            Text('GHS ${product.price.toString()}'),
          ],
        ),
      ),
    );
  }
}
