import 'dart:convert';

class Product {
  String name;
  List? sizes;
  List? colors;
  num price;
  num discountPrice;
  num serialNumber;
  bool discounted;
  String productImage;
  String category;
  String subCategory;
  String? description;
  num quantity;
  num costPrice;
  bool descriptionAvailable;
  Product(
      {required this.name,
      required this.price,
      required this.productImage,
      required this.category,
      required this.subCategory,
      required this.serialNumber,
      this.colors,
      required this.discountPrice,
      required this.discounted,
      required this.quantity,
      this.description,
      required this.descriptionAvailable,
      required this.costPrice,
      this.sizes});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sizes': sizes,
      'colors': colors,
      'price': price,
      'discountPrice': discountPrice,
      'serialNumber': serialNumber,
      'discounted': discounted,
      'productImage': productImage,
      'category': category,
      'subCategory': subCategory,
      'description': description,
      'descriptionAvailable': descriptionAvailable,
      'quantity': quantity,
      'costPrice': costPrice
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        name: map['name'],
        sizes: (map['sizes'] as List).map((e) => e as int).toList(),
        colors: (map['colors'] as List).map((e) => e as String).toList(),
        price: map['price'],
        discountPrice: map['discountPrice'],
        serialNumber: map['serialNumber'],
        discounted: map['discounted'],
        productImage: map['productImage'],
        category: map['category'],
        subCategory: map['subCategory'],
        description: map['description'],
        quantity: map['quantity'],
        costPrice: map['costPrice'],
        descriptionAvailable: map['descriptionAvailable']);
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));
}
