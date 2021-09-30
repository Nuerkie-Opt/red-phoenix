import 'package:ecommerceproject/components/toast.dart';
import 'package:ecommerceproject/providers/productsProvider.dart';
import 'package:ecommerceproject/providers/searchProvider.dart';
import 'package:ecommerceproject/screens/cart/cart.dart';
import 'package:ecommerceproject/screens/product/productListPage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class SearchAppbar extends StatelessWidget implements PreferredSizeWidget {
  SearchAppbar({required this.text, required this.analytics});
  final String text;
  final double height = 200;
  final TextEditingController searchController = TextEditingController();
  final FirebaseAnalytics analytics;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: Theme.of(context).primaryTextTheme.headline3,
                ),
                SizedBox(width: 100),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart_sharp, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartPage(
                                      analytics: analytics,
                                    )));
                      },
                    ),
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.notifications,
                    //     color: Colors.white,
                    //   ),
                    //   onPressed: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => Notifications()));
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 80.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1.0),
                    color: Colors.white),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: "Search", border: InputBorder.none, contentPadding: EdgeInsets.all(10)),
                        onSubmitted: (value) async {
                          if (value.isNotEmpty)
                            SearchProducts.productsList =
                                Products.productsList!.where((element) => element.name.contains(value)).toList();
                          if (SearchProducts.productsList!.isNotEmpty) {
                            await analytics.logSearch(
                              searchTerm: value,
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductList(
                                          productList: SearchProducts.productsList!,
                                          productSubCategory: "Search",
                                          analytics: analytics,
                                        )));
                          } else {
                            showToastMessage("Item not found");
                          }
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        if (searchController.text.isNotEmpty)
                          SearchProducts.productsList = Products.productsList!
                              .where((element) => element.name.contains(searchController.text))
                              .toList();
                        if (SearchProducts.productsList!.isNotEmpty) {
                          await analytics.logSearch(
                            searchTerm: searchController.text,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductList(
                                        productList: SearchProducts.productsList!,
                                        productSubCategory: "Search",
                                        analytics: analytics,
                                      )));
                        } else {
                          showToastMessage("Item not found");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
