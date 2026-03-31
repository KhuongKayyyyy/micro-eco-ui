class CartModel {
  final String id;
  final String name;
  final String image;
  final String description;
  final double price;
  final int quantity;

  CartModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      description: json['description'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'description': description,
      'quantity': quantity,
    };
  }

  double get totalPrice => price * quantity;

  static List<CartModel> mockData = [
    CartModel(
      id: 'CART001',
      name: 'Wireless Earbuds',
      image:
          'https://cdn2.fptshop.com.vn/unsafe/2023_9_18_638306528295272368_tai-nghe-airpods-pro-2023-usb-c-dd.jpg',
      description:
          'Bluetooth 5.3 wireless earbuds with charging case, noise cancellation.',
      price: 59.99,
      quantity: 2,
    ),
    CartModel(
      id: 'CART002',
      name: 'Smart Watch',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLhiA04xNHP90pDU3p0ztB-FwE90HFORA9Bw&s',
      description:
          'Fitness tracking, heart-rate monitoring, and phone notifications.',
      price: 129.99,
      quantity: 1,
    ),
    CartModel(
      id: 'CART003',
      name: 'Mechanical Keyboard',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQliVKHKLcaovU5Mx14N9gX48nGc5tajJUJ8A&s',
      description:
          'RGB mechanical keyboard with blue switches and wireless connectivity.',
      price: 89.90,
      quantity: 1,
    ),
    CartModel(
      id: 'CART004',
      name: 'Portable SSD 1TB',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDAfbGM6fGa6M02LdPGqRMFD9ALSh074mA6g&s',
      description:
          'High-speed USB-C portable SSD storage for laptops and phones.',
      price: 135.00,
      quantity: 1,
    ),
    CartModel(
      id: 'CART005',
      name: '4K Action Camera',
      image:
          'https://cdn2.fptshop.com.vn/unsafe/512x0/filters:format(webp):quality(75)/dji_osmo_action_5_pro_standard_combo_5_07ccf444f5.jpg',
      description:
          'Waterproof 4K action camera with image stabilization and WiFi.',
      price: 99.00,
      quantity: 1,
    ),
  ];
}
