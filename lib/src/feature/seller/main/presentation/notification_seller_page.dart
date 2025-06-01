import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';

class NotificationSellerPage extends StatefulWidget {
  const NotificationSellerPage({super.key});

  @override
  State<NotificationSellerPage> createState() => _NotificationSellerPageState();
}

class _NotificationSellerPageState extends State<NotificationSellerPage> {
  final List<_NotificationItem> todayNotifications = [
    _NotificationItem(
      icon: Icons.notifications,
      title: 'Доставка выполнена',
      message: 'Ваш заказ №1234 успешно доставлен. Спасибо за покупку!',
      isRead: false,
    ),
    _NotificationItem(
      icon: Icons.local_offer,
      title: 'Скидка 10% на следующую покупку',
      message: 'Используйте промокод WELCOME10 и получите скидку.',
      isRead: true,
    ),
  ];

  final List<_NotificationItem> yesterdayNotifications = [
    _NotificationItem(
      icon: Icons.message,
      title: 'Задержка доставки',
      message:
          'Извините, доставка заказа №1234 задерживается. Мы уже работаем над этим.',
      isRead: false,
    ),
    _NotificationItem(
      icon: Icons.info,
      title: 'Обновление приложения',
      message:
          'Вышла новая версия приложения. Обновитесь, чтобы получить новые функции.',
      isRead: true,
    ),
    _NotificationItem(
      icon: Icons.star,
      title: 'Оцените нас',
      message:
          'Вам понравилось пользоваться приложением? Пожалуйста, оставьте отзыв!',
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Уведомления', style: AppTextStyles.appBarTextStyle),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Сегодня'),
          const SizedBox(height: 8),
          NotificationGroup(notifications: todayNotifications),
          const SizedBox(height: 24),
          const Text('Вчера'),
          const SizedBox(height: 8),
          NotificationGroup(notifications: yesterdayNotifications),
        ],
      ),
    );
  }
}

class NotificationGroup extends StatelessWidget {
  final List<_NotificationItem> notifications;

  const NotificationGroup({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(notifications.length, (index) {
        final n = notifications[index];
        return NotificationCard(
          icon: n.icon,
          title: n.title,
          message: n.message,
          isRead: n.isRead,
          isFirst: index == 0,
          isLast: index == notifications.length - 1,
        );
      }),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final bool isRead;
  final bool isFirst;
  final bool isLast;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.isRead,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kGray,
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(12) : Radius.zero,
          bottom: isLast ? const Radius.circular(12) : Radius.zero,
        ),
      ),
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: isLast ? 0 : 1), // тонкая линия между
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.mainPurpleColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.mainPurpleColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.appBarTextStyle),
                const SizedBox(height: 8),
                Text(
                  message,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.categoryTextStyle,
                ),
              ],
            ),
          ),
          if (!isRead) const Icon(Icons.circle, size: 12, color: Colors.red),
        ],
      ),
    );
  }
}

class _NotificationItem {
  final IconData icon;
  final String title;
  final String message;
  final bool isRead;

  const _NotificationItem({
    required this.icon,
    required this.title,
    required this.message,
    this.isRead = false,
  });
}
