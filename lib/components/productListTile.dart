import 'package:ecommerceproject/components/discountTag.dart';
import 'package:ecommerceproject/components/toast.dart';
import 'package:ecommerceproject/models/orderedProduct.dart';
import 'package:ecommerceproject/models/product.dart';
import 'package:ecommerceproject/providers/cartProvider.dart';
import 'package:ecommerceproject/screens/product/productPage.dart';
import 'package:ecommerceproject/services/database.dart';
import 'package:ecommerceproject/utils/globalData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return InkWell(
      onTap: () async {
        await DatabaseService(uid: GlobalData.user?.uid).recentlyViewedProducts(product);
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(product: product)));
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
                        onPressed: () {
                          OrderedProduct orderedProduct = OrderedProduct(
                              product: product,
                              quantity: 1,
                              selectedSize: product.sizes![0],
                              selectedColor: product.colors![0],
                              salePrice: product.discounted ? product.discountPrice : product.price);
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
