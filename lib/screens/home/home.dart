import 'package:ecommerceproject/components/productListTile.dart';
import 'package:ecommerceproject/models/product.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceproject/components/appBarWithSearch.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List menuList = [
    HomeItem(Icons.verified_user, "Men's Clothes"),
    HomeItem(Icons.autorenew, "Women's Clothes"),
    HomeItem(Icons.ac_unit, "Shoes"),
    HomeItem(Icons.center_focus_strong, "Jewellry"),
    HomeItem(Icons.question_answer, "Accessories"),
    HomeItem(Icons.phone, "Kids"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppbar(
        text: 'Home',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.all(5.0),
                      child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    menuList[index].icon,
                                    size: 30,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  menuList[index].title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(),
                                ),
                              )
                            ],
                          )));
                },
                itemCount: menuList.length,
              ),
            ),
            Text(
              'Recently Viewed',
              style: Theme.of(context).primaryTextTheme.headline2,
            ),
            Container(
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: SampleProductList.productList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return ProductGridTile(product: SampleProductList.productList[index]);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class HomeItem {
  final IconData icon;
  final String title;

  HomeItem(this.icon, this.title);
}
