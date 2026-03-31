import 'package:ecommerce_app/data/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDetailScreenController extends GetxController {
  final RxBool isLoading = true.obs;

  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString phone = ''.obs;
  final RxString address = ''.obs;
  final RxString gender = ''.obs;
  final RxString dateOfBirth = ''.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final genderController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadUserDetail();
  }

  Future<void> _loadUserDetail() async {
    try {
      isLoading.value = true;

      final userDetail = await UserService.getUserDetail();
      name.value = userDetail.name;
      email.value = userDetail.email;
      phone.value = userDetail.phone;
      address.value = userDetail.address;
      gender.value = userDetail.gender;
      dateOfBirth.value = userDetail.dateOfBirth;

      // Populate text field controllers so the UI has real values
      // after loading finishes.
      nameController.text = userDetail.name;
      emailController.text = userDetail.email;
      phoneNumberController.text = userDetail.phone;
      genderController.text = userDetail.gender;
      dateOfBirthController.text = userDetail.dateOfBirth;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    dateOfBirthController.dispose();
    phoneNumberController.dispose();
    genderController.dispose();
    super.onClose();
  }
}
