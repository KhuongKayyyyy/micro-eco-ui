class ProductModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  final double discountPrice;
  final double rating;
  final int reviewsCount;
  final String category;
  final String subCategory;
  final String brand;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.discountPrice,
    required this.rating,
    required this.reviewsCount,
    required this.category,
    required this.subCategory,
    required this.brand,
  });
}
