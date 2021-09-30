import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:ecommerceproject/models/category.dart';
import 'package:ecommerceproject/models/product.dart';
import 'package:ecommerceproject/providers/productsProvider.dart';
import 'package:ecommerceproject/screens/account/account_home.dart';
import 'package:ecommerceproject/screens/categories/categories_home.dart';
import 'package:ecommerceproject/screens/home/home.dart';
import 'package:ecommerceproject/screens/orders/orders_home.dart';
import 'package:ecommerceproject/services/auth.dart';
import 'package:ecommerceproject/services/database.dart';
import 'package:ecommerceproject/utils/globalData.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final FirebaseAnalytics analytics;
  Dashboard({Key? key, required this.analytics}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _page = 0;
  List<Widget> _mainPages() => [
        Home(
          analytics: widget.analytics,
        ),
        CategoriesHome(
          categories: SampleCategory.categories,
          analytics: widget.analytics,
        ),
        OrdersHome(analytics: widget.analytics),
        AccountHome(
          analytics: widget.analytics,
        )
      ];

  void onPageSelected(int index) {
    setState(() {
      _page = index;
    });
  }

  final AuthService _auth = AuthService();
  getUserDetails() async {
    await _auth.getUserData();
    await DatabaseService(uid: GlobalData.user?.uid).setLastSeen();
    print(GlobalData.user.toString());
  }

  @override
  void initState() {
    getUserDetails();
    //GetProducts.getProducts();
    // GetData.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> mainPages = _mainPages();
    return Scaffold(
      extendBody: true,
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("products").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return Center(child: Text('Something went wrong'));
            var output = snapshot.data?.docs.map((doc) => doc.data()).toList();
            Products.productsList = (output as List).map((item) => Product.fromMap(item)).toList();

            return mainPages[_page];
          }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: DotNavigationBar(
            itemPadding: EdgeInsets.all(10),
            enableFloatingNavBar: true,
            currentIndex: _page,
            onTap: onPageSelected,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white30,
            backgroundColor: Theme.of(context).primaryColor,
            dotIndicatorColor: Colors.transparent,
            items: [
              DotNavigationBarItem(
                icon: Icon(Icons.home, size: 30),
              ),
              DotNavigationBarItem(
                icon: Icon(Icons.dashboard, size: 30),
              ),
              DotNavigationBarItem(
                icon: Icon(Icons.assignment_rounded, size: 30),
              ),
              DotNavigationBarItem(
                icon: Icon(Icons.person, size: 30),
              )
            ]),
      ),
    );
  }
}
