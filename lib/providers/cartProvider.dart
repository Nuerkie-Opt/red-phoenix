import 'package:ecommerceproject/models/orderedProduct.dart';
import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  Map<String, OrderedProduct> _items = {};

  Map<String, OrderedProduct> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(OrderedProduct product) {
    if (_items.containsKey(product.product.serialNumber)) {
      _items.update(
          product.product.serialNumber.toString(),
          (existingCartItem) => OrderedProduct(
              product: existingCartItem.product,
              selectedSize: existingCartItem.selectedSize,
              selectedColor: existingCartItem.selectedColor,
              quantity: existingCartItem.quantity + 1,
              salePrice: existingCartItem.salePrice));
    } else {
      _items.putIfAbsent(
          product.product.serialNumber.toString(),
          () => OrderedProduct(
              product: product.product,
              selectedSize: product.selectedSize,
              selectedColor: product.selectedColor,
              quantity: product.quantity,
              salePrice: product.salePrice));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id]!.quantity > 1) {
      _items.update(
          id,
          (existingCartItem) => OrderedProduct(
              product: existingCartItem.product,
              selectedSize: existingCartItem.selectedSize,
              selectedColor: existingCartItem.selectedColor,
              quantity: existingCartItem.quantity - 1,
              salePrice: existingCartItem.salePrice));
    }
    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.salePrice * cartItem.quantity;
    });
    return total;
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
