class BrandModel {
  final String id;
  final String name;
  final String image;

  BrandModel({required this.id, required this.name, required this.image});
  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(id: json['id'], name: json['name'], image: json['image']);
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image};
  }

  @override
  String toString() {
    return 'BrandModel(id: $id, name: $name, image: $image)';
  }

  static final List<BrandModel> mockBrands = [
    BrandModel(id: '1', name: 'Apple', image: 'assets/images/apple.png'),
    BrandModel(id: '2', name: 'Samsung', image: 'assets/images/samsung.png'),
    BrandModel(id: '3', name: 'Google', image: 'assets/images/google.png'),
  ];
}
