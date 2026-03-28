class ProvinceModel {
  final String name;
  final int code;
  final String divisionType;
  final int phoneCode;

  ProvinceModel({
    required this.name,
    required this.code,
    required this.divisionType,
    required this.phoneCode,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      name: json['name'],
      code: json['code'],
      divisionType: json['division_type'],
      phoneCode: json['phone_code'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'division_type': divisionType,
      'phone_code': phoneCode,
    };
  }

  @override
  String toString() {
    return 'ProvinceModel(name: $name, code: $code, divisionType: $divisionType, phoneCode: $phoneCode)';
  }
}

class WardModel {
  final String name;
  final int code;
  final String divisionType;
  final int provinceCode;

  WardModel({
    required this.name,
    required this.code,
    required this.divisionType,
    required this.provinceCode,
  });

  factory WardModel.fromJson(Map<String, dynamic> json) {
    return WardModel(
      name: json['name'],
      code: json['code'],
      divisionType: json['division_type'],
      provinceCode: json['province_code'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'division_type': divisionType,
      'province_code': provinceCode,
    };
  }

  @override
  String toString() {
    return 'WardModel(name: $name, code: $code, divisionType: $divisionType, provinceCode: $provinceCode)';
  }
}

class AddressModel {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String addressType; // "home" or "office"
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.addressType,
    required this.isDefault,
  });
}

/// Mock address data
final List<AddressModel> mockAddresses = [
  AddressModel(
    id: '1',
    name: 'John Doe',
    phone: '1234567890',
    address: '123 Main St, Springfield, USA',
    addressType: 'home',
    isDefault: true,
  ),
  AddressModel(
    id: '2',
    name: 'Jane Smith',
    phone: '1234567890',
    address: '456 Office Park, Suite 200, Metropolis, USA',
    addressType: 'office',
    isDefault: false,
  ),
  AddressModel(
    id: '3',
    name: 'Alice Johnson',
    phone: '1234567890',
    address: '789 Elm St, Smallville, USA',
    addressType: 'home',
    isDefault: false,
  ),
  AddressModel(
    id: '4',
    name: 'Bob Lee',
    phone: '1234567890',
    address: '321 Tech Blvd, 12th Floor, Innovation City, USA',
    addressType: 'office',
    isDefault: false,
  ),
  AddressModel(
    id: '5',
    name: 'Charlie Kim',
    phone: '1234567890',
    address: '654 Home Ave, Lakeview, USA',
    addressType: 'home',
    isDefault: false,
  ),
];
