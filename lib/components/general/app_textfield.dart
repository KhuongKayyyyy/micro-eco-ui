// ignore_for_file: file_names

import 'package:ecommerce_app/common/theme/theme_service.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/constants/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AppTextField extends StatelessWidget {
  final String? initialValue;
  final bool? isCollapsed;
  final TextEditingController? textController;
  final TextInputAction? textInputAction;
  final TextInputType? keyBoardType;
  final AutovalidateMode? autoValidateMode;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Color? textColor;
  final FontWeight? fontWeight;
  final bool? obscureText;
  final bool? isCursorEnable;
  final VoidCallback? callbackSuffix;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final TextDecoration? textDecoration;
  final TextDecorationStyle? textDecorationStyle;
  final Color? textDecorationColor;
  String? font;
  bool? readOnly;
  int? maxLength;
  int? minLines;
  int? maxLines;
  TextAlign? textAlign;
  double? fontSize;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmmited;
  final String? errorText;
  final Color? textBorderColor;
  final Color? textFieldLight;
  final Color? textFieldDark;
  final Color? textColorHint;
  final Color? fillColor;
  final Color? enableBorderColor;
  final double? radius;
  final List<TextInputFormatter>? inputFormatters;
  final double? radiousFouse;
  final double? height;
  final EdgeInsets? contentPadding;
  OutlineInputBorder? border;
  final FocusNode? focusNode;
  final String? labelText;
  final Color? labelTextColor;
  final double? labelFontSize;
  final FontWeight? labelFontWeight;
  final Widget? counter;
  final bool? autoFocus;
  final bool? enabled;

  AppTextField({
    super.key,
    this.isCollapsed,
    this.initialValue,
    this.keyBoardType,
    this.autoValidateMode,
    this.focusNode,
    this.textInputAction,
    this.textController,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onSubmmited,
    this.errorText,
    this.textColor,
    this.fontWeight,
    this.obscureText,
    this.callbackSuffix,
    this.suffix,
    this.textDecoration,
    this.textDecorationStyle,
    this.textDecorationColor,
    this.font,
    this.textAlign,
    this.height,
    this.validator,
    this.readOnly,
    this.isCursorEnable,
    this.maxLength,
    this.onChanged,
    this.textBorderColor,
    this.textFieldLight,
    this.textFieldDark,
    this.contentPadding,
    this.textColorHint,
    this.fillColor,
    this.enableBorderColor,
    this.minLines,
    this.fontSize,
    this.maxLines,
    this.border,
    this.labelText,
    this.counter,
    this.inputFormatters,
    this.radius,
    this.radiousFouse,
    this.labelTextColor,
    this.labelFontSize = 16,
    this.labelFontWeight = FontWeight.w600,
    this.autoFocus,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    final isDarkMode = themeService.isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Column(
            children: [
              AppText(
                text: labelText!,
                fontSize: labelFontSize,
                fontWeight: labelFontWeight,
                color:
                    labelTextColor ??
                    (isDarkMode ? AppColors.gray200 : const Color(0xFF282C35)),
              ),
              const SizedBox(height: 10),
            ],
          ),
        TextFormField(
          initialValue: textController == null ? initialValue : null,
          textAlignVertical: TextAlignVertical.center,
          autofocus: autoFocus ?? false,
          focusNode: focusNode,
          keyboardType: keyBoardType,
          readOnly: readOnly ?? false,
          textAlign: textAlign ?? TextAlign.start,
          enabled: enabled ?? true,
          maxLength: maxLength,
          minLines: minLines,
          maxLines: maxLines ?? 1,
          autovalidateMode: autoValidateMode,
          validator: validator,
          textInputAction: textInputAction,
          onTap: onTap,
          onChanged: onChanged,
          obscureText: obscureText ?? false,
          controller: textController,
          onFieldSubmitted: onSubmmited,
          inputFormatters: inputFormatters ?? [],
          cursorColor: AppColors.primary,
          style: TextStyle(
            color:
                textColor ??
                (isDarkMode ? AppColors.gray100 : AppColors.gray900),
            fontFamily: font ?? StringConstants.appFont,
            fontSize: fontSize ?? 14,
            fontWeight: fontWeight ?? FontWeight.w400,
            letterSpacing: 0.02,
            height: height ?? 1.5,
            decoration: textDecoration ?? TextDecoration.none,
            decorationStyle: textDecorationStyle ?? TextDecorationStyle.solid,
            decorationColor: textDecorationColor ?? Colors.transparent,
          ),
          decoration: InputDecoration(
            isCollapsed: isCollapsed ?? false,
            errorStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.statusError,
            ),
            counterText: '',
            enabledBorder:
                border ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? AppColors.gray600 : AppColors.gray200,
                  ),
                  borderRadius: BorderRadius.circular(radius ?? 8),
                ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.circular(radius ?? 8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.statusError),
              borderRadius: BorderRadius.circular(radius ?? 8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.statusError),
              borderRadius: BorderRadius.circular(radius ?? 8),
            ),
            focusedBorder: readOnly ?? false
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(radius ?? 8),
                  )
                : border ??
                      OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(radius ?? 8),
                      ),
            border:
                border ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? AppColors.gray600 : AppColors.gray200,
                  ),
                  borderRadius: BorderRadius.circular(radius ?? 8),
                ),
            fillColor:
                fillColor ??
                (readOnly ?? false
                    ? (isDarkMode ? AppColors.gray700 : AppColors.gray100)
                    : (isDarkMode ? AppColors.gray800 : Colors.white)),
            filled: true,
            hintText: hintText,
            suffix: suffix,
            errorText: errorText,
            hintStyle: TextStyle(
              fontFamily: font ?? StringConstants.appFont,
              color:
                  textColorHint ??
                  (isDarkMode ? AppColors.gray500 : AppColors.gray400),
              fontSize: fontSize ?? 14,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.02,
              height: height ?? 1.5,
              decoration: textDecoration ?? TextDecoration.none,
              decorationStyle: textDecorationStyle ?? TextDecorationStyle.solid,
              decorationColor: textDecorationColor ?? Colors.transparent,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            counter: counter,
            suffixIconConstraints: BoxConstraints(maxHeight: double.maxFinite),
            contentPadding:
                contentPadding ??
                EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
        ),
      ],
    );
  }
}
