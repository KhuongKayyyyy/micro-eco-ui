class FaqModel {
  final String question;
  final String answer;
  final String type; // general, account, service, payment, order

  FaqModel({required this.question, required this.answer, required this.type});
}

final List<FaqModel> faqs = [
  // GENERAL
  FaqModel(
    question: 'What is the return policy?',
    answer: 'We accept returns within 30 days of purchase.',
    type: 'general',
  ),
  FaqModel(
    question: 'What is the warranty policy?',
    answer: 'We offer a 1-year warranty on all products.',
    type: 'general',
  ),
  FaqModel(
    question: 'Is my personal information secure?',
    answer:
        'Yes, we ensure your data is encrypted and protected. Read our privacy policy for more information.',
    type: 'general',
  ),
  // ACCOUNT
  FaqModel(
    question: 'How can I contact customer support?',
    answer:
        'You can contact our customer support via email at support@example.com or call us at 1-800-123-4567.',
    type: 'account',
  ),
  FaqModel(
    question: 'Can I change my shipping address after placing an order?',
    answer:
        'You can change your shipping address before the order is shipped by visiting your account orders page.',
    type: 'account',
  ),
  // SERVICE
  FaqModel(
    question: 'Do you ship internationally?',
    answer:
        'Yes, we offer international shipping to selected countries. Please check our shipping policy for details.',
    type: 'service',
  ),
  FaqModel(
    question: 'Why hasn\'t my shipment arrived yet?',
    answer:
        'Delivery delays can occur due to various reasons. Please check your tracking information or contact support if delayed.',
    type: 'service',
  ),
  // ORDER
  FaqModel(
    question: 'How do I track my order?',
    answer:
        'You can track your order by clicking the tracking link in your order confirmation email.',
    type: 'order',
  ),
  FaqModel(
    question: 'How do I cancel my order?',
    answer:
        'To cancel your order, go to your order history and select the order you want to cancel.',
    type: 'order',
  ),
  FaqModel(
    question: 'When will I receive my refund?',
    answer:
        'Refunds are processed within 5-7 business days after the returned item is received.',
    type: 'order',
  ),
  // PAYMENT
  FaqModel(
    question: 'What payment methods are accepted?',
    answer:
        'We accept credit cards, debit cards, PayPal, and several other secure payment methods.',
    type: 'payment',
  ),
  FaqModel(
    question: 'How do I apply a discount code?',
    answer:
        'You can enter your discount code at checkout in the promo code field.',
    type: 'payment',
  ),
];
