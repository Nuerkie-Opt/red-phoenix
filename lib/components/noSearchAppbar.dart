import 'package:flutter/material.dart';
import 'package:ecommerceproject/screens/cart/cart.dart';
import 'package:ecommerceproject/screens/notifications/notification.dart';

class SubPageAppbar extends StatelessWidget implements PreferredSizeWidget {
  const SubPageAppbar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        title,
        style: Theme.of(context).primaryTextTheme.headline3,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart_sharp, color: Colors.white),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
          },
        ),
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Notifications()));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}
