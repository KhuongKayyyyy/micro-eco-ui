import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:ecommerce_app/data/service/payment_method_service.dart';
import 'package:ecommerce_app/model/card_model.dart';
import 'package:get/get.dart';

class PaymentMethodScreenController extends GetxController {
  final isLoading = true.obs;
  final cards = <CardModel>[].obs;
  final selectedCardId = RxnString();

  @override
  void onInit() {
    super.onInit();
    loadPaymentMethods();
  }

  Future<void> loadPaymentMethods() async {
    isLoading.value = true;
    try {
      final list = await PaymentMethodService.getPaymentMethods();
      cards.assignAll(list);
      if (list.isNotEmpty) {
        selectedCardId.value ??= list.first.id;
      }
    } finally {
      isLoading.value = false;
    }
  }

  void selectCard(String id) {
    selectedCardId.value = id;
  }

  bool isDefaultCard(CardModel card) =>
      cards.isNotEmpty && cards.first.id == card.id;

  void onApply() {
    Get.back(result: selectedCardId.value);
  }

  void goToAddNewCard() {
    Get.toNamed(AppRoutes.addNewCard);
  }
}
