import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceproject/models/product.dart';

class GetProducts {
  static Stream<List<Product>>? products;

  static Stream<List<Product>> getProducts() {
    var result = FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .map((query) => query.docs.map((e) => Product.fromMap(e.data())).toList());

    products = result;
    print(products?.toList());
    return result;
  }
}
