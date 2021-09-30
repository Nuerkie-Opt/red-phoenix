import 'package:ecommerceproject/components/appBarWithSearch.dart';
import 'package:ecommerceproject/models/category.dart';
import 'package:ecommerceproject/providers/productsProvider.dart';
import 'package:ecommerceproject/screens/product/productListPage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class CategoriesHome extends StatefulWidget {
  final List<Category> categories;
  final FirebaseAnalytics analytics;
  CategoriesHome({Key? key, required this.categories, required this.analytics}) : super(key: key);

  @override
  _CategoriesHomeState createState() => _CategoriesHomeState();
}

class _CategoriesHomeState extends State<CategoriesHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchAppbar(
          text: 'Categories',
          analytics: widget.analytics,
        ),
        body: ListView.builder(
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: Text(
                  widget.categories[index].name,
                  style: Theme.of(context).primaryTextTheme.headline2,
                ),
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.categories[index].subCategories.length,
                      itemBuilder: (context, ind) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductList(
                                          productList: Products.productsList!
                                              .where((element) =>
                                                  element.category == widget.categories[index].name.toLowerCase() &&
                                                  element.subCategory ==
                                                      widget.categories[index].subCategories[ind].toLowerCase())
                                              .toList(),
                                          productSubCategory: widget.categories[index].subCategories[ind],
                                          analytics: widget.analytics,
                                        )));
                          },
                          title: Text(widget.categories[index].subCategories[ind]),
                        );
                      })
                ],
              );
            }));
  }
}
