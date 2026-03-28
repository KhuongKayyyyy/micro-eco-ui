import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:ecommerce_app/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressScreenController extends GetxController {
  final pasteController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final detailAddressController = TextEditingController();

  final RxBool isDefaultAddress = false.obs;

  /// Matches [AddressModel.addressType]: `home` or `office`.
  final RxString addressType = 'home'.obs;

  final RxString province = ''.obs;
  final RxString district = ''.obs;
  final RxString ward = ''.obs;

  String get locationSummary {
    final parts = <String>[
      if (province.value.isNotEmpty) province.value,
      if (district.value.isNotEmpty) district.value,
      if (ward.value.isNotEmpty) ward.value,
    ];
    return parts.join(', ');
  }

  bool get hasLocation => locationSummary.isNotEmpty;

  void setAddressType(String type) {
    addressType.value = type;
  }

  void toggleDefault(bool value) {
    isDefaultAddress.value = value;
  }

  /// Opens the picker. Passes [locationSummary] as `address` when [hasLocation] so the picker can restore state.
  /// On success fills [province] + [ward] so [locationSummary] shows both.
  Future<void> goToProvinceSelect() async {
    final result = await Get.toNamed(
      AppRoutes.provinceSelect,
      arguments:
          hasLocation ? <String, dynamic>{'address': locationSummary} : null,
    );
    if (result is! Map) return;
    final p = result['province'];
    final w = result['ward'];
    if (p is ProvinceModel && w is WardModel) {
      province.value = p.name;
      ward.value = w.name;
      district.value = '';
    }
  }

  void onFinish() {
    Get.back();
  }

  @override
  void onClose() {
    pasteController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    detailAddressController.dispose();
    super.onClose();
  }
}
