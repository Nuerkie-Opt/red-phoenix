class Category {
  String name;
  List subCategories;
  Category({required this.name, required this.subCategories});
}

class SampleCategory {
  static var categories = <Category>[
    Category(name: 'Women', subCategories: <String>[
      'Dresses',
      'Shorts',
      'T-shirts',
      'Shirts',
      'Lingerie',
      'Skirts',
      'Jeans',
      'Trousers',
      'Suits'
    ]),
    Category(
        name: 'Men',
        subCategories: <String>['T-shirts', 'Shirts', 'Jeans', 'Underwear', 'Shorts', 'Trousers', 'Suits']),
    Category(name: 'Accessories', subCategories: <String>['Hats', 'Neckties', 'Sunglasses']),
    Category(name: 'Jewellry', subCategories: <String>['Necklace', 'Earrings', 'Rings', 'Anklets']),
    Category(name: 'Kids', subCategories: <String>['Clothes', 'Shoes', 'Accessories']),
  ];
}
