import 'dart:developer';

import 'package:ecommerce_app/common/services/snack_bar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  var isLoginEnabled = false.obs;
  // final AuthService _authService = Get.find<AuthService>();

  // Text field controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    // Reset form to initial state
    _resetForm();

    _checkValidation();
    emailController.addListener(_checkValidation);
    passwordController.addListener(_checkValidation);
  }

  /// Reset form to initial state
  void _resetForm() {
    log('_resetForm called - setting isLoginEnabled to false');
    isLoginEnabled.value = false;
    emailController.clear();
    passwordController.clear();
  }

  /// Reset form when returning to sign in screen
  void resetFormForNewLogin() {
    log('Resetting form for new login');
    _resetForm();
    // Validation will be triggered automatically by text field listeners
    // when user starts typing, so we don't need to call _checkValidation() here
  }

  @override
  void onClose() {
    // Don't dispose controllers since they are reused across screens
    // The controllers will be disposed when the app is closed
    super.onClose();
  }

  /// Clean up controllers when app is closed
  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  ///
  /// Check if both email and password fields have content
  ///
  void _checkValidation() {
    final hasEmail = emailController.text.trim().isNotEmpty;
    final hasPassword = passwordController.text.trim().isNotEmpty;
    final isValid = hasEmail && hasPassword;

    log(
      'Validation check - Email: "${emailController.text.trim()}" (hasEmail: $hasEmail), Password: "${passwordController.text.trim().isNotEmpty ? '[HIDDEN]' : '[EMPTY]'}" (hasPassword: $hasPassword), Valid: $isValid',
    );

    isLoginEnabled.value = isValid;
  }

  ///
  /// Email/Password login
  ///
  Future<void> signInWithEmail() async {
    if (!isLoginEnabled.value) return;

    EasyLoading.show(status: 'signIn.loading'.tr);

    try {
      // final responseDTO = await _authService.signInWithEmail(
      //   email: emailController.text,
      //   password: passwordController.text,
      // );
      // _handleSignInResult(responseDTO);
      // checkStreak();
    } catch (e) {
      EasyLoading.dismiss();
      log('Email 로그인 실패: $e');
      SnackBarService.showSnackBar(
        '${'signIn.emailLoginFailed'.tr}${e.toString()}',
      );
    }
  }

  ///
  /// 네이버 로그인
  ///
  // Future<void> signInWithGoogle() async {
  //   try {
  //     final responseDTO = await _authService.signInWithGoogle();
  //     _handleSignInResult(responseDTO);
  //   } catch (e) {
  //     log('구글 로그인 실패: $e');
  //     SnackBarService.showSnackBar(
  //       '${'signIn.googleLoginFailed'.tr}${e.toString()}',
  //     );
  //   }
  // }

  // ///
  // /// 애플 로그인
  // ///
  // Future<void> signInWithApple() async {
  //   try {
  //     final responseDTO = await _authService.signInWithApple();
  //     _handleSignInResult(responseDTO);
  //   } catch (e) {
  //     log('애플 로그인 실패: $e');
  //     SnackBarService.showSnackBar(
  //       '${'signIn.appleLoginFailed'.tr}${e.toString()}',
  //     );
  //   }
  // }

  // ///
  // /// 네이버 로그인
  // ///
  // // Future<void> signInWithNaver() async {
  // //   try {
  // //     final responseDTO = await _authService.signInWithNaver();
  // //     _handleSignInResult(responseDTO);
  // //   } catch (e) {
  // //     log('네이버 로그인 실패: $e');
  // //     SnackBarService.showSnackBar('네이버 로그인 실패: ${e.toString()}');
  // //   }
  // // }

  // ///
  // /// 카카오 로그인
  // ///
  // Future<void> signInWithKakao() async {
  //   try {
  //     final responseDTO = await _authService.signInWithKakao();
  //     _handleSignInResult(responseDTO);
  //   } catch (e) {
  //     log('Error: $e');
  //     SnackBarService.showSnackBar('${'signIn.error'.tr}${e.toString()}');
  //   }
  // }

  // ///
  // /// Handle sign in result
  // ///
  // Future<void> _handleSignInResult(SignInResponseDTO responseDTO) async {
  //   try {
  //     switch (responseDTO.status) {
  //       // Sign up required
  //       case UserAuthStatus.signUpRequired:
  //         // Save access token
  //         if (responseDTO.accessToken != null) {
  //           await _authService.saveAccessToken(
  //             accessToken: responseDTO.accessToken!.value,
  //           );
  //         }
  //       // todo Navigate to sign up screen

  //       // Banned user
  //       case UserAuthStatus.banned:
  //         EasyLoading.dismiss();
  //         SnackBarService.showSnackBar('signIn.userBanned'.tr);
  //         break;

  //       // Sign up completed status
  //       default:
  //         if (responseDTO.accessToken != null &&
  //             responseDTO.refreshToken != null) {
  //           await _authService.saveToken(
  //             accessToken: responseDTO.accessToken!.value,
  //             refreshToken: responseDTO.refreshToken!.value,
  //           );
  //           EasyLoading.showSuccess('signIn.loginSuccessful'.tr);

  //           // Start badge SSE after successful login
  //           try {
  //             final badgeEventController = Get.find<BadgeEventController>();
  //             badgeEventController.start();
  //           } catch (_) {
  //             // ignore if not available
  //           }
  //         }

  //         // todo Navigate to login completed screen
  //         Get.to(() => TabScreen());
  //     }
  //   } catch (e) {
  //     EasyLoading.dismiss();
  //     SnackBarService.showSnackBar(
  //       '${'signIn.failedToHandleSignIn'.tr}${e.toString()}',
  //     );
  //   }
  // }

  // Future<void> checkStreak() async {
  //   try {
  //     await _authService.checkStreak();
  //     SnackBarService.showSnackBar('signIn.streakChecked'.tr);
  //   } catch (e) {
  //     log('Failed to check streak: ${e.toString()}');
  //     SnackBarService.showSnackBar(
  //       '${'signIn.failedToCheckStreak'.tr}${e.toString()}',
  //     );
  //   }
  // }

  void gotoSignUp() {
    // Get.to(() => SignUpScreen());
  }
}
