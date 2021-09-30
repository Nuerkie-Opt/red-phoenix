import 'package:ecommerceproject/models/orderedProduct.dart';
import 'package:ecommerceproject/providers/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatelessWidget {
  final OrderedProduct orderedProduct;
  const CartProduct({Key? key, required this.orderedProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Container(
        child: Column(
      children: [
        ListTile(
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
        ),
        TextButton(
            onPressed: () {
              cart.removeItem(orderedProduct.product.serialNumber.toString());
            },
            child: Row(
              children: [
                Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                SizedBox(width: 5),
                Text("Remove", style: TextStyle(color: Colors.red))
              ],
            ))
      ],
    ));
  }
}
