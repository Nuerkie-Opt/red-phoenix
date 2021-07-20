import 'package:ecommerceproject/components/noSearchAppbar.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class OrdersHome extends StatefulWidget {
  OrdersHome({Key? key}) : super(key: key);

  @override
  _OrdersHomeState createState() => _OrdersHomeState();
}

class _OrdersHomeState extends State<OrdersHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: SubPageAppbar(
            title: 'Orders',
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                TabBar(
                    labelStyle: Theme.of(context).primaryTextTheme.headline1,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: MaterialIndicator(
                        color: Theme.of(context).primaryColor,
                        topLeftRadius: 10,
                        topRightRadius: 10,
                        height: 4,
                        tabPosition: TabPosition.bottom),
                    tabs: [
                      Tab(
                        text: 'All',
                      ),
                      Tab(
                        text: 'Delivered',
                      ),
                      Tab(
                        text: 'Pending',
                      )
                    ])
              ],
            ),
          )),
    );
  }
}
