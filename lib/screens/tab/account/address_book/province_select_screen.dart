import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/model/address_model.dart';
import 'package:ecommerce_app/screens/tab/account/address_book/province_select_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProvinceSelectScreen extends BaseScreen<ProvinceSelectScreenController> {
  const ProvinceSelectScreen({super.key});

  static const Color _accentCoral = Color(0xFFFF5C4D);
  static const double _hPad = 16;

  @override
  Color? get backgroundColor => AppColors.gray100;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Obx(() {
        final onWardStep = controller.step.value == LocationPickStep.ward;
        return AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leadingWidth: 48,
          leading: IconButton(
            onPressed: onWardStep
                ? controller.goBackToProvinceList
                : () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: _accentCoral,
              size: 20,
            ),
          ),
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.centerLeft,
              child: TextField(
                onChanged: controller.onSearchChanged,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray900,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: context.tr('locationPicker.searchHint'),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: AppColors.gray500,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: AppColors.gray500,
                    size: 22,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          actions: [
            if (controller.step.value == LocationPickStep.ward &&
                controller.selectedWard.value != null)
              TextButton(
                onPressed: controller.confirmSelection,
                child: AppText(
                  text: context.tr('locationPicker.done'),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _accentCoral,
                ),
              ),
            if (controller.showReset)
              TextButton(
                onPressed: controller.reset,
                child: AppText(
                  text: context.tr('locationPicker.reset'),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _accentCoral,
                ),
              ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1, thickness: 1, color: Color(0xFFEDEDED)),
          ),
        );
      }),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingProvinces.value && controller.provinces.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (controller.showUseCurrentLocation) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(_hPad, 12, _hPad, 8),
              child: _UseLocationCard(
                label: context.tr('locationPicker.useCurrentLocation'),
                onTap: controller.onUseCurrentLocation,
              ),
            ),
          ],
          if (controller.selectedProvince.value != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(_hPad, 4, _hPad, 8),
              child: _SelectedSummary(
                province: controller.selectedProvince.value,
                ward: controller.selectedWard.value,
                onTapProvince: controller.openProvinceListFromSummary,
              ),
            ),
          Expanded(
            child: controller.step.value == LocationPickStep.province
                ? _ProvinceList(
                    accent: _accentCoral,
                    provinces: controller.filteredProvinces,
                    selected: controller.selectedProvince.value,
                    sectionTitle: context.tr('locationPicker.provinceSection'),
                    onSelect: controller.onSelectProvince,
                  )
                : _WardList(
                    accent: _accentCoral,
                    isLoading: controller.isLoadingWards.value,
                    wards: controller.filteredWards,
                    selected: controller.selectedWard.value,
                    sectionTitle: context.tr('locationPicker.wardSection'),
                    onSelect: controller.onSelectWard,
                  ),
          ),
        ],
      );
    });
  }
}

class _UseLocationCard extends StatelessWidget {
  const _UseLocationCard({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 1,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                color: Colors.red.shade400,
                size: 26,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppText(
                  text: label,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gray900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectedSummary extends StatelessWidget {
  const _SelectedSummary({
    required this.province,
    required this.ward,
    required this.onTapProvince,
  });

  final ProvinceModel? province;
  final WardModel? ward;
  final VoidCallback onTapProvince;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: context.tr('locationPicker.selectedArea'),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.gray500,
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: onTapProvince,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Dot(active: ward == null),
                const SizedBox(width: 10),
                Expanded(
                  child: AppText(
                    text: province?.name ?? '',
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: ward == null
                        ? const Color(0xFFFF5C4D)
                        : AppColors.gray900,
                  ),
                ),
              ],
            ),
          ),
          if (ward != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 2, bottom: 2),
              child: Container(width: 2, height: 12, color: AppColors.gray300),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Dot(active: true),
                const SizedBox(width: 10),
                Expanded(
                  child: AppText(
                    text: ward!.name,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFFF5C4D),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final accent = const Color(0xFFFF5C4D);
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: active ? accent : AppColors.gray400,
            width: 2,
          ),
          color: active ? accent : Colors.transparent,
        ),
      ),
    );
  }
}

List<MapEntry<String, List<T>>> _groupAlphabetically<T>(
  List<T> items,
  String Function(T) label,
) {
  final map = <String, List<T>>{};
  for (final item in items) {
    final name = label(item);
    final key = name.isEmpty
        ? '#'
        : name.characters.take(1).toString().toUpperCase();
    map.putIfAbsent(key, () => []).add(item);
  }
  final keys = map.keys.toList()..sort();
  return [for (final k in keys) MapEntry(k, map[k]!)];
}

class _ProvinceList extends StatelessWidget {
  const _ProvinceList({
    required this.accent,
    required this.provinces,
    required this.selected,
    required this.sectionTitle,
    required this.onSelect,
  });

  final Color accent;
  final List<ProvinceModel> provinces;
  final ProvinceModel? selected;
  final String sectionTitle;
  final void Function(ProvinceModel) onSelect;

  @override
  Widget build(BuildContext context) {
    if (provinces.isEmpty) {
      return Center(
        child: AppText(
          text: context.tr('locationPicker.noResults'),
          fontSize: 14,
          color: AppColors.gray600,
        ),
      );
    }

    final groups = _groupAlphabetically(provinces, (p) => p.name);

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        _SectionHeaderBar(title: sectionTitle),
        ...groups.expand((g) sync* {
          yield _LetterRow(
            letter: g.key,
            children: [
              for (final p in g.value)
                _SelectTile(
                  label: p.name,
                  selected: selected?.code == p.code,
                  accent: accent,
                  onTap: () => onSelect(p),
                ),
            ],
          );
        }),
      ],
    );
  }
}

class _WardList extends StatelessWidget {
  const _WardList({
    required this.accent,
    required this.isLoading,
    required this.wards,
    required this.selected,
    required this.sectionTitle,
    required this.onSelect,
  });

  final Color accent;
  final bool isLoading;
  final List<WardModel> wards;
  final WardModel? selected;
  final String sectionTitle;
  final void Function(WardModel) onSelect;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (wards.isEmpty) {
      return Center(
        child: AppText(
          text: context.tr('locationPicker.noResults'),
          fontSize: 14,
          color: AppColors.gray600,
        ),
      );
    }

    final groups = _groupAlphabetically(wards, (w) => w.name);

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        _SectionHeaderBar(title: sectionTitle),
        ...groups.expand((g) sync* {
          yield _LetterRow(
            letter: g.key,
            children: [
              for (final w in g.value)
                _SelectTile(
                  label: w.name,
                  selected: selected?.code == w.code,
                  accent: accent,
                  onTap: () => onSelect(w),
                ),
            ],
          );
        }),
      ],
    );
  }
}

class _SectionHeaderBar extends StatelessWidget {
  const _SectionHeaderBar({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.gray100,
      child: AppText(
        text: title,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.gray600,
      ),
    );
  }
}

class _LetterRow extends StatelessWidget {
  const _LetterRow({required this.letter, required this.children});

  final String letter;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: AppText(
                text: letter,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.gray400,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectTile extends StatelessWidget {
  const _SelectTile({
    required this.label,
    required this.selected,
    required this.accent,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFEDEDED))),
          ),
          child: Row(
            children: [
              Expanded(
                child: AppText(
                  text: label,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: selected ? accent : AppColors.gray900,
                ),
              ),
              if (selected) Icon(Icons.check_rounded, color: accent, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
