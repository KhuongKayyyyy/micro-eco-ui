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
    required this.brand,
  });

  static final List<ProductModel> mockProducts = [
    ProductModel(
      id: '1',
      name: 'Apple iPhone 14 Pro',
      description: '6.1-inch display, A16 Bionic chip, Triple camera system.',
      image:
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-14-pro-model-unselect-gallery-1-202209?wid=5120&hei=2880&fmt=jpeg&qlt=80&.v=1660753619946',
      price: 999.00,
      discountPrice: 899.00,
      rating: 4.8,
      reviewsCount: 125,
      category: 'Electronics',
      brand: 'Apple',
    ),
    ProductModel(
      id: '2',
      name: 'Samsung Galaxy Watch 5',
      description: 'Advanced fitness tracking and health monitoring watch.',
      image:
          'https://images.samsung.com/is/image/samsung/p6pim/levant/2208/gallery/levant-galaxy-watch5-pro-r925',
      price: 349.00,
      discountPrice: 299.00,
      rating: 4.4,
      reviewsCount: 89,
      category: 'Electronics',
      brand: 'Samsung',
    ),
    ProductModel(
      id: '3',
      name: 'Sony WH-1000XM5 Headphones',
      description:
          'Industry-leading noise cancelling with exceptional audio quality.',
      image: 'https://m.media-amazon.com/images/I/71o8Q5XJS5L._AC_SL1500_.jpg',
      price: 399.00,
      discountPrice: 379.00,
      rating: 4.7,
      reviewsCount: 162,
      category: 'Electronics',
      brand: 'Sony',
    ),
    ProductModel(
      id: '4',
      name: 'Dell XPS 13 Laptop',
      description: '13.3” FHD, Intel Core i7, 16GB RAM, 512GB SSD.',
      image:
          'https://i.dell.com/sites/imagecontent/products/publishingimages/xps-13-9310-laptop/spi/ng/notebook-xps-13-9310-black-campaign-hero-504x350-ng.psd',
      price: 1299.00,
      discountPrice: 1199.99,
      rating: 4.6,
      reviewsCount: 210,
      category: 'Electronics',
      brand: 'Dell',
    ),
    ProductModel(
      id: '5',
      name: 'Apple AirPods Pro (2nd Gen)',
      description: 'Active noise cancellation, Transparency mode, Adaptive EQ.',
      image:
          'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MME73?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1632861342000',
      price: 249.00,
      discountPrice: 219.00,
      rating: 4.5,
      reviewsCount: 185,
      category: 'Electronics',
      brand: 'Apple',
    ),
  ];
}
