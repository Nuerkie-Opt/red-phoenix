import 'package:flutter/material.dart';

class Product {
  String name;
  List? sizes;
  List? colors;
  num price;
  num? discountPrice;
  bool discounted;
  String productImage;
  String category;
  String subCategory;
  Product(
      {required this.name,
      required this.price,
      required this.productImage,
      required this.category,
      required this.subCategory,
      this.colors,
      this.discountPrice,
      required this.discounted,
      this.sizes});
}

class SampleProductList {
  static var productList = [
    Product(
        name: 'Ripped Jeans',
        price: 30.0,
        productImage: 'assets/images/womenRippedJeans.jpg',
        category: 'women',
        subCategory: 'jeans',
        discounted: false,
        sizes: [8, 10, 12, 14, 16, 18],
        colors: ['dark blue', 'light blue', 'faded']),
    Product(
        name: 'Ripped Jeans',
        price: 30.0,
        productImage: 'assets/images/womenRippedJeans.jpg',
        category: 'women',
        subCategory: 'jeans',
        discounted: false,
        sizes: [8, 10, 12, 14, 16, 18],
        colors: ['dark blue', 'light blue', 'faded']),
    Product(
        name: 'Ripped Jeans',
        price: 30.0,
        productImage: 'assets/images/womenRippedJeans.jpg',
        category: 'women',
        subCategory: 'jeans',
        discounted: false,
        sizes: [8, 10, 12, 14, 16, 18],
        colors: ['dark blue', 'light blue', 'faded']),
    Product(
        name: 'Ripped Jeans',
        price: 30.0,
        productImage: 'assets/images/womenRippedJeans.jpg',
        category: 'women',
        subCategory: 'jeans',
        discounted: false,
        sizes: [8, 10, 12, 14, 16, 18],
        colors: ['dark blue', 'light blue', 'faded'])
  ];
}
