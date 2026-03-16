// ignore_for_file: file_names
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/constants/string_constant.dart';
import 'package:flutter/material.dart';

// 앱 고유 텍스트
// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  TextDecoration? textDecoration;
  String text;
  Color? textColor;
  Color? disableTextColor;
  Color? color;
  Color? disableColor;
  double? fontSize;
  FontWeight? fontWeight;
  String? fontFamily;
  TextAlign? textAlign;
  TextOverflow? overflow;
  Function() onTap;
  int? maxLine;
  double? borderRadius;
  double? height;
  double? width;
  BoxBorder? border;
  bool? disabled;
  String? image;
  double? imageSize;

  AppButton({
    super.key,
    required this.text,
    this.color,
    this.disableTextColor,
    this.disableColor,
    this.fontFamily,
    this.height,
    this.textAlign,
    this.overflow,
    this.maxLine,
    this.borderRadius,
    required this.onTap,
    this.width,
    this.textColor,
    this.fontWeight,
    this.disabled,
    this.fontSize,
    this.border,
    this.image,
    this.textDecoration,
    this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50,
      decoration: BoxDecoration(
        color: disabled ?? false
            ? disableColor ?? AppColors.gray200
            : color ?? AppColors.primary,
        border: border,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
        child: Material(
          color: disabled ?? false
              ? disableColor ?? AppColors.gray200
              : color ?? AppColors.primary,
          child: InkWell(
            onTap: disabled ?? false ? () {} : onTap,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (image != null)
                    Row(
                      children: [
                        Image.asset(
                          image!,
                          width: imageSize ?? 30,
                          height: imageSize ?? 30,
                        ),
                        const SizedBox(width: 6),
                      ],
                    ),
                  Text(
                    text,
                    textAlign: textAlign ?? TextAlign.center,
                    overflow: overflow,
                    maxLines: maxLine,
                    style: TextStyle(
                      decoration: textDecoration ?? TextDecoration.none,
                      fontFamily: StringConstants.appFont,
                      fontWeight: fontWeight ?? FontWeight.w700,
                      fontSize: fontSize ?? 16,
                      letterSpacing: 0.02,
                      color: disabled ?? false
                          ? disableTextColor ?? AppColors.gray500
                          : textColor ?? AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
