import 'package:ecommerceproject/models/order.dart';
import 'package:ecommerceproject/models/orderedProduct.dart';
import 'package:ecommerceproject/models/userAddress.dart';
import 'package:ecommerceproject/services/database.dart';
import 'package:ecommerceproject/utils/globalData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Orders with ChangeNotifier {
  static List<Order> madeOrders = [];
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<OrderedProduct> cartProducts, UserAddress address, num deliveryFee, double total) async {
    final timeStamp = DateTime.now();
    try {
      _orders.insert(
          0,
          Order(
              id: '${GlobalData.user?.email}- $timeStamp',
              userAddress: address,
              amount: total,
              date: timeStamp,
              deliveryFee: deliveryFee,
              status: 'awaitingPayment',
              products: cartProducts));
      await DatabaseService(uid: GlobalData.user?.email).saveOrder(_orders[0]);
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
