import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:get/get.dart';

class CustomerServiceScreenController extends GetxController {
  static const UserID _meId = 'me';
  static const UserID _supportId = 'support';

  late final InMemoryChatController chatController;

  final me = const User(id: _meId, name: 'Me');
  final support = const User(id: _supportId, name: 'Support');

  @override
  void onInit() {
    super.onInit();

    chatController = InMemoryChatController(
      messages: [
        // Date chip (centered)
        Message.system(
          id: 'd1',
          authorId: _supportId,
          createdAt: DateTime.now(),
          text: 'Today',
        ),
        Message.text(
          id: 'm1',
          authorId: _supportId,
          createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
          text: 'Hello, good morning.',
        ),
        Message.text(
          id: 'm2',
          authorId: _supportId,
          createdAt: DateTime.now().subtract(const Duration(minutes: 19)),
          text: 'I am a Customer Service, is there anything I can help you with?',
        ),
        Message.text(
          id: 'm3',
          authorId: _meId,
          createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
          text: "Hi, I'm having problems with my order & payment.",
        ),
        Message.text(
          id: 'm4',
          authorId: _meId,
          createdAt: DateTime.now().subtract(const Duration(minutes: 9)),
          text: 'Can you help me?',
        ),
        Message.text(
          id: 'm5',
          authorId: _supportId,
          createdAt: DateTime.now().subtract(const Duration(minutes: 8)),
          text: 'Of course…',
        ),
        Message.text(
          id: 'm6',
          authorId: _supportId,
          createdAt: DateTime.now().subtract(const Duration(minutes: 7)),
          text:
              'Can you tell me the problem you are having? so I can help solve it',
        ),
      ],
    );
  }

  Future<User?> resolveUser(UserID id) async => id == _meId ? me : support;

  Future<void> onSend(String text) async {
    final t = text.trim();
    if (t.isEmpty) return;
    await chatController.insertMessage(
      Message.text(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        authorId: _meId,
        createdAt: DateTime.now(),
        text: t,
      ),
    );
  }

  @override
  void onClose() {
    chatController.dispose();
    super.onClose();
  }
}
