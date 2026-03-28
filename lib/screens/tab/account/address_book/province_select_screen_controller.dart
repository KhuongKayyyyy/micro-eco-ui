import 'package:ecommerce_app/common/utils/vietnamese_search_normalize.dart';
import 'package:ecommerce_app/data/serivce/address_service.dart';
import 'package:ecommerce_app/model/address_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

enum LocationPickStep { province, ward }

class ProvinceSelectScreenController extends GetxController {
  final AddressService _addressService = AddressService();

  final searchQuery = ''.obs;

  final isLoadingProvinces = true.obs;
  final isLoadingWards = false.obs;

  final provinces = <ProvinceModel>[].obs;
  final wards = <WardModel>[].obs;

  final step = LocationPickStep.province.obs;
  final selectedProvince = Rxn<ProvinceModel>();
  final selectedWard = Rxn<WardModel>();

  bool get showUseCurrentLocation => selectedProvince.value == null;
  bool get showReset => selectedProvince.value != null;

  @override
  void onInit() {
    super.onInit();
    _bootstrap();
  }

  /// `Get.arguments` may include `address`: same format as [locationSummary] — comma-separated pieces (province first, ward last; middle segments merge into ward name).
  Future<void> _bootstrap() async {
    await _loadProvinces();
    await _tryRestoreFromAddressArgument();
  }

  String? _addressArgument() {
    final args = Get.arguments;
    if (args is! Map) return null;
    final a = args['address'];
    if (a is! String) return null;
    final t = a.trim();
    return t.isEmpty ? null : t;
  }

  Future<void> _tryRestoreFromAddressArgument() async {
    final raw = _addressArgument();
    if (raw == null) return;

    final parts =
        raw.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    if (parts.length < 2) return;

    final provinceName = parts.first;
    final wardName =
        parts.length > 2 ? parts.sublist(1).join(', ') : parts[1];

    final p = _findProvinceByName(provinceName);
    if (p == null) return;

    selectedProvince.value = p;
    await _loadWards(p.code);

    final w = _findWardByName(wardName);
    selectedWard.value = w;
    step.value = LocationPickStep.ward;
    searchQuery.value = '';
  }

  ProvinceModel? _findProvinceByName(String name) {
    final t = name.trim();
    for (final p in provinces) {
      if (p.name == t) return p;
    }
    final n = normalizeVietnameseForSearch(t);
    for (final p in provinces) {
      if (normalizeVietnameseForSearch(p.name) == n) return p;
    }
    return null;
  }

  WardModel? _findWardByName(String name) {
    final t = name.trim();
    for (final w in wards) {
      if (w.name == t) return w;
    }
    final n = normalizeVietnameseForSearch(t);
    for (final w in wards) {
      if (normalizeVietnameseForSearch(w.name) == n) return w;
    }
    return null;
  }

