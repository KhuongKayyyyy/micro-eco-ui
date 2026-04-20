import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/model/product/product_detail_model.dart';
import 'package:flutter/material.dart';

class ProductTechnicalInfoTable extends StatelessWidget {
  const ProductTechnicalInfoTable({super.key, required this.attributes});

  final List<ProductDetailAttribute> attributes;

  @override
  Widget build(BuildContext context) {
    if (attributes.isEmpty) return const SizedBox.shrink();

    final grouped = _groupAttributes(attributes);
    final previewRows = <ProductDetailAttribute>[
      for (final entry in grouped.entries) ...entry.value.take(2),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: context.tr('productDetail.technicalInfo'),
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: AppColors.gray900,
        ),
        const SizedBox(height: 10),
        _SpecsTable(rows: previewRows),
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: () => _showAllSpecs(context, grouped),
            child: AppText(
              text: context.tr('productDetail.viewAllSpecs'),
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.statusInfo,
            ),
          ),
        ),
      ],
    );
  }

  void _showAllSpecs(
    BuildContext context,
    LinkedHashMap<String, List<ProductDetailAttribute>> grouped,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                    ),
                    Expanded(
                      child: AppText(
                        text: context.tr('productDetail.technicalInfo'),
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray900,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
                  children: [
                    for (final entry in grouped.entries) ...[
                      AppText(
                        text: entry.key,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray900,
                      ),
                      const SizedBox(height: 8),
                      _SpecsTable(rows: entry.value),
                      const SizedBox(height: 14),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  LinkedHashMap<String, List<ProductDetailAttribute>> _groupAttributes(
    List<ProductDetailAttribute> rows,
  ) {
    final map = LinkedHashMap<String, List<ProductDetailAttribute>>();
    for (final row in rows) {
      final name = row.name.trim();
      final value = row.value.trim();
      if (name.isEmpty || value.isEmpty) continue;
      final group = _resolveGroupTitle(row);
      map.putIfAbsent(group, () => <ProductDetailAttribute>[]).add(row);
    }
    return map;
  }

  String _resolveGroupTitle(ProductDetailAttribute attribute) {
    final fromApi = attribute.group.trim();
    if (fromApi.isNotEmpty) return fromApi;

    final key = _normalize(attribute.name);
    if (_containsAny(key, ['man hinh', 'display', 'screen'])) return 'Màn hình';
    if (_containsAny(key, ['camera', 'quay video'])) return 'Camera';
    if (_containsAny(key, [
      'chip',
      'cpu',
      'gpu',
      'ram',
      'bo nho',
      'nho trong',
    ])) {
      return 'Hiệu năng';
    }
    if (_containsAny(key, ['sim', 'nfc', 'gps', 'wifi', 'bluetooth', '5g'])) {
      return 'Kết nối';
    }
    if (_containsAny(key, ['pin', 'sac', 'cong sac'])) return 'Pin & sạc';
    if (_containsAny(key, ['kich thuoc', 'trong luong', 'khang nuoc'])) {
      return 'Thiết kế';
    }
    if (_containsAny(key, ['he dieu hanh', 'os'])) return 'Hệ điều hành';
    return 'Thông tin khác';
  }

  String _normalize(String input) {
    const withDiacritics =
        'àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễ'
        'ìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ'
        'ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄ'
        'ÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ';
    const withoutDiacritics =
        'aaaaaaaaaaaaaaaaaeeeeeeeeeee'
        'iiiiiooooooooooooooooouuuuuuuuuuuuyyyyyd'
        'AAAAAAAAAAAAAAAAAEEEEEEEEEEE'
        'IIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUUYYYYYD';
    var out = input;
    for (var i = 0; i < withDiacritics.length; i++) {
      out = out.replaceAll(withDiacritics[i], withoutDiacritics[i]);
    }
    return out.toLowerCase();
  }

  bool _containsAny(String source, List<String> candidates) {
    for (final candidate in candidates) {
      if (source.contains(candidate)) return true;
    }
    return false;
  }
}

class _SpecsTable extends StatelessWidget {
  const _SpecsTable({required this.rows});

  final List<ProductDetailAttribute> rows;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            for (int i = 0; i < rows.length; i++)
              _SpecsRow(
                title: rows[i].name,
                value: rows[i].value,
                isLast: i == rows.length - 1,
              ),
          ],
        ),
      ),
    );
  }
}

class _SpecsRow extends StatelessWidget {
  const _SpecsRow({
    required this.title,
    required this.value,
    required this.isLast,
  });

  final String title;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: AppColors.gray200)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 36,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
                color: AppColors.gray100,
                child: AppText(
                  text: title,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray900,
                ),
              ),
            ),
            Expanded(
              flex: 64,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: AppText(
                  text: value,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
