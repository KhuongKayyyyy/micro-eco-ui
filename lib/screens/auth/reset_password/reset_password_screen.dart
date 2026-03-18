import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/screens/auth/reset_password/reset_password_screen_controller.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends BaseScreen<ResetPasswordScreenController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Text('reset password screen');
  }
}
