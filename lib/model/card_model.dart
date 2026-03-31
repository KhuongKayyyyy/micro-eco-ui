class CardModel {
  final String id;
  final String name;
  final String number;
  final String expiryDate;
  final String cvv;

  CardModel({
    required this.id,
    required this.name,
    required this.number,
    required this.expiryDate,
    required this.cvv,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      expiryDate: json['expiryDate'],
      cvv: json['cvv'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'expiryDate': expiryDate,
      'cvv': cvv,
    };
  }

  /// Digits-only PAN, last four for display (e.g. `**** **** **** 1234`).
  String get lastFourDigits {
    final digits = number.replaceAll(RegExp(r'\D'), '');
    if (digits.length >= 4) return digits.substring(digits.length - 4);
    return digits.padLeft(4, '0');
  }

  // Three mockup card data examples
  static final List<CardModel> mockCards = [
    CardModel(
      id: '1',
      name: 'John Doe',
      number: '4111111111111111',
      expiryDate: '12/25',
      cvv: '123',
    ),
    CardModel(
      id: '2',
      name: 'Jane Smith',
      number: '5500000000000004',
      expiryDate: '09/26',
      cvv: '456',
    ),
    CardModel(
      id: '3',
      name: 'Alex Brown',
      number: '340000000000009',
      expiryDate: '04/27',
      cvv: '789',
    ),
  ];
}
