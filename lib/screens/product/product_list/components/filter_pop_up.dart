import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/data/service/product_service.dart';
import 'package:ecommerce_app/screens/product/product_list/components/price_filter_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:decimal/decimal.dart';

/// Values applied from the full filter sheet (price, stock, attribute chips).
class FilterSheetApply {
  FilterSheetApply({
    required this.priceRange,
    required this.availableOnly,
    required Map<String, List<String>> attributes,
  }) : attributes = Map<String, List<String>>.from(
         attributes.map((k, v) => MapEntry(k, List<String>.from(v))),
       );

  final PriceRange priceRange;
  final bool availableOnly;
  final Map<String, List<String>> attributes;
}

class _AttrSection {
  const _AttrSection(this.title, this.queryKey, this.options);

  final String title;
  final String queryKey;
  final List<String> options;
}

/// Keys must match backend query parameter names.
abstract final class ProductFilterQueryKeys {
  static const usageNeeds = 'usageNeeds';
  static const chipset = 'chipset';
  static const operatingSystem = 'operatingSystem';
  static const ram = 'ram';
  static const internalStorage = 'internalStorage';
  static const specialFeatures = 'specialFeatures';
  static const cameraFeatures = 'cameraFeatures';
  static const refreshRate = 'refreshRate';
  static const screenSize = 'screenSize';
  static const screenType = 'screenType';
  static const nfc = 'nfc';
}

const List<_AttrSection> _kAttributeSections = [
  _AttrSection('Nhu cầu sử dụng', ProductFilterQueryKeys.usageNeeds, [
    'Chơi game',
    'Pin trâu',
    'Dung lượng lớn',
    'Cấu hình cao',
    'Mỏng nhẹ',
    'Chụp ảnh đẹp',
    'Nhỏ gọn, dễ cầm nắm',
    'Livestream',
  ]),
  _AttrSection('Chip xử lí', ProductFilterQueryKeys.chipset, [
    'Snapdragon',
    'Apple A',
    'Mediatek Dimensity',
    'Mediatek Helio',
    'Exynos',
    'Unisoc',
    'A19',
  ]),
  _AttrSection('Loại điện thoại', ProductFilterQueryKeys.operatingSystem, [
    'iPhone (iOS)',
    'Android',
    'Điện thoại phổ thông',
    'iOS',
  ]),
  _AttrSection('Dung lượng RAM', ProductFilterQueryKeys.ram, [
    'Dưới 3 GB',
    '3 GB',
    '4 GB',
    '6 GB',
    '8 GB',
    '12 GB',
    '16 GB',
    'Dưới 4 GB',
    '4G - 6GB',
    '8GB - 12GB',
    '12GB trở lên',
    '8G',
  ]),
  _AttrSection('Bộ nhớ trong', ProductFilterQueryKeys.internalStorage, [
    'Dưới 64 GB',
    '64 GB',
    '128 GB',
    '256 GB',
    '512 GB',
    '1 TB',
    '2 TB',
    'Dưới 32GB',
    '32GB và 64GB',
    '128GB và 256GB',
    'Trên 512GB',
  ]),
  _AttrSection('Tính năng đặc biệt', ProductFilterQueryKeys.specialFeatures, [
    'Sạc không dây',
    'Bảo mật vân tay',
    'Nhận diện khuôn mặt',
    'Kháng nước, kháng bụi',
    'Hỗ trợ 5G',
    'Điện thoại AI',
    'Đi kèm bút cảm ứng',
    'Pin khủng',
    'Chế độ đọc sách',
    'Chế độ cho trẻ em',
  ]),
  _AttrSection('Tính năng camera', ProductFilterQueryKeys.cameraFeatures, [
    'Chụp xóa phông',
    'Chụp góc rộng',
    'Quay video 4K',
    'Chụp Zoom xa',
    'Chụp macro',
    'Chống rung',
    'Quay video 8K',
    'Camera AI',
    'Chụp ảnh chuyển động',
    'Chụp đêm',
  ]),
  _AttrSection('Tần số quét', ProductFilterQueryKeys.refreshRate, [
    '60Hz',
    '120Hz',
    '90Hz',
    'Từ 144Hz trở lên',
  ]),
  _AttrSection('Kích thước màn hình', ProductFilterQueryKeys.screenSize, [
    'Trên 6 inch',
    'Dưới 6 inch',
  ]),
  _AttrSection('Kiểu màn hình', ProductFilterQueryKeys.screenType, [
    'Tai thỏ',
    'Tràn viền (Không khiếm khuyết)',
    'Màn hình gập',
    'Giọt nước',
    'Đục lỗ (Nốt ruồi)',
    'Dynamic Island',
  ]),
  _AttrSection('Công nghệ NFC', ProductFilterQueryKeys.nfc, ['Có', 'Không']),
];

