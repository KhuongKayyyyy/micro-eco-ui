class ArticleModel {
  final String id;
  final String name;
  final String image;
  final String link;
  final String publishedAt;
  final String categoryId;

  const ArticleModel({
    required this.id,
    required this.name,
    required this.image,
    required this.link,
    required this.publishedAt,
    required this.categoryId,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      link: json['link']?.toString() ?? '',
      publishedAt: json['publishedAt']?.toString() ?? '',
      categoryId: json['categoryId']?.toString() ?? '',
    );
  }
}
