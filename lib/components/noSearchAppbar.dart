import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceproject/screens/cart/cart.dart';

class SubPageAppbar extends StatelessWidget implements PreferredSizeWidget {
  const SubPageAppbar({Key? key, required this.title, required this.analytics}) : super(key: key);
  final String title;
  final FirebaseAnalytics analytics;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        title,
        style: Theme.of(context).primaryTextTheme.headline3,
      ),
      actions: [
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
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));
        //   },
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}
