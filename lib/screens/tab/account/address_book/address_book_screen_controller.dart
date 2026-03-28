import 'package:ecommerce_app/data/serivce/address_service.dart';
import 'package:ecommerce_app/model/address_model.dart';
import 'package:get/get.dart';

class AddressBookScreenController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxList<AddressModel> addresses = <AddressModel>[].obs;
  final Rxn<String> selectedAddressId = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    try {
      isLoading.value = true;
      final list = await AddressService.getAddresses();
      addresses.assignAll(list);

      String? initialId;
      for (final a in list) {
        if (a.isDefault) {
          initialId = a.id;
          break;
        }
      }
      initialId ??= list.isNotEmpty ? list.first.id : null;
      selectedAddressId.value = initialId;
    } finally {
      isLoading.value = false;
    }
  }

  void selectAddress(String id) {
    selectedAddressId.value = id;
  }

  void onEditAddress(AddressModel address) {}
}