class FilterPopUp extends StatefulWidget {
  const FilterPopUp({
    super.key,
    this.categoryId,
    this.brandId,
    this.initialMinPrice,
    this.initialMaxPrice,
    this.initialAvailableOnly = false,
    this.initialAttributes = const {},
    required this.onApply,
  });

  final String? categoryId;
  final String? brandId;
  final Decimal? initialMinPrice;
  final Decimal? initialMaxPrice;
  final bool initialAvailableOnly;
  final Map<String, List<String>> initialAttributes;
  final ValueChanged<FilterSheetApply> onApply;

  @override
  State<FilterPopUp> createState() => _FilterPopUpState();
}

class _FilterPopUpState extends State<FilterPopUp> {
  bool _loadingPrice = true;
  double _maxAvailablePrice = 0;
  RangeValues _selectedRange = const RangeValues(0, 0);

  late bool _availableOnly;
  final Map<String, Set<String>> _selectedByKey = {};

  late final TextEditingController _minField;
  late final TextEditingController _maxField;

  @override
  void initState() {
    super.initState();
    _availableOnly = widget.initialAvailableOnly;
    for (final section in _kAttributeSections) {
      final initial = widget.initialAttributes[section.queryKey];
      _selectedByKey[section.queryKey] = {if (initial != null) ...initial};
    }
    _minField = TextEditingController();
    _maxField = TextEditingController();
    _loadHighestPrice();
  }

  @override
  void dispose() {
    _minField.dispose();
    _maxField.dispose();
    super.dispose();
  }

  Future<void> _loadHighestPrice() async {
    setState(() => _loadingPrice = true);
    final max = await ProductService.getHighestPrice(
      categoryId: widget.categoryId,
      brandId: widget.brandId,
    );

    final safeMax = max > 0 ? max : 0.0;
    final initMin = widget.initialMinPrice?.toDouble() ?? 0.0;
    final initMax = widget.initialMaxPrice?.toDouble() ?? safeMax;

    final minClamped = initMin.clamp(0, safeMax);
    final maxClamped = initMax.clamp(minClamped, safeMax);

    final snappedStart = PriceRangeFilterHelper.snapToStep(
      minClamped.toDouble(),
    );
    final snappedEnd = PriceRangeFilterHelper.snapToStep(maxClamped.toDouble());

    setState(() {
      _loadingPrice = false;
      _maxAvailablePrice = safeMax;
      _selectedRange = RangeValues(snappedStart, snappedEnd);
      _syncMoneyFieldsToRange();
    });
  }

  void _syncMoneyFieldsToRange() {
    _minField.text = PriceRangeFilterHelper.formatVnPrice(_selectedRange.start);
    _maxField.text = PriceRangeFilterHelper.formatVnPrice(_selectedRange.end);
  }

  void _applyParsedFieldsToRange() {
    final minD =
        PriceRangeFilterHelper.parseLooseMoneyToDecimal(_minField.text) ??
        Decimal.zero;
    final maxD =
        PriceRangeFilterHelper.parseLooseMoneyToDecimal(_maxField.text) ??
        Decimal.zero;
    var minV = minD.toDouble();
    var maxV = maxD.toDouble();
    minV = minV.clamp(0.0, _maxAvailablePrice);
    maxV = maxV.clamp(0.0, _maxAvailablePrice);
    if (maxV < minV) {
      final t = minV;
      minV = maxV;
      maxV = t;
    }
    final snappedStart = PriceRangeFilterHelper.snapToStep(
      minV,
    ).clamp(0.0, _maxAvailablePrice);
    final snappedEnd = PriceRangeFilterHelper.snapToStep(
      maxV,
    ).clamp(snappedStart, _maxAvailablePrice);
    setState(() {
      _selectedRange = RangeValues(snappedStart, snappedEnd);
      _syncMoneyFieldsToRange();
    });
  }

  void _resetDraft() {
    setState(() {
      _availableOnly = false;
      for (final k in _selectedByKey.keys.toList()) {
        _selectedByKey[k] = {};
      }
      final safeMax = _maxAvailablePrice;
      _selectedRange = RangeValues(0, safeMax <= 0 ? 0 : safeMax);
      _syncMoneyFieldsToRange();
    });
  }

