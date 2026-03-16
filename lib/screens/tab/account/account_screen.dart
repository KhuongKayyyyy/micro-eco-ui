import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/screens/tab/account/account_screen_controller.dart';
import 'package:flutter/material.dart';

class AccountScreen extends BaseScreen<AccountScreenController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('account screen');
  }

  @override
  Widget buildBody(BuildContext context) {
    throw UnimplementedError();
  }
}
