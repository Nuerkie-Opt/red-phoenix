import 'package:ecommerceproject/models/order.dart';
import 'package:ecommerceproject/models/paymentMode.dart';
import 'package:ecommerceproject/models/userAddress.dart';
import 'package:ecommerceproject/models/userInfo.dart';
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

  Future<void> addOrder(List<String> cartProducts, UserAddress address, UserData userData, num deliveryFee,
      double total, String name, String phoneNumber, PaymentDetails paymentDetails) async {
    final timeStamp = DateTime.now();
    try {
      _orders.insert(
          0,
          Order(
              id: '${GlobalData.user?.email}',
              userData: userData,
              userAddress: address,
              amount: total,
              date: timeStamp,
              deliveryFee: deliveryFee,
              status: 'awaitingPayment',
              orderNo: GlobalData.numberOfOrders + 1,
              paymentDetails: paymentDetails.paymentDetails,
              deliveryName: name,
              phoneNumber: phoneNumber,
              products: cartProducts));
      await DatabaseService(uid: "${GlobalData.user?.email}-${GlobalData.numberOfOrders + 1 ?? 1}")
          .saveOrder(_orders[0]);
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
