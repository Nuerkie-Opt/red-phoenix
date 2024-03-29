import 'package:ecommerceproject/components/discountTag.dart';
import 'package:ecommerceproject/components/toast.dart';
import 'package:ecommerceproject/models/orderedProduct.dart';
import 'package:ecommerceproject/models/product.dart';
import 'package:ecommerceproject/providers/cartProvider.dart';
import 'package:ecommerceproject/screens/product/productPage.dart';
import 'package:ecommerceproject/services/database.dart';
import 'package:ecommerceproject/utils/globalData.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile({Key? key, required this.product, required this.analytics}) : super(key: key);

  final Product product;
  final FirebaseAnalytics analytics;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return InkWell(
      onTap: () async {
        await DatabaseService(uid: GlobalData.user?.uid).recentlyViewedProducts(product);
        await analytics.logViewItem(
          itemId: '${product.serialNumber}',
          itemName: '${product.name}',
          itemCategory: '${product.category} - ${product.subCategory}',
          price: product.discounted ? product.discountPrice.toDouble() : product.price.toDouble(),
          currency: 'GHS',
          value: 67.8,
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductPage(
                      product: product,
                      analytics: analytics,
                    )));
      },
      child: Card(
        elevation: 10,
        shadowColor: Color(0x29888888),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: 600,
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Image.network(
                    product.productImage,
                  )),
              Visibility(
                  visible: product.discounted,
                  child: DiscountTag(
                      discountPercentage: (((product.price - product.discountPrice) / product.price) * 100).round())),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(child: Text(product.name)),
                      Text(
                        'GHS ${product.price.toString()}',
                        style: Theme.of(context).primaryTextTheme.headline2,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () async {
                          OrderedProduct orderedProduct = OrderedProduct(
                              product: product,
                              quantity: 1,
                              selectedSize: product.sizes![0],
                              selectedColor: product.colors![0],
                              salePrice: product.discounted ? product.discountPrice : product.price);
                          await analytics.logAddToCart(
                            currency: 'GHS',
                            itemId: '${product.serialNumber}',
                            itemName: '${product.name}',
                            itemCategory: '${product.category} - ${product.subCategory}',
                            quantity: 1,
                            price: product.discounted ? product.discountPrice.toDouble() : product.price.toDouble(),
                            origin: 'test origin',
                          );
                          cart.addItem(orderedProduct);
                          showToastMessage("Item added to cart");
                        },
                        icon: Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Theme.of(context).primaryColor,
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
