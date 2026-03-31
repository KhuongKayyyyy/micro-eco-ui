import 'package:ecommerce_app/model/card_model.dart';

class PaymentMethodService {
  static Future<List<CardModel>> getPaymentMethods() async {
    await Future.delayed(const Duration(seconds: 2)); // Fake 2s wait
    return CardModel.mockCards;
  }
}
