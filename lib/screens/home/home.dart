import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceproject/components/productListTile.dart';
import 'package:ecommerceproject/models/product.dart';
import 'package:ecommerceproject/utils/globalData.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceproject/components/appBarWithSearch.dart';
import 'package:ecommerceproject/providers/productsProvider.dart';

class Home extends StatefulWidget {
  final FirebaseAnalytics analytics;
  Home({Key? key, required this.analytics}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool? recentProducts;
  TextEditingController otpController = TextEditingController();
  String? referenceCode;
  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance.collection('users');
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height * 0.8) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: SearchAppbar(
        text: 'Home',
        analytics: widget.analytics,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance.collection('banners').doc('discount').snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                  if (snapshot.hasData) {
                    var output = snapshot.data!.data();
                    var value = output!['images'];
                    List<String> carouselImages = List<String>.from(value);
                    return Container(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                        items: imageSliders(carouselImages),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            SizedBox(
              height: 30,
            ),
            Text(
              'Recently Viewed',
              style: Theme.of(context).primaryTextTheme.headline2,
            ),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: collection.doc(GlobalData.user?.uid).snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                  if (snapshot.hasData) {
                    var output = snapshot.data!.data();
                    var value = output!['recentProducts'];
                    GlobalData.numberOfOrders = output['numberOfOrders'] ?? 0;
                    if (value != null) {
                      List<Product> recentProducts = (value as List).map((item) => Product.fromJson(item)).toList();
                      return GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: recentProducts.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: (itemWidth / itemHeight)),
                          itemBuilder: (context, index) {
                            return ProductGridTile(
                              product: recentProducts[index],
                              analytics: widget.analytics,
                            );
                          });
                    } else {
                      List<Product> recentProducts = Products.productsList!.getRange(0, 4).toList();
                      return GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: recentProducts.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: (itemWidth / itemHeight)),
                          itemBuilder: (BuildContext context, int index) {
                            return ProductGridTile(
                              product: recentProducts[index],
                              analytics: widget.analytics,
                            );
                          });
                    }
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}

List<Widget> imageSliders(List<String> imgList) {
  return imgList
      .map((item) => Container(
            child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
                )),
          ))
      .toList();
}

class HomeItem {
  final IconData icon;
  final String title;

  HomeItem(this.icon, this.title);
}
