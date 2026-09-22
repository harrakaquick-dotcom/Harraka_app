class Product {
  const Product({
    required this.id,
    required this.name,
    required this.pack,
    required this.price,
    required this.mrp,
    required this.category,
    required this.brand,
    required this.eta,
    required this.isVeg,
  });

  final String id;
  final String name;
  final String pack;
  final int price;
  final int mrp;
  final String category;
  final String brand;
  final String eta;
  final bool isVeg;

  int get discountPercent => (100 - (price / mrp * 100)).round();
}
