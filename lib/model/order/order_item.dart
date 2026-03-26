class OrderItem {
  final String productId;
  final String productName;
  final String productImage;
  final String productDescription;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productDescription,
    required this.quantity,
    required this.price,
  });

  double get total => quantity * price;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      productName: json['productName'],
      productImage: json['productImage'],
      productDescription: json['productDescription'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'productDescription': productDescription,
      'quantity': quantity,
      'price': price,
    };
  }

  static List<OrderItem> demoItems = [
    OrderItem(
      productId: 'ELEC001',
      productName: 'Wireless Earbuds',
      productImage:
          'https://cdn2.fptshop.com.vn/unsafe/2023_9_18_638306528295272368_tai-nghe-airpods-pro-2023-usb-c-dd.jpg',
      productDescription:
          'Bluetooth 5.3 wireless earbuds with charging case, noise cancellation.',
      quantity: 1,
      price: 59.99,
    ),
    OrderItem(
      productId: 'ELEC002',
      productName: 'Smart Watch',
      productImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLhiA04xNHP90pDU3p0ztB-FwE90HFORA9Bw&s',
      productDescription:
          'Fitness tracking, heart-rate monitoring, and phone notifications.',
      quantity: 2,
      price: 129.99,
    ),
    OrderItem(
      productId: 'ELEC003',
      productName: 'Mechanical Keyboard',
      productImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQliVKHKLcaovU5Mx14N9gX48nGc5tajJUJ8A&s',
      productDescription:
          'RGB mechanical keyboard with blue switches and wireless connectivity.',
      quantity: 1,
      price: 89.90,
    ),
    OrderItem(
      productId: 'ELEC004',
      productName: 'Portable SSD 1TB',
      productImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDAfbGM6fGa6M02LdPGqRMFD9ALSh074mA6g&s',
      productDescription:
          'High-speed USB-C portable SSD storage for laptops and phones.',
      quantity: 1,
      price: 135.00,
    ),
    OrderItem(
      productId: 'ELEC005',
      productName: '4K Action Camera',
      productImage:
          'https://cdn2.fptshop.com.vn/unsafe/512x0/filters:format(webp):quality(75)/dji_osmo_action_5_pro_standard_combo_5_07ccf444f5.jpg',
      productDescription:
          'Waterproof 4K action camera with image stabilization and WiFi.',
      quantity: 1,
      price: 99.00,
    ),
    OrderItem(
      productId: 'ELEC006',
      productName: 'Bluetooth Speaker',
      productImage:
          'https://giadungnhaviet.com/wp-content/uploads/2021/03/Loa-Bluetooth-LG-XBOOM-Go-PL5-11.jpg',
      productDescription:
          'Portable Bluetooth speaker with 24-hour playtime and deep bass.',
      quantity: 3,
      price: 45.50,
    ),
    OrderItem(
      productId: 'ELEC007',
      productName: 'Smartphone Gimbal',
      productImage:
          'https://media.extra.com/s/aurora/100486723_800/DJI-Osmo-Gimbla-8-Mobile%2C-360%C2%B0-horizontal%2C-Direct-Phone-Connection%2C-Black?locale=en-GB,en-*,*',
      productDescription:
          '3-axis smartphone gimbal for smooth video recording.',
      quantity: 1,
      price: 72.99,
    ),
    OrderItem(
      productId: 'ELEC008',
      productName: 'Wireless Charger Pad',
      productImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrs4SbVV3MYAc7O5c1D1cyDukmAEiUkvZuDA&s',
      productDescription:
          'Fast wireless charging pad compatible with all Qi-enabled devices.',
      quantity: 2,
      price: 29.99,
    ),
    OrderItem(
      productId: 'ELEC009',
      productName: 'VR Headset',
      productImage:
          'https://cellphones.com.vn/sforum/wp-content/uploads/2023/06/vision-pro-ra-mat-1.jpg',
      productDescription:
          'Virtual reality headset for immersive gaming and movie experience.',
      quantity: 1,
      price: 199.99,
    ),
    OrderItem(
      productId: 'ELEC010',
      productName: 'Noise Cancelling Headphones',
      productImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ36JUPbnvQAgp5U-ROtWBssaH3wJHgSJYfQ&s',
      productDescription:
          'Over-ear active noise cancelling headphones with 30h battery life.',
      quantity: 1,
      price: 159.99,
    ),
  ];
}
