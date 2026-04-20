import 'package:ecommerce_app/common/services/navigation_payload_store.dart';
import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:ecommerce_app/data/service/product_service.dart';
import 'package:ecommerce_app/model/product/product_detail_model.dart';
import 'package:ecommerce_app/screens/product/product_detail/components/product_variant_section.dart';
import 'package:get/get.dart';

class ProductDetailScreenController extends GetxController {
  late final String productId;
  final isLoading = false.obs;
  final detail = Rxn<ProductDetailModel>();
  final storageVariants = <ProductDetailModel>[].obs;
  final selectedStorageIndex = 0.obs;
  final selectedColorIndex = 0.obs;
  final selectedColorImage = RxnString();
  final errorMessage = RxnString();

  @override
  void onInit() {
    super.onInit();
    final directParam = (Get.parameters['productId'] ?? '').trim();
    if (directParam.isNotEmpty) {
      productId = directParam;
    } else {
      final saved = Get.find<NavigationPayloadStore>().consume(
        AppRoutes.productDetail,
      );
      productId = (saved['productId'] ?? '').trim();
    }
    _loadProductDetail();
  }

  Future<void> _loadProductDetail() async {
    if (productId.isEmpty) {
      errorMessage.value = 'Missing product id';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;
    try {
      final data = await ProductService.getProductDetailById(productId);
      detail.value = data;
      _resetColorSelection(data);
      await _loadStorageVariants(data);
    } catch (_) {
      errorMessage.value = 'Không thể tải thông tin sản phẩm';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadStorageVariants(ProductDetailModel selected) async {
    try {
      final variants = await ProductService.getStorageVariantsByName(selected.name);
      if (variants.isEmpty) {
        storageVariants.assignAll([selected]);
        selectedStorageIndex.value = 0;
        _resetColorSelection(selected);
        return;
      }
      storageVariants.assignAll(variants);
      final index = variants.indexWhere((e) => e.id == selected.id);
      selectedStorageIndex.value = index >= 0 ? index : 0;
      _resetColorSelection(selected);
    } catch (_) {
      storageVariants.assignAll([selected]);
      selectedStorageIndex.value = 0;
      _resetColorSelection(selected);
    }
  }

  Future<void> onSelectStorage(int index) async {
    if (index < 0 || index >= storageVariants.length) return;
    if (index == selectedStorageIndex.value) return;

    final target = storageVariants[index];
    final targetId = target.id.trim();
    if (targetId.isEmpty) return;

    selectedStorageIndex.value = index;
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final fullDetail = await ProductService.getProductDetailById(targetId);
      detail.value = fullDetail;
      _resetColorSelection(fullDetail);
    } catch (_) {
      errorMessage.value = 'Không thể tải thông tin phiên bản đã chọn';
    } finally {
      isLoading.value = false;
    }
  }

  void onSelectColor(int index) {
    final d = detail.value;
    if (d == null) return;
    if (index < 0 || index >= d.variants.length) return;
    selectedColorIndex.value = index;
    selectedColorImage.value = d.variants[index].image.trim().isEmpty
        ? null
        : d.variants[index].image.trim();
  }

  List<ProductStorageOption> get storageOptions {
    if (storageVariants.isEmpty) return const [];
    return storageVariants
        .map(
          (e) => ProductStorageOption(
            label: _extractStorageLabel(e.name),
            selected: false,
          ),
        )
        .toList();
  }

  List<ProductColorOption> get colorOptions {
    final d = detail.value;
    if (d == null || d.variants.isEmpty) return const [];
    return d.variants
        .map(
          (v) => ProductColorOption(
            name: v.name,
            image: v.image,
            price: _priceFromVariantValue(v.value) ?? d.price,
            selected: false,
          ),
        )
        .toList();
  }

  double get displayPrice {
    final d = detail.value;
    if (d == null) return 0;
    if (d.variants.isEmpty) return d.price;
    final i = selectedColorIndex.value;
    if (i < 0 || i >= d.variants.length) return d.price;
    return _priceFromVariantValue(d.variants[i].value) ?? d.price;
  }

  void _resetColorSelection(ProductDetailModel d) {
    selectedColorIndex.value = 0;
    if (d.variants.isEmpty) {
      selectedColorImage.value = null;
      return;
    }
    final firstImage = d.variants.first.image.trim();
    selectedColorImage.value = firstImage.isEmpty ? null : firstImage;
  }

  String _extractStorageLabel(String name) {
    final regex = RegExp(r'(\d+\s?(?:TB|GB))', caseSensitive: false);
    final matches = regex.allMatches(name).toList();
    final match = matches.isEmpty ? null : matches.last;
    if (match != null) {
      return match.group(0)?.toUpperCase().replaceAll(' ', '') ?? name;
    }
    return name;
  }

  double? _priceFromVariantValue(String? raw) {
    if (raw == null) return null;
    final digits = raw.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.isEmpty) return null;
    return double.tryParse(digits);
  }
}
