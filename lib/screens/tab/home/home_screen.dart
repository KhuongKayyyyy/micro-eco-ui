import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/screens/tab/home/home_screen_controller.dart';
import 'package:flutter/material.dart';

class HomeScreen extends BaseScreen<HomeScreenController> {
  const HomeScreen({super.key});

  Widget _buildHomeAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppBar(
        title: AppText(text: 'Home', fontSize: 40, fontWeight: FontWeight.w800),
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () => controller.navigateToNotificationScreen(),
            icon: Icon(
              Icons.notifications_none_outlined,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: _buildHomeAppBar(context),
      ),
      body: Text('Home'),
    );
  }
}
