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
      this.description,
      required this.descriptionAvailable,
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
      'descriptionAvailable': descriptionAvailable
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
        descriptionAvailable: map['descriptionAvailable']);
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));
}

class SampleProductList {
  static var productList = [
    Product(
        name: 'Ripped Jeans',
        price: 35.0,
        productImage: 'assets/images/womenRippedJeans.jpg',
        category: 'women',
        subCategory: 'jeans',
        discounted: true,
        discountPrice: 20.0,
        serialNumber: 087654,
        sizes: [8, 10, 12, 14, 16, 18],
        descriptionAvailable: true,
        description:
            'Et consectetur deserunt duis nisi esse culpa non. Exercitation velit deserunt cillum eu exercitation incididunt. Lorem laborum aute dolore dolore nostrud adipisicing enim sunt cillum nulla.Sint proident id ea sint fugiat mollit voluptate quis cillum non excepteur. Eu adipisicing reprehenderit proident pariatur ullamco est ullamco laboris occaecat magna dolore. Et culpa aliqua ad officia sunt do ut aute eiusmod.',
        colors: ['dark blue', 'light blue', 'faded']),
    Product(
        name: 'Ripped Jeans',
        price: 30.0,
        productImage: 'assets/images/womenRippedJeans.jpg',
        category: 'women',
        subCategory: 'jeans',
        serialNumber: 038373,
        discounted: false,
        discountPrice: 0.0,
        descriptionAvailable: false,
        sizes: [8, 10, 12, 14, 16, 18],
        colors: ['dark blue', 'light blue', 'faded']),
    Product(
        name: 'Ripped Jeans',
        price: 30.0,
        productImage: 'assets/images/womenRippedJeans.jpg',
        category: 'women',
        subCategory: 'jeans',
        discounted: false,
        discountPrice: 0.0,
        descriptionAvailable: false,
        serialNumber: 873333,
        sizes: [8, 10, 12, 14, 16, 18],
        colors: ['dark blue', 'light blue', 'faded']),
    Product(
        name: 'Ripped Jeans',
        price: 30.0,
        productImage: 'assets/images/womenRippedJeans.jpg',
        category: 'women',
        subCategory: 'jeans',
        discounted: false,
        discountPrice: 0.0,
        descriptionAvailable: false,
        serialNumber: 097653,
        sizes: [8, 10, 12, 14, 16, 18],
        colors: ['dark blue', 'light blue', 'faded'])
  ];
}