  void _submitApply() {
    final min = _selectedRange.start;
    final max = _selectedRange.end;
    final attributes = <String, List<String>>{};
    for (final section in _kAttributeSections) {
      final set = _selectedByKey[section.queryKey] ?? {};
      final ordered = <String>[
        for (final o in section.options)
          if (set.contains(o)) o,
        for (final s in set)
          if (!section.options.contains(s)) s,
      ];
      attributes[section.queryKey] = ordered;
    }
    widget.onApply(
      FilterSheetApply(
        priceRange: PriceRange(
          minPrice: Decimal.parse(min.toStringAsFixed(0)),
          maxPrice: Decimal.parse(max.toStringAsFixed(0)),
        ),
        availableOnly: _availableOnly,
        attributes: attributes,
      ),
    );
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 0.92;

    return SafeArea(
      top: false,
      child: Material(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Row(
                  children: [
                    const SizedBox(width: 40),
                    Expanded(
                      child: AppText(
                        text: 'Bộ lọc',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray900,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close_rounded),
                      color: AppColors.gray700,
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, thickness: 1),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle('Khoảng giá'),
                      const SizedBox(height: 10),
                      _priceBlock(context),
                      const SizedBox(height: 20),
                      _sectionTitle('Trạng thái hàng'),
                      const SizedBox(height: 10),
                      _stockChip(context),
                      const SizedBox(height: 8),
                      for (final section in _kAttributeSections) ...[
                        const SizedBox(height: 16),
                        _sectionTitle(section.title),
                        const SizedBox(height: 10),
                        _chipWrap(section),
                      ],
                    ],
                  ),
                ),
              ),
              const Divider(height: 1, thickness: 1),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: 'Thiết lập lại',
                        color: AppColors.white,
                        textColor: AppColors.gray900,
                        border: Border.all(color: AppColors.gray300),
                        borderRadius: 12,
                        height: 50,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        onTap: _resetDraft,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton(
                        text: 'Áp dụng',
                        color: AppColors.primary,
                        textColor: AppColors.white,
                        borderRadius: 12,
                        height: 50,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        onTap: _submitApply,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return AppText(
      text: text,
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: AppColors.gray900,
    );
  }

  Widget _priceBlock(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_loadingPrice)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColors.primary,
                  ),
                ),
              ),
            )
          else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: PriceRangeFilterHelper.formatVnPrice(0),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray600,
                ),
                AppText(
                  text: PriceRangeFilterHelper.formatVnPrice(
                    _maxAvailablePrice,
                  ),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray600,
                ),
              ],
            ),
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
                max: _maxAvailablePrice <= 0 ? 1.0 : _maxAvailablePrice,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.gray200,
                labels: RangeLabels(
                  PriceRangeFilterHelper.formatVnPrice(_selectedRange.start),
                  PriceRangeFilterHelper.formatVnPrice(_selectedRange.end),
                ),
                onChanged: (values) {
                  final snappedStart = PriceRangeFilterHelper.snapToStep(
                    values.start,
                  ).clamp(0.0, _maxAvailablePrice).toDouble();
                  final snappedEnd = PriceRangeFilterHelper.snapToStep(
                    values.end,
                  ).clamp(snappedStart, _maxAvailablePrice).toDouble();
                  setState(() {
                    _selectedRange = RangeValues(snappedStart, snappedEnd);
                    _syncMoneyFieldsToRange();
                  });
                },
              ),
            ),
            const SizedBox(height: 6),
            AppText(
              text: 'Hoặc nhập khoảng giá',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.gray700,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _moneyField(_minField)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AppText(
                    text: '—',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray500,
                  ),
                ),
                Expanded(child: _moneyField(_maxField)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _moneyField(TextEditingController c) {
    return TextField(
      controller: c,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      onEditingComplete: _applyParsedFieldsToRange,
      onSubmitted: (_) => _applyParsedFieldsToRange(),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[\d\.\sđ]')),
      ],
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.gray900,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.gray200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.gray200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 1.2),
        ),
      ),
    );
  }

  Widget _stockChip(BuildContext context) {
    final label = context.tr('productList.criteriaReady');
    final selected = _availableOnly;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _selectableChip(
          label: label,
          selected: selected,
          onTap: () => setState(() => _availableOnly = !_availableOnly),
        ),
      ],
    );
  }

  Widget _chipWrap(_AttrSection section) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: section.options
          .map(
            (label) => _selectableChip(
              label: label,
              selected:
                  _selectedByKey[section.queryKey]?.contains(label) ?? false,
              onTap: () {
                setState(() {
                  final set = _selectedByKey.putIfAbsent(
                    section.queryKey,
                    () => {},
                  );
                  if (set.contains(label)) {
                    set.remove(label);
                  } else {
                    set.add(label);
                  }
                });
              },
            ),
          )
          .toList(),
    );
  }

  Widget _selectableChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary.withValues(alpha: 0.1)
                : AppColors.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.gray300,
              width: 1,
            ),
          ),
          child: AppText(
            text: label,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.primary : AppColors.gray900,
          ),
        ),
      ),
    );
  }
}
