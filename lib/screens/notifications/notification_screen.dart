import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/components/notification/notification_components.dart';
import 'package:ecommerce_app/screens/notifications/notification_screen_controller.dart';
import 'package:flutter/material.dart' hide Notification;

class NotificationScreen extends BaseScreen<NotificationScreenController> {
  const NotificationScreen({super.key});

  @override
  Color? get backgroundColor => Colors.white;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Notifications',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      ),
      leading: IconButton(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none, color: Colors.black),
        ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1, thickness: 1, color: Color(0xFFEDEDED)),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    final notifications = controller.notifications;
    if (notifications.isEmpty) {
      return noNotifications(context);
    }

    final now = DateTime.now();

    final Map<String, List<dynamic>> grouped = {};
    for (final n in notifications) {
      final label = _sectionLabel(n.notiTime, now);
      (grouped[label] ??= []).add(n);
    }

    final children = <Widget>[];
    final entries = grouped.entries.toList();
    for (var i = 0; i < entries.length; i++) {
      final entry = entries[i];
      children.add(NotificationComponents.sectionHeader(entry.key));
      for (final n in entry.value) {
        children.add(NotificationComponents.notificationItem(n));
      }

      if (i != entries.length - 1) {
        children.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Divider(height: 1, thickness: 1, color: Color(0xFFEDEDED)),
          ),
        );
      } else {
        children.add(const SizedBox(height: 6));
      }
    }

    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      children: children,
    );
  }

  static Widget noNotifications(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none_outlined,
              size: 76,
              color: Color(0xFFBDBDBD),
            ),
            SizedBox(height: 24),
            AppText(
              text: context.tr("notification.noNotifications"),
              textAlign: TextAlign.center,
              fontSize: 22,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            SizedBox(height: 14),
            AppText(
              text: context.tr("notification.weWillAlertYou"),
              textAlign: TextAlign.center,
              fontSize: 15,
              height: 1.35,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9E9E9E),
            ),
          ],
        ),
      ),
    );
  }
}

bool _isSameDate(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

String _sectionLabel(DateTime date, DateTime now) {
  if (_isSameDate(date, now)) return 'Today';

  final yesterday = now.subtract(const Duration(days: 1));
  if (_isSameDate(date, yesterday)) return 'Yesterday';

  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  final monthName = months[date.month - 1];
  return '$monthName ${date.day}, ${date.year}';
}
