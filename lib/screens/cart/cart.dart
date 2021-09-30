import 'package:ecommerceproject/components/cartProduct.dart';
import 'package:ecommerceproject/components/toast.dart';
import 'package:ecommerceproject/screens/cart/orderDetails.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceproject/providers/cartProvider.dart';

class CartPage extends StatefulWidget {
  final FirebaseAnalytics analytics;
  CartPage({Key? key, required this.analytics}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            Text(
              'My Cart',
              style: Theme.of(context).primaryTextTheme.headline3,
            ),
            Icon(
              Icons.shopping_cart_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartProduct(orderedProduct: cart.items.values.toList()[i])),
            Positioned(
                bottom: 0.0,
                right: 0.0,
                left: 0.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            minimumSize: Size.fromHeight(50),
                          ),
                          onPressed: () {
                            cart.totalAmount <= 0
                                ? showToastMessage('Please add some items')
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderDetails(
                                              analytics: widget.analytics,
                                            )));
                          },
                          child: Text(
                            'Checkout',
                            style: Theme.of(context).primaryTextTheme.headline3,
                          ),
                        )),
                        Expanded(
                          child: Column(
                            children: [
                              Text('Total:'),
                              Text(
                                'GHS: ${cart.totalAmount}',
                                style: Theme.of(context).primaryTextTheme.headline1,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