  /// Uses [geolocator] for GPS, then [geocoding]'s [placemarkFromCoordinates] to resolve text, matched to API province/ward names.
  Future<void> onUseCurrentLocation() async {
    if (provinces.isEmpty) return;
    try {
      EasyLoading.show(status: tr('locationPicker.findingLocation'));

      final serviceOn = await Geolocator.isLocationServiceEnabled();
      if (!serviceOn) {
        EasyLoading.dismiss();
        EasyLoading.showError(tr('locationPicker.locationServiceOff'));
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        EasyLoading.dismiss();
        EasyLoading.showError(tr('locationPicker.locationPermissionDenied'));
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 25),
        ),
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      EasyLoading.dismiss();

      if (placemarks.isEmpty) {
        EasyLoading.showError(tr('locationPicker.locationNoMatch'));
        return;
      }

      final place = placemarks.first;
      final province = _matchProvinceFromPlacemark(place);
      if (province == null) {
        EasyLoading.showError(tr('locationPicker.locationNoMatch'));
        return;
      }

      selectedProvince.value = province;
      selectedWard.value = null;
      step.value = LocationPickStep.ward;
      searchQuery.value = '';
      await _loadWards(province.code);

      final ward = _matchWardFromPlacemark(place);
      selectedWard.value = ward;

      if (ward == null) {
        EasyLoading.showToast(tr('locationPicker.wardPickManually'));
      }
    } on MissingPluginException catch (e, st) {
      EasyLoading.dismiss();
      EasyLoading.showError(tr('locationPicker.nativePluginMissing'));
      debugPrint(
        'onUseCurrentLocation MissingPluginException — fully rebuild the app '
        '(stop run, then flutter clean && cd ios && pod install && cd .. && flutter run). '
        'Hot reload does not register native plugins.\n$e\n$st',
      );
    } catch (e, st) {
      EasyLoading.dismiss();
      EasyLoading.showError(tr('locationPicker.locationError'));
      debugPrint('onUseCurrentLocation: $e\n$st');
    }
  }

  String _placemarkBlob(Placemark p) {
    return [
      p.name,
      p.street,
      p.country,
      p.administrativeArea,
      p.subAdministrativeArea,
      p.locality,
      p.subLocality,
      p.thoroughfare,
      p.subThoroughfare,
    ].whereType<String>().join(' ');
  }

  String _provinceComparableNormalized(String name) {
    var s = normalizeVietnameseForSearch(name);
    for (final prefix in ['thanh pho ', 'tinh ', 'tp ']) {
      if (s.startsWith(prefix)) {
        s = s.substring(prefix.length);
      }
    }
    return s.trim();
  }

  ProvinceModel? _matchProvinceFromPlacemark(Placemark place) {
    final blob = normalizeVietnameseForSearch(_placemarkSearchBlob(place));
    if (blob.isEmpty) return null;

    ProvinceModel? best;
    var bestLen = 0;
    for (final p in provinces) {
      final full = normalizeVietnameseForSearch(p.name);
      final short = _provinceComparableNormalized(p.name);
      for (final cand in {full, short}) {
        if (cand.isEmpty) continue;
        if (blob.contains(cand) && cand.length > bestLen) {
          best = p;
          bestLen = cand.length;
        }
      }
    }
    if (best != null) return best;

    final admin =
        normalizeVietnameseForSearch(place.administrativeArea ?? '');
    if (admin.isEmpty) return null;
    for (final p in provinces) {
      final short = _provinceComparableNormalized(p.name);
      if (short.isNotEmpty &&
          (admin.contains(short) || short.contains(admin))) {
        return p;
      }
    }
    return null;
  }

  /// Prefer fields that usually carry province/city in reverse-geocode results.
  String _placemarkSearchBlob(Placemark p) {
    return [
      p.administrativeArea,
      p.subAdministrativeArea,
      p.locality,
      _placemarkBlob(p),
    ].whereType<String>().join(' ');
  }

  WardModel? _matchWardFromPlacemark(Placemark place) {
    final blob = normalizeVietnameseForSearch(
      [
        place.locality,
        place.subLocality,
        place.subAdministrativeArea,
      ].whereType<String>().join(' '),
    );
    if (blob.isEmpty) return null;

    WardModel? best;
    var bestLen = 0;
    for (final w in wards) {
      final wn = normalizeVietnameseForSearch(w.name);
      final stripped = wn.replaceFirst(
        RegExp(r'^(phuong|xa|thi tran)\s+'),
        '',
      );
      for (final cand in {wn, stripped}) {
        if (cand.isEmpty) continue;
        if (blob.contains(cand) && cand.length > bestLen) {
          best = w;
          bestLen = cand.length;
        }
      }
    }
    return best;
  }

  Future<void> _loadProvinces() async {
    try {
      isLoadingProvinces.value = true;
      final list = await _addressService.getAllProvinces();
      list.sort((a, b) => a.name.compareTo(b.name));
      provinces.assignAll(list);
    } finally {
      isLoadingProvinces.value = false;
    }
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  List<ProvinceModel> get filteredProvinces {
    final q = searchQuery.value;
    if (q.trim().isEmpty) return List<ProvinceModel>.from(provinces);
    return provinces.where((p) => matchesVietnameseSearch(p.name, q)).toList();
  }

  List<WardModel> get filteredWards {
    final q = searchQuery.value;
    if (q.trim().isEmpty) return List<WardModel>.from(wards);
    return wards.where((w) => matchesVietnameseSearch(w.name, q)).toList();
  }

  Future<void> onSelectProvince(ProvinceModel p) async {
    selectedProvince.value = p;
    selectedWard.value = null;
    step.value = LocationPickStep.ward;
    searchQuery.value = '';
    await _loadWards(p.code);
  }

  Future<void> _loadWards(int provinceCode) async {
    try {
      isLoadingWards.value = true;
      wards.clear();
      final list = await _addressService.getWards(provinceCode);
      list.sort((a, b) => a.name.compareTo(b.name));
      wards.assignAll(list);
    } finally {
      isLoadingWards.value = false;
    }
  }

  void onSelectWard(WardModel w) {
    selectedWard.value = w;
  }

  void confirmSelection() {
    final p = selectedProvince.value;
    final w = selectedWard.value;
    if (p == null || w == null) return;
    Get.back(result: {'province': p, 'ward': w});
  }

  void reset() {
    selectedProvince.value = null;
    selectedWard.value = null;
    step.value = LocationPickStep.province;
    wards.clear();
    searchQuery.value = '';
  }

  void goBackToProvinceList() {
    if (step.value == LocationPickStep.ward) {
      step.value = LocationPickStep.province;
      selectedWard.value = null;
      searchQuery.value = '';
    } else {
      Get.back();
    }
  }

  void openProvinceListFromSummary() {
    step.value = LocationPickStep.province;
    selectedWard.value = null;
    searchQuery.value = '';
  }
}
