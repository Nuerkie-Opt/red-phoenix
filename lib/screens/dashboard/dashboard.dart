import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:ecommerceproject/models/category.dart';
import 'package:ecommerceproject/screens/account/account_home.dart';
import 'package:ecommerceproject/screens/categories/categories_home.dart';
import 'package:ecommerceproject/screens/home/home.dart';
import 'package:ecommerceproject/screens/orders/orders_home.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _page = 0;
  List<Widget> _mainPages() => [
        Home(),
        CategoriesHome(
          categories: SampleCategory.categories,
        ),
        OrdersHome(),
        AccountHome()
      ];

  void onPageSelected(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> mainPages = _mainPages();
    return Scaffold(
      extendBody: true,
      body: mainPages[_page],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: DotNavigationBar(
            currentIndex: _page,
            onTap: onPageSelected,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Color(0xFF484848),
            backgroundColor: Colors.white,
            dotIndicatorColor: Colors.transparent,
            items: [
              DotNavigationBarItem(
                icon: Icon(Icons.home, size: 30),
              ),
              DotNavigationBarItem(
                icon: Icon(Icons.category, size: 30),
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
