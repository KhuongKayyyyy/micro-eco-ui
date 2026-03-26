import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/account/app_feature_item.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/global_app_bar.dart';
import 'package:ecommerce_app/screens/tab/account/account_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/tab_controller.dart';
import 'package:flutter/material.dart';

class AccountScreen extends BaseScreen<AccountScreenController> {
  const AccountScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return GlobalAppBar(
      title: context.tr('account.title'),
      tabType: TabType.mentors,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        AppFeatureItem(
          title: context.tr('account.myOrders'),
          icon: Icons.shopping_bag_outlined,
          onTap: () => controller.goToMyOrders(),
        ),
        _buildSectionDivider(),
        AppFeatureItem(
          title: context.tr('account.myDetails'),
          icon: Icons.person_outline,
          onTap: () => controller.goToMyDetail(),
        ),
        AppFeatureItem(
          title: context.tr('account.addressBook'),
          icon: Icons.location_on_outlined,
        ),
        AppFeatureItem(
          title: context.tr('account.myReviews'),
          icon: Icons.reviews_outlined,
        ),
        AppFeatureItem(
          title: context.tr('account.paymentMethods'),
          icon: Icons.payment_outlined,
        ),
        AppFeatureItem(
          title: context.tr('account.notifications'),
          icon: Icons.notifications_outlined,
          onTap: () => controller.goToNotiSetting(),
          isLastItem: true,
        ),
        _buildSectionDivider(),
        AppFeatureItem(
          title: context.tr('account.helpCenter'),
          icon: Icons.help_outline,
          onTap: () => controller.goToHelpCenter(),
        ),
        AppFeatureItem(
          title: context.tr('account.faqs'),
          icon: Icons.help_center_outlined,
          isLastItem: true,
          onTap: () => controller.goToFaqs(),
        ),
        _buildSectionDivider(),
        _buildLogOutSection(context),
      ],
    );
  }

  Widget _buildSectionDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Divider(
        // ignore: deprecated_member_use
        color: Colors.grey.withOpacity(0.3),
        thickness: 5,
        height: 1,
      ),
    );
  }

  Widget _buildLogOutSection(BuildContext context) {
    const logoutRed = Color(0xFFE53935);
    return InkWell(
      onTap: () => controller.logout(),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            const Icon(Icons.logout, size: 24, color: logoutRed),
            const SizedBox(width: 16),
            Text(
              context.tr('account.logout'),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: logoutRed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
