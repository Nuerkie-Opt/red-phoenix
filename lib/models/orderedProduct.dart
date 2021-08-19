import 'dart:convert';

import 'package:ecommerceproject/models/product.dart';

class OrderedProduct {
  Product product;
  String? selectedColor;
  int quantity;
  int? selectedSize;
  num salePrice;
  OrderedProduct(
      {required this.product,
      this.selectedColor,
      required this.quantity,
      required this.selectedSize,
      required this.salePrice});

  OrderedProduct copyWith({Product? product, String? selectedColor, int? quantity, int? selectedSize, num? salePrice}) {
    return OrderedProduct(
        product: product ?? this.product,
        selectedColor: selectedColor ?? this.selectedColor,
        quantity: quantity ?? this.quantity,
        selectedSize: selectedSize ?? this.selectedSize,
        salePrice: salePrice ?? this.salePrice);
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'selectedColor': selectedColor,
      'quantity': quantity,
      'selectedSize': selectedSize,
      'salePrice': salePrice
    };
  }

  factory OrderedProduct.fromMap(Map<String, dynamic> map) {
    return OrderedProduct(
        product: Product.fromMap(map['product']),
        selectedColor: map['selectedColor'],
        quantity: map['quantity'],
        selectedSize: map['selectedSize'],
        salePrice: map['salePrice']);
  }

  String toJson() => json.encode(toMap());

  factory OrderedProduct.fromJson(String source) => OrderedProduct.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderedProduct(product: $product, color: $selectedColor, quantity: $quantity, size: $selectedSize,salePrice: $salePrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderedProduct &&
        other.product == product &&
        other.selectedColor == selectedColor &&
        other.quantity == quantity &&
        other.selectedSize == selectedSize &&
        other.salePrice == salePrice;
  }

  @override
  int get hashCode {
    return product.hashCode ^ selectedColor.hashCode ^ quantity.hashCode ^ selectedSize.hashCode ^ salePrice.hashCode;
  }
}
