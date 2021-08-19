import 'package:ecommerceproject/models/orderedProduct.dart';
import 'package:flutter/material.dart';

class CartProduct extends StatelessWidget {
  final OrderedProduct orderedProduct;
  const CartProduct({Key? key, required this.orderedProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListTile(
      leading: Image.network(orderedProduct.product.productImage),
      title: Text(
        orderedProduct.product.name,
        style: Theme.of(context).primaryTextTheme.headline2,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quantity: ${orderedProduct.quantity.toString()}',
            style: TextStyle(color: Color(0xFF484848), fontSize: 12),
          ),
          Text(
            'Colour: ${orderedProduct.selectedColor.toString()}',
            style: TextStyle(color: Color(0xFF484848), fontSize: 12),
          ),
          Text(
            'Size: ${orderedProduct.selectedSize.toString()}',
            style: TextStyle(color: Color(0xFF484848), fontSize: 12),
          )
        ],
      ),
      trailing: Text(
        'GHS ${orderedProduct.salePrice.toString()}',
        style: Theme.of(context).primaryTextTheme.headline1,
      ),
    ));
  }
}
