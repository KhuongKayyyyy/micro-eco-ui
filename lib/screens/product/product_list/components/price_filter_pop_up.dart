import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/data/service/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';

class PriceRange {
  final Decimal minPrice;
  final Decimal maxPrice;

  const PriceRange({required this.minPrice, required this.maxPrice});
}

/// Shared helpers so other UIs (e.g. full filter sheet) stay consistent with
/// [PriceFilterPopUp].
abstract final class PriceRangeFilterHelper {
  static const double step = 1000;

  static String formatVnPrice(double value) {
    final intValue = value.round();
    if (intValue <= 0) return '0.000 đ';
    final formatted = NumberFormat('#,##0', 'vi_VN').format(intValue);
    return '$formatted đ';
  }

  static double snapToStep(double v) {
    return (v / step).round().toDouble() * step;
  }

  /// Parses user input that may contain grouping dots / "đ" / spaces.
  static Decimal? parseLooseMoneyToDecimal(String raw) {
    final digits = raw.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.isEmpty) return null;
    return Decimal.parse(digits);
  }
}

class PriceFilterPopUp extends StatefulWidget {
  const PriceFilterPopUp({
    super.key,
    this.categoryId,
    this.brandId,
    this.initialMinPrice,
    this.initialMaxPrice,
  });

  final String? categoryId;
  final String? brandId;
  final Decimal? initialMinPrice;
  final Decimal? initialMaxPrice;

  @override
  State<PriceFilterPopUp> createState() => _PriceFilterPopUpState();
}

class _PriceFilterPopUpState extends State<PriceFilterPopUp> {
  // Match the design from the screenshot (red accent).

  bool _loading = true;
  double _maxAvailablePrice = 0;
  RangeValues _selectedRange = const RangeValues(0, 0);

  @override
  void initState() {
    super.initState();
    _loadHighestPrice();
  }

  Future<void> _loadHighestPrice() async {
    setState(() => _loading = true);
    final max = await ProductService.getHighestPrice(
      categoryId: widget.categoryId,
      brandId: widget.brandId,
    );

    final safeMax = max > 0 ? max : 0.0;
    final initMin = widget.initialMinPrice?.toDouble() ?? 0.0;
    final initMax = widget.initialMaxPrice?.toDouble() ?? safeMax;

    final minClamped = initMin.clamp(0, safeMax);
    final maxClamped = initMax.clamp(minClamped, safeMax);

    // Snap to step.
    final snappedStart =
        PriceRangeFilterHelper.snapToStep(minClamped.toDouble());
    final snappedEnd = PriceRangeFilterHelper.snapToStep(maxClamped.toDouble());

    setState(() {
      _loading = false;
      _maxAvailablePrice = safeMax;
      _selectedRange = RangeValues(snappedStart, snappedEnd);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 52,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.gray300,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              AppText(
                text: 'Hãy chọn mức giá phù hợp với bạn',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.gray900,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.gray200),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            text: PriceRangeFilterHelper.formatVnPrice(
                              _selectedRange.start,
                            ),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray900,
                          ),
                        ),
                        AppText(
                          text: ' - ',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gray700,
                        ),
                        Expanded(
                          child: AppText(
                            text: PriceRangeFilterHelper.formatVnPrice(
                              _selectedRange.end,
                            ),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray900,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_loading)
                      Center(
                        child: SizedBox(
                          height: 34,
                          width: 34,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    else
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 6,
                          rangeThumbShape: const RoundRangeSliderThumbShape(
                            enabledThumbRadius: 10,
                            disabledThumbRadius: 10,
                          ),
                        ),
                        child: RangeSlider(
                          values: _selectedRange,
                          min: 0,
                          max: _maxAvailablePrice <= 0
                              ? 1.0
                              : _maxAvailablePrice,
                          activeColor: AppColors.primary,
                          inactiveColor: AppColors.gray200,
                          labels: RangeLabels(
                            PriceRangeFilterHelper.formatVnPrice(
                              _selectedRange.start,
                            ),
                            PriceRangeFilterHelper.formatVnPrice(
                              _selectedRange.end,
                            ),
                          ),
                          onChanged: (values) {
                            final snappedStart = PriceRangeFilterHelper
                                .snapToStep(values.start)
                                .clamp(0.0, _maxAvailablePrice)
                                .toDouble();
                            final snappedEnd = PriceRangeFilterHelper
                                .snapToStep(values.end)
                                .clamp(snappedStart, _maxAvailablePrice)
                                .toDouble();
                            setState(() {
                              _selectedRange = RangeValues(
                                snappedStart,
                                snappedEnd,
                              );
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: 'Đóng',
                      color: AppColors.white,
                      textColor: AppColors.primary,
                      border: Border.all(color: AppColors.primary),
                      borderRadius: 14,
                      height: 54,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      onTap: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      text: 'Xem kết quả',
                      color: AppColors.primary,
                      textColor: AppColors.white,
                      borderRadius: 14,
                      height: 54,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      onTap: () {
                        final min = _selectedRange.start;
                        final max = _selectedRange.end;
                        Get.back(
                          result: PriceRange(
                            minPrice: Decimal.parse(min.toStringAsFixed(0)),
                            maxPrice: Decimal.parse(max.toStringAsFixed(0)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
