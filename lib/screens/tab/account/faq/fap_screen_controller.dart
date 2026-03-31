import 'dart:async';

import 'package:ecommerce_app/data/service/faq_serivce.dart';
import 'package:ecommerce_app/model/faq_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqScreenController extends GetxController {
  static const int pageSize = 10;

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchTextController = TextEditingController();

  final RxList<FaqModel> faqs = <FaqModel>[].obs;
  final RxBool isLoadingInitial = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool isSearching = false.obs;
  final RxBool hasMore = true.obs;

  /// one of: general, account, service, payment, order, all
  final RxString selectedType = 'all'.obs;

  int _page = 1;
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    fetchFirst();
  }

  void _onScroll() {
    if (isSearching.value) return;
    if (!hasMore.value) return;
    if (isLoadingMore.value) return;

    final max = scrollController.position.maxScrollExtent;
    final current = scrollController.position.pixels;

    // Trigger a bit before the end.
    if (current >= max - 250) {
      fetchMore();
    }
  }

  Future<void> fetchFirst() async {
    _page = 1;
    hasMore.value = true;
    isSearching.value = false;
    isLoadingMore.value = false;

    faqs.clear();
    isLoadingInitial.value = true;

    await _loadPage(_page);
  }

  Future<void> fetchMore() async {
    if (isLoadingMore.value) return;
    if (!hasMore.value) return;

    isLoadingMore.value = true;
    await _loadPage(_page + 1);
  }

  Future<void> _loadPage(int page) async {
    try {
      final next = await FaqService.getFaqsByType(
        selectedType.value,
        page,
        pageSize,
      );
      if (page == 1) {
        faqs.assignAll(next);
      } else {
        faqs.addAll(next);
      }

      _page = page;
      hasMore.value = next.length >= pageSize;
    } finally {
      isLoadingInitial.value = false;
      isLoadingMore.value = false;
    }
  }

  void onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      final q = query.trim();
      if (q.isEmpty) {
        await fetchFirst();
        return;
      }
      await searchFaqs(q);
    });
  }

  Future<void> searchFaqs(String query) async {
    isSearching.value = true;
    hasMore.value = false;
    isLoadingMore.value = false;
    isLoadingInitial.value = true;
    faqs.clear();

    try {
      final results = await FaqService.searchFaqsByType(
        query,
        selectedType.value,
      );
      faqs.assignAll(results);
    } finally {
      isLoadingInitial.value = false;
    }
  }

  void onFilterChanged(String type) {
    selectedType.value = type;

    final q = searchTextController.text.trim();
    if (q.isEmpty) {
      fetchFirst();
      return;
    }
    searchFaqs(q);
  }

  @override
  void onClose() {
    _debounce?.cancel();
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    searchTextController.dispose();
    super.onClose();
  }
}
