import 'package:ecommerceproject/screens/cart/cart.dart';
import 'package:ecommerceproject/screens/notifications/notification.dart';
import 'package:flutter/material.dart';

class SearchAppbar extends StatelessWidget implements PreferredSizeWidget {
  SearchAppbar({
    required this.text,
  });
  final String text;
  final double height = 200;
  final TextEditingController searchController = TextEditingController();
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));
                      },
                    ),
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
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        print("your menu action here");
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
