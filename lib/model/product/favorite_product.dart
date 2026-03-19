class FavoriteProduct {
  final String id;
  final String name;
  final String image;
  final double price;

  FavoriteProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  static final List<FavoriteProduct> mockFavoriteProducts = [
    FavoriteProduct(
      id: '101',
      name: 'Wireless Bluetooth Headphones',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1fhApyEPNsSVbaXyFTyjxsR4R0YG4vve8rA&s',
      price: 59.99,
    ),
    FavoriteProduct(
      id: '102',
      name: 'Smart Watch Series 5',
      image:
          'https://istarmax.com/wp-content/uploads/2024/01/gts7-pro-smart-watch-view-6-en-jpg.webp',
      price: 189.50,
    ),
    FavoriteProduct(
      id: '103',
      name: 'Portable Speaker',
      image: 'assets/images/products/speaker.png',
      price: 39.99,
    ),
    FavoriteProduct(
      id: '104',
      name: 'Gaming Mouse',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkzm330_QXVLpQJnT6jKW3ixSYYI9Vka9t6Q&s',
      price: 24.89,
    ),
    FavoriteProduct(
      id: '105',
      name: '4K Action Camera',
      image:
          'https://dokimi.vn/wp-content/uploads/2024/09/dji-osmo-action-5-pro-6-1.jpg',
      price: 149.00,
    ),
  ];
}
