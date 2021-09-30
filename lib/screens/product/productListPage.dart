import 'package:ecommerceproject/components/noSearchAppbar.dart';
import 'package:ecommerceproject/components/productListTile.dart';
import 'package:ecommerceproject/models/product.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  final List<Product> productList;
  final String productSubCategory;
  final FirebaseAnalytics analytics;
  ProductList({Key? key, required this.productList, required this.productSubCategory, required this.analytics})
      : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height * 0.8) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
        appBar: SubPageAppbar(
          title: widget.productSubCategory,
          analytics: widget.analytics,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
              itemCount: widget.productList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: (itemWidth / itemHeight)),
              itemBuilder: (context, index) {
                return ProductGridTile(product: widget.productList[index], analytics: widget.analytics);
              }),
        ));
  }
}
