import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceproject/components/noSearchAppbar.dart';
import 'package:ecommerceproject/models/order.dart';
import 'package:ecommerceproject/screens/orders/orderTab.dart';
import 'package:ecommerceproject/utils/globalData.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class OrdersHome extends StatefulWidget {
  final FirebaseAnalytics analytics;
  OrdersHome({Key? key, required this.analytics}) : super(key: key);

  @override
  _OrdersHomeState createState() => _OrdersHomeState();
}

class _OrdersHomeState extends State<OrdersHome> {
  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance.collection('orders');
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: SubPageAppbar(
              title: 'Orders',
              analytics: widget.analytics,
            ),
            body: StreamBuilder<QuerySnapshot>(
                stream: collection.where("id", whereIn: ["${GlobalData.user.email}"]).snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                  if (snapshot.hasData) {
                    var output = snapshot.data?.docs.map((doc) => doc.data()).toList();
                    if (output != null) {
                      print(output);

                      List<Order> orders = (output as List).map((item) => Order.fromMap(item)).toList();
                      //print(orders);
                      return Padding(
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
                                ]),
                            Expanded(
                              child: TabBarView(children: [
                                OrderTab(orders: orders),
                                OrderTab(orders: orders.where((element) => element.status == 'completed').toList()),
                                OrderTab(orders: orders.where((element) => element.status != 'completed').toList())
                              ]),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }
                  return Center(child: CircularProgressIndicator());
                })));
  }
}
