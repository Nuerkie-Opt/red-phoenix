import 'package:ecommerceproject/components/appBarWithSearch.dart';
import 'package:ecommerceproject/models/category.dart';
import 'package:ecommerceproject/models/product.dart';
import 'package:ecommerceproject/screens/product/productListPage.dart';
import 'package:flutter/material.dart';

class CategoriesHome extends StatefulWidget {
  final List<Category> categories;
  CategoriesHome({Key? key, required this.categories}) : super(key: key);

  @override
  _CategoriesHomeState createState() => _CategoriesHomeState();
}

class _CategoriesHomeState extends State<CategoriesHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchAppbar(
          text: 'Categories',
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
                                        productList: SampleProductList.productList
                                            .where((element) =>
                                                element.category == widget.categories[index].name.toLowerCase() &&
                                                element.subCategory ==
                                                    widget.categories[index].subCategories[ind].toLowerCase())
                                            .toList(),
                                        productSubCategory: widget.categories[index].subCategories[ind])));
                          },
                          title: Text(widget.categories[index].subCategories[ind]),
                        );
                      })
                ],
              );
            }));
  }
}
