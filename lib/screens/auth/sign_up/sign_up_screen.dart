import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/screens/auth/sign_up/sign_up_screen_controller.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends BaseScreen<SignUpScreenController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('sign up screen');
  }

  @override
  Widget buildBody(BuildContext context) {
    throw UnimplementedError();
  }
}
