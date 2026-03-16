// ignore_for_file: file_names

import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/constants/string_constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppText extends StatelessWidget {
  TextDecoration? textDecoration;
  String text;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  String? fontFamily;
  TextAlign? textAlign;
  FontStyle? fontStyle;
  TextOverflow? overflow = TextOverflow.ellipsis;
  int? maxLines;
  int? maxLength;
  double? height;
  double? width;
  double? letterSpacing;

  AppText({
    super.key,
    required this.text,
    this.color,
    this.fontFamily,
    this.height,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.width,
    this.maxLength,
    this.letterSpacing,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor =
        color ??
        Theme.of(context).textTheme.bodyLarge?.color ??
        AppColors.gray900;
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        height: height ?? 1.4,
        decoration: textDecoration ?? TextDecoration.none,
        decorationColor: effectiveColor,
        fontFamily: fontFamily ?? StringConstants.appFont,
        fontSize: fontSize ?? 14,
        letterSpacing: letterSpacing ?? -0.48,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: effectiveColor,
      ),
    );
  }
}
