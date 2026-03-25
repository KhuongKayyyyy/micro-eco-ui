import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/components/general/app_textfield.dart';
import 'package:ecommerce_app/components/general/global_app_bar.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/screens/tab/account/my_detail/my_detail_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/tab_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_intl_phone_field/country_picker_dialog.dart';
import 'package:get/get.dart';

class MyDetailScreen extends BaseScreen<MyDetailScreenController> {
  const MyDetailScreen({super.key});

  static const double _pagePaddingH = 20;
  static const double _pagePaddingV = 16;
  static const double _fieldGap = 10;

  Future<void> _showDobPicker(BuildContext context) async {
    final raw = controller.dateOfBirthController.text.trim();
    final parsed = raw.isEmpty ? null : DateTime.tryParse(raw);

    final initialDate = parsed ?? DateTime(2000, 1, 1);

    final theme = Theme.of(context).copyWith(
      colorScheme: ColorScheme.light(
        primary: Colors.black,
        onPrimary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.black),
      ),
    );

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime(2100, 12, 31),
      builder: (context, child) {
        return Theme(data: theme, child: child ?? const SizedBox());
      },
    );

    if (picked == null) return;

    final formatted =
        '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';

    controller.dateOfBirthController.text = formatted;
    controller.dateOfBirth.value = formatted;
  }

  Widget _buildLabel(
    BuildContext context, {
    required String text,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
  }) {
    return AppText(
      text: text,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color ?? AppColors.primary,
      textAlign: TextAlign.left,
    );
  }

  Widget _wrapSkeleton(Widget child) {
    return Skeletonizer(enabled: controller.isLoading.value, child: child);
  }

  Widget _buildSkeletonTextField({
    required BuildContext context,
    required String hintKey,
    required TextEditingController textController,
    Widget? suffixIcon,
  }) {
    return _wrapSkeleton(
      AppTextField(
        hintText: context.tr(hintKey),
        textController: textController,
        suffixIcon: suffixIcon,
      ),
    );
  }

  Widget _buildSkeletonIntlPhoneField(BuildContext context) {
    return _wrapSkeleton(
      IntlPhoneField(
        initialCountryCode: 'US',
        controller: controller.phoneNumberController,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: AppColors.gray900,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        dropdownTextStyle: TextStyle(
          color: AppColors.gray900,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        dropdownIcon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.gray500,
        ),
        flagsButtonMargin: EdgeInsets.zero,
        flagsButtonPadding: EdgeInsets.zero,
        showCountryFlag: true,
        showDropdownIcon: true,
        cursorColor: AppColors.primary,
        pickerDialogStyle: PickerDialogStyle(
          backgroundColor: Colors.white,
          countryCodeStyle: TextStyle(
            color: AppColors.gray900,
            fontWeight: FontWeight.w700,
          ),
          countryNameStyle: TextStyle(
            color: AppColors.gray900,
            fontWeight: FontWeight.w600,
          ),
          listTileDivider: Divider(
            thickness: 1,
            color: AppColors.gray200,
            height: 1,
          ),
          dialogPadding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 24,
          ),
          searchFieldCursorColor: AppColors.primary,
          searchFieldInputDecoration: InputDecoration(
            hintText: context.tr('account.enterCountry'),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.gray200),
            ),
          ),
          width: 420,
        ),
        dialogType: DialogType.showModalBottomSheet,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: context.tr('account.phoneNumber'),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.gray200),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.gray200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
        onChanged: controller.isLoading.value
            ? null
            : (phoneNumber) {
                final complete = phoneNumber.completeNumber;
                controller.phone.value = complete;
              },
      ),
    );
  }

  Widget _buildDobSuffixIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: Icon(Icons.calendar_month_outlined, color: AppColors.gray500),
        onPressed: controller.isLoading.value
            ? null
            : () => _showDobPicker(context),
      ),
    );
  }

  Widget _buildGenderDropdown(BuildContext context) {
    return _wrapSkeleton(
      DropdownButtonFormField<String>(
        value: controller.genderController.text.isEmpty
            ? null
            : controller.genderController.text,
        items: [
          DropdownMenuItem(
            value: 'Male',
            child: AppText(text: context.tr('account.genderMale')),
          ),
          DropdownMenuItem(
            value: 'Female',
            child: AppText(text: context.tr('account.genderFemale')),
          ),
        ],
        alignment: Alignment.centerLeft,
        isExpanded: true,
        dropdownColor: Colors.white,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        hint: AppText(
          text: context.tr('account.gender'),
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.gray500,
          textAlign: TextAlign.left,
        ),
        onChanged: controller.isLoading.value
            ? null
            : (value) {
                if (value == null) return;
                controller.genderController.text = value;
                controller.gender.value = value;
              },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.gray200),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.gray200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
        menuMaxHeight: 260,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.gray900,
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return GlobalAppBar(
      title: context.tr('account.myDetails'),
      tabType: TabType.mentors,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: _pagePaddingH,
                vertical: _pagePaddingV,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel(
                    context,
                    text: context.tr('account.fullName'),
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: _fieldGap),
                  _buildSkeletonTextField(
                    context: context,
                    hintKey: 'account.fullName',
                    textController: controller.nameController,
                  ),
                  const SizedBox(height: _fieldGap),
                  _buildLabel(
                    context,
                    text: context.tr('account.emailAddress'),
                    fontSize: 16,
                    color: AppColors.gray900,
                  ),
                  const SizedBox(height: _fieldGap),
                  _buildSkeletonTextField(
                    context: context,
                    hintKey: 'account.emailAddress',
                    textController: controller.emailController,
                  ),

                  const SizedBox(height: _fieldGap),
                  _buildLabel(
                    context,
                    text: context.tr('account.dateOfBirth'),
                    fontSize: 16,
                    color: AppColors.gray900,
                  ),
                  const SizedBox(height: _fieldGap),
                  _buildSkeletonTextField(
                    context: context,
                    hintKey: 'account.dateOfBirth',
                    textController: controller.dateOfBirthController,
                    suffixIcon: _buildDobSuffixIcon(context),
                  ),

                  const SizedBox(height: _fieldGap),
                  _buildLabel(
                    context,
                    text: context.tr('account.gender'),
                    fontSize: 16,
                    color: AppColors.gray900,
                  ),
                  const SizedBox(height: _fieldGap),
                  _buildGenderDropdown(context),

                  const SizedBox(height: _fieldGap),
                  _buildLabel(
                    context,
                    text: context.tr('account.phoneNumber'),
                    fontSize: 16,
                    color: AppColors.gray900,
                  ),
                  const SizedBox(height: _fieldGap),
                  _buildSkeletonIntlPhoneField(context),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppButton(
              text: context.tr('buttonAction.submit'),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
