import 'dart:convert';

import 'package:ecommerceproject/models/paymentMode.dart';
import 'package:flutter/foundation.dart';

import 'package:ecommerceproject/models/userAddress.dart';
import 'package:ecommerceproject/models/userInfo.dart';

class Order {
  List<String> products;
  String id;
  int orderNo;
  DateTime date;
  num deliveryFee;
  num amount;
  UserAddress userAddress;
  String status;
  UserData userData;
  String deliveryName;
  String paymentDetails;
  String phoneNumber;
  Order(
      {required this.products,
      required this.id,
      required this.orderNo,
      required this.date,
      required this.deliveryFee,
      required this.amount,
      required this.userAddress,
      required this.status,
      required this.userData,
      required this.paymentDetails,
      required this.deliveryName,
      required this.phoneNumber});

  Order copyWith(
      {List<String>? products,
      String? id,
      int? orderNo,
      DateTime? date,
      num? deliveryFee,
      num? amount,
      UserAddress? userAddress,
      String? status,
      UserData? userData,
      String? deliveryName,
      String? paymentDetails,
      String? phoneNumber}) {
    return Order(
        products: products ?? this.products,
        id: id ?? this.id,
        orderNo: orderNo ?? this.orderNo,
        date: date ?? this.date,
        deliveryFee: deliveryFee ?? this.deliveryFee,
        amount: amount ?? this.amount,
        userAddress: userAddress ?? this.userAddress,
        status: status ?? this.status,
        userData: userData ?? this.userData,
        deliveryName: deliveryName ?? this.deliveryName,
        paymentDetails: paymentDetails ?? this.paymentDetails,
        phoneNumber: phoneNumber ?? this.phoneNumber);
  }

  Map<String, dynamic> toMap() {
    return {
      'products': products,
      'id': id,
      'orderNo': orderNo,
      'date': date.millisecondsSinceEpoch,
      'deliveryFee': deliveryFee,
      'amount': amount,
      'userAddress': userAddress.toMap(),
      'status': status,
      'userData': userData.toMap(),
      'deliveryName': deliveryName,
      'paymentDetails': paymentDetails,
      'phoneNumber': phoneNumber,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
        products: List<String>.from(map['products']),
        id: map['id'],
        orderNo: map['orderNo'],
        date: map['date'].toDate(),
        deliveryFee: map['deliveryFee'],
        amount: map['amount'],
        userAddress: UserAddress.fromJson(map['userAddress']),
        status: map['status'],
        paymentDetails: map['paymentDetails'],
        userData: UserData.fromJson(map['userData']),
        deliveryName: map['deliveryName'] ?? "",
        phoneNumber: map['phoneNumber'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(products: $products, id: $id, orderNo: $orderNo, date: $date, deliveryFee: $deliveryFee, amount: $amount, userAddress: $userAddress, status: $status, userData: $userData,deliveryName:$deliveryName,phoneNumber:$phoneNumber,paymentDetails:$paymentDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        listEquals(other.products, products) &&
        other.id == id &&
        other.orderNo == orderNo &&
        other.date == date &&
        other.deliveryFee == deliveryFee &&
        other.amount == amount &&
        other.userAddress == userAddress &&
        other.status == status &&
        other.userData == userData &&
        other.deliveryName == deliveryName &&
        other.paymentDetails == paymentDetails &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return products.hashCode ^
        id.hashCode ^
        orderNo.hashCode ^
        date.hashCode ^
        deliveryFee.hashCode ^
        amount.hashCode ^
        userAddress.hashCode ^
        status.hashCode ^
        userData.hashCode ^
        deliveryName.hashCode ^
        paymentDetails.hashCode ^
        phoneNumber.hashCode;
  }
}
