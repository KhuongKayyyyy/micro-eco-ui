import 'package:ecommerce_app/constants/api_path.dart';
import 'package:ecommerce_app/data/dio/dio_service.dart';
import 'package:ecommerce_app/model/address_model.dart';
import 'package:get/get.dart';

class AddressService {
  final DioService dioService = Get.find<DioService>();
  static Future<List<AddressModel>> getAddresses() async {
    // Simulate fetching delay
    await Future.delayed(const Duration(milliseconds: 1500));
    return mockAddresses;
  }

  Future<List<ProvinceModel>> getAllProvinces() async {
    final response = await dioService.get<List<dynamic>>(
      baseUrl: BaseURL.address,
      path: ApiPath.getAllProvinces,
    );
    return response
        .map(
          (e) => ProvinceModel.fromJson(
            Map<String, dynamic>.from(e as Map<dynamic, dynamic>),
          ),
        )
        .toList();
  }

  Future<List<WardModel>> getWards(int provinceCode) async {
    final response = await dioService.get<Map<String, dynamic>>(
      baseUrl: BaseURL.address,
      path: ApiPath.provinceByCode(provinceCode),
      parameters: const {'depth': '2'},
    );
    final wardsJson = response['wards'];
    if (wardsJson is! List<dynamic>) return [];
    return wardsJson
        .map(
          (e) => WardModel.fromJson(
            Map<String, dynamic>.from(e as Map<dynamic, dynamic>),
          ),
        )
        .toList();
  }
}
