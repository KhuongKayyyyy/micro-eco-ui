class ProductDetailModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String? videoUrl;
  final ProductDetailBrand? brand;
  final ProductDetailCategory? category;
  final List<ProductDetailAttribute> attributes;
  final List<ProductDetailVariant> variants;
  final List<String> images;

  const ProductDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.videoUrl,
    required this.brand,
    required this.category,
    required this.attributes,
    required this.variants,
    required this.images,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    double toDouble(dynamic value) {
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0;
      return 0;
    }

    final attrsRaw = json['attributes'];
    final variantsRaw = json['variants'];
    final imagesRaw = json['images'];

    return ProductDetailModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: toDouble(json['price']),
      videoUrl: json['videoURL']?.toString(),
      brand: json['brand'] is Map<String, dynamic>
          ? ProductDetailBrand.fromJson(json['brand'])
          : null,
      category: json['category'] is Map<String, dynamic>
          ? ProductDetailCategory.fromJson(json['category'])
          : null,
      attributes: attrsRaw is List
          ? attrsRaw
                .whereType<Map<String, dynamic>>()
                .map(ProductDetailAttribute.fromJson)
                .toList()
          : const [],
      variants: variantsRaw is List
          ? variantsRaw
                .whereType<Map<String, dynamic>>()
                .map(ProductDetailVariant.fromJson)
                .toList()
          : const [],
      images: imagesRaw is List
          ? imagesRaw.map((e) => e?.toString() ?? '').where((e) => e.isNotEmpty).toList()
          : const [],
    );
  }
}

class ProductDetailBrand {
  final String id;
  final String name;
  final String image;

  const ProductDetailBrand({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ProductDetailBrand.fromJson(Map<String, dynamic> json) {
    return ProductDetailBrand(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }
}

class ProductDetailCategory {
  final String id;
  final String name;
  final String image;
  final String? parentId;

  const ProductDetailCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.parentId,
  });

  factory ProductDetailCategory.fromJson(Map<String, dynamic> json) {
    return ProductDetailCategory(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      parentId: json['parentId']?.toString(),
    );
  }
}

class ProductDetailAttribute {
  final String group;
  final String name;
  final String value;

  const ProductDetailAttribute({
    required this.group,
    required this.name,
    required this.value,
  });

  factory ProductDetailAttribute.fromJson(Map<String, dynamic> json) {
    return ProductDetailAttribute(
      group: json['group']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      value: json['value']?.toString() ?? '',
    );
  }
}

class ProductDetailVariant {
  final String name;
  final String? value;
  final String image;

  const ProductDetailVariant({
    required this.name,
    required this.value,
    required this.image,
  });

  factory ProductDetailVariant.fromJson(Map<String, dynamic> json) {
    return ProductDetailVariant(
      name: json['name']?.toString() ?? '',
      value: json['value']?.toString(),
      image: json['image']?.toString() ?? '',
    );
  }
}
