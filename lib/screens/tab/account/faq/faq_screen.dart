import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/global_app_bar.dart';
import 'package:ecommerce_app/components/general/global_search_bar.dart';
import 'package:ecommerce_app/screens/tab/account/faq/fap_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:ecommerce_app/components/account/faq_item.dart';
import 'package:get/get.dart';

class FaqScreen extends BaseScreen<FaqScreenController> {
  const FaqScreen({super.key});

  @override
  buildAppBar(BuildContext context) {
    return GlobalAppBar(title: context.tr('account.faqs'), isTitleCenter: true);
  }

  @override
  Widget buildBody(BuildContext context) {
    return Obx(
      () => CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 10),
              child: _buildFilterSection(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GlobalSearchBar(
                controller: controller.searchTextController,
                onChanged: controller.onSearchChanged,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final isInitialLoading =
                      controller.isLoadingInitial.value &&
                      controller.faqs.isEmpty;

                  if (isInitialLoading) {
                    return const _FaqSkeletonCard();
                  }

                  final faqs = controller.faqs;
                  final showLoadingMoreRow =
                      controller.isLoadingMore.value && index == faqs.length;

                  if (showLoadingMoreRow) {
                    return const _FaqSkeletonCard();
                  }

                  if (index >= faqs.length) return const SizedBox.shrink();

                  return FaqItem(faq: faqs[index]);
                },
                childCount:
                    controller.faqs.isEmpty && controller.isLoadingInitial.value
                    ? FaqScreenController.pageSize
                    : controller.faqs.length +
                          ((controller.isLoadingMore.value) ? 1 : 0),
              ),
            ),
          ),
          if (!controller.isLoadingInitial.value &&
              controller.faqs.isEmpty &&
              !controller.isSearching.value)
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context) {
    final filters = <Map<String, String>>[
      {'label': 'All', 'type': 'all'},
      {'label': 'General', 'type': 'general'},
      {'label': 'Account', 'type': 'account'},
      {'label': 'Service', 'type': 'service'},
      {'label': 'Payments', 'type': 'payment'},
    ];

    return SizedBox(
      height: 46,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = filters[index];
          final label = item['label']!;
          final type = item['type']!;

          final selected = controller.selectedType.value == type;

          return InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => controller.onFilterChanged(type),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: selected ? Colors.black : const Color(0xFFEDEDED),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: selected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FaqSkeletonCard extends StatelessWidget {
  const _FaqSkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEDEDED), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 16, 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeletonizer(
                      enabled: true,
                      child: Container(
                        height: 22,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Skeletonizer(
                      enabled: true,
                      child: Container(
                        height: 18,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Skeletonizer(
                enabled: true,
                child: Container(width: 26, height: 26, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
