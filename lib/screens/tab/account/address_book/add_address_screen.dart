import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/constants/string_constant.dart';
import 'package:ecommerce_app/screens/tab/account/address_book/add_address_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressScreen extends BaseScreen<AddAddressScreenController> {
  const AddAddressScreen({super.key});

  static const Color _accentCoral = Color(0xFFFF5C4D);
  static const Color _pasteCardBg = Color(0xFFFFF5F5);
  static const Color _pasteCardBorder = Color(0xFFFFE0E0);
  static const double _hPad = 16;
  static const double _cardRadius = 12;

  @override
  Color? get backgroundColor => AppColors.gray100;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: AppText(
        text: context.tr('addressBook.newAddress'),
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: AppColors.gray900,
      ),
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: _accentCoral),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1, thickness: 1, color: Color(0xFFEDEDED)),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(_hPad, 12, _hPad, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildQuickPasteCard(context),
                const SizedBox(height: 12),
                _buildAddressFormCard(context),
                const SizedBox(height: 12),
                _buildSettingsCard(context),
              ],
            ),
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(_hPad, 0, _hPad, 12),
            child: AppButton(
              text: context.tr('addressBook.finish'),
              color: AppColors.gray300,
              textColor: AppColors.white,
              fontWeight: FontWeight.w800,
              fontSize: 15,
              height: 52,
              borderRadius: 10,
              onTap: controller.onFinish,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickPasteCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _pasteCardBg,
        borderRadius: BorderRadius.circular(_cardRadius),
        border: Border.all(color: _pasteCardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.content_paste_go_rounded,
                color: _accentCoral,
                size: 24,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: context.tr('addressBook.quickPasteTitle'),
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.gray900,
                    ),
                    const SizedBox(height: 4),
                    AppText(
                      text: context.tr('addressBook.quickPasteSubtitle'),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray600,
                      height: 1.35,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller.pasteController,
            minLines: 3,
            maxLines: 5,
            style: TextStyle(
              fontFamily: StringConstants.appFont,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.gray900,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              hintText: context.tr('addressBook.pasteHint'),
              hintStyle: TextStyle(
                fontFamily: StringConstants.appFont,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.gray400,
              ),
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.gray200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.gray200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.gray400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressFormCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(_cardRadius),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: AppText(
              text: context.tr('addressBook.addressFormSectionTitle'),
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.gray900,
            ),
          ),
          _plainField(
            controller: controller.fullNameController,
            hint: context.tr('addressBook.fullNameHint'),
          ),
          _divider(),
          _plainField(
            controller: controller.phoneController,
            hint: context.tr('addressBook.phoneHint'),
            keyboardType: TextInputType.phone,
          ),
          _divider(),
          _locationRow(context),
          _divider(),
          _plainField(
            controller: controller.detailAddressController,
            hint: context.tr('addressBook.detailAddressHint'),
          ),
        ],
      ),
    );
  }

  Widget _locationRow(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: controller.goToProvinceSelect,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Obx(() {
                  final summary = controller.locationSummary;
                  final has = controller.hasLocation;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: context.tr('addressBook.locationLabel'),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray500,
                      ),
                      const SizedBox(height: 4),
                      AppText(
                        text: has
                            ? summary
                            : context.tr('addressBook.locationPlaceholder'),
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: has ? AppColors.gray900 : AppColors.gray400,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                }),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.gray400,
                size: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _plainField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          fontFamily: StringConstants.appFont,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.gray900,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: StringConstants.appFont,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.gray400,
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.gray200,
      indent: 16,
      endIndent: 16,
    );
  }

  Widget _buildSettingsCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(_cardRadius),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: AppText(
                  text: context.tr('addressBook.setAsDefault'),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gray900,
                ),
                value: controller.isDefaultAddress.value,
                activeTrackColor: AppColors.gray800,
                activeColor: AppColors.white,
                onChanged: controller.toggleDefault,
              ),
            ),
          ),
          _divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: context.tr('addressBook.addressTypeLabel'),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gray700,
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: _addressTypeChip(
                          label: context.tr('addressBook.addressTypeOffice'),
                          selected: controller.addressType.value == 'office',
                          onTap: () => controller.setAddressType('office'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _addressTypeChip(
                          label: context.tr('addressBook.addressTypeHome'),
                          selected: controller.addressType.value == 'home',
                          onTap: () => controller.setAddressType('home'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _addressTypeChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? AppColors.gray900 : AppColors.gray100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? AppColors.gray900 : AppColors.gray200,
            ),
          ),
          alignment: Alignment.center,
          child: AppText(
            text: label,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: selected ? AppColors.white : AppColors.gray900,
          ),
        ),
      ),
    );
  }
}
