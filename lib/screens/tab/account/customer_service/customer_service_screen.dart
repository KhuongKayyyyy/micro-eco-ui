import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/screens/tab/account/customer_service/customer_service_screen_controller.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerServiceScreen
    extends BaseScreen<CustomerServiceScreenController> {
  const CustomerServiceScreen({super.key});

  ChatTheme _chatTheme() {
    final base = ChatTheme.light(fontFamily: 'Pretendard');
    return base.copyWith(
      colors: base.colors.copyWith(
        // Sent messages -> black bubble
        primary: const Color(0xFF101010),
        onPrimary: Colors.white,
        // Received messages -> light gray bubble
        surface: Colors.white,
        onSurface: const Color(0xFF101010),
        surfaceContainer: const Color(0xFFF1F1F1),
        surfaceContainerLow: const Color(0xFFF6F6F6),
        surfaceContainerHigh: const Color(0xFFEDEDED),
      ),
      shape: const BorderRadius.all(Radius.circular(12)),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: AppText(
        text: context.tr('customerService.title'),
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppColors.gray900,
      ),
      centerTitle: true,
      backgroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.phone_outlined, color: Colors.black),
        ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1, thickness: 1, color: Color(0xFFEDEDED)),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Chat(
      currentUserId: controller.me.id,
      resolveUser: controller.resolveUser,
      chatController: controller.chatController,
      theme: _chatTheme(),
      onMessageSend: controller.onSend,
      builders: Builders(
        composerBuilder: (context) => Composer(
          handleSafeArea: true,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
          gap: 10,
          hintText: 'Write your message…',
          hintColor: AppColors.gray400,
          textColor: AppColors.gray900,
          inputFillColor: AppColors.white,
          inputBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: AppColors.gray200, width: 1),
          ),
          attachmentIcon: Icon(
            Icons.image_outlined,
            color: AppColors.gray500,
            size: 22,
          ),
          sendIcon: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.gray900,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.mic_none_rounded, color: Colors.white),
          ),
          sendButtonVisibilityMode: SendButtonVisibilityMode.always,
          allowEmptyMessage: true,
        ),
        systemMessageBuilder:
            (context, message, index, {required isSentByMe, groupStatus}) {
              return Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.gray200),
                  ),
                  child: AppText(
                    text: message.text,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray600,
                  ),
                ),
              );
            },
      ),
    );
  }
}
