import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ecommerceproject/models/orderedProduct.dart';
import 'package:ecommerceproject/models/userAddress.dart';

class Order {
  List<OrderedProduct> products;
  String id;
  DateTime date;
  num deliveryFee;
  num amount;
  UserAddress userAddress;
  String status;
  Order({
    required this.products,
    required this.id,
    required this.date,
    required this.deliveryFee,
    required this.amount,
    required this.userAddress,
    required this.status,
  });

  Order copyWith({
    List<OrderedProduct>? products,
    String? id,
    DateTime? date,
    num? deliveryFee,
    num? amount,
    UserAddress? userAddress,
    String? status,
  }) {
    return Order(
      products: products ?? this.products,
      id: id ?? this.id,
      date: date ?? this.date,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      amount: amount ?? this.amount,
      userAddress: userAddress ?? this.userAddress,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'products': products.map((x) => x.toMap()).toList(),
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'deliveryFee': deliveryFee,
      'amount': amount,
      'userAddress': userAddress.toMap(),
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      products: List<OrderedProduct>.from(map['products']?.map((x) => OrderedProduct.fromMap(x))),
      id: map['id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      deliveryFee: map['deliveryFee'],
      amount: map['amount'],
      userAddress: UserAddress.fromMap(map['userAddress']),
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(products: $products, id: $id, date: $date, deliveryFee: $deliveryFee, amount: $amount, userAddress: $userAddress, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        listEquals(other.products, products) &&
        other.id == id &&
        other.date == date &&
        other.deliveryFee == deliveryFee &&
        other.amount == amount &&
        other.userAddress == userAddress &&
        other.status == status;
  }

  @override
  int get hashCode {
    return products.hashCode ^
        id.hashCode ^
        date.hashCode ^
        deliveryFee.hashCode ^
        amount.hashCode ^
        userAddress.hashCode ^
        status.hashCode;
  }
}
