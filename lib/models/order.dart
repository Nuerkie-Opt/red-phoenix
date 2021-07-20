import 'package:ecommerceproject/models/product.dart';
import 'package:ecommerceproject/models/userAddress.dart';

class Order {
  Map<Product, int> products;
  num price;
  UserAddress userAddress;
  Order({required this.products, required this.price, required this.userAddress});
}
