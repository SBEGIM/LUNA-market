import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/bloger/shop/bloc/blogger_notification_cubit.dart';
import 'package:haji_market/src/feature/bloger/shop/bloc/blogger_notification_state.dart';
import 'package:haji_market/src/feature/product/data/model/product_model.dart';

class NotificationBloggerPage extends StatefulWidget {
  const NotificationBloggerPage({super.key});

  @override
  State<NotificationBloggerPage> createState() =>
      _NotificationBloggerPageState();
}

class _NotificationBloggerPageState extends State<NotificationBloggerPage> {
  List<_NotificationItem> todayNotifications = [];

  final List<_NotificationItem> yesterdayNotifications = [];

  IconData getIconByType(String type) {
    switch (type) {
      case 'news':
        return Icons.article;
      case 'basket':
        return Icons.shopping_basket;
      case 'order':
        return Icons.shopping_cart;
      case 'update':
        return Icons.update;
      default:
        return Icons.notifications;
    }
  }

  @override
  void initState() {
    BlocProvider.of<BloggerNotificationCubit>(context).notifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Уведомления', style: AppTextStyles.appBarTextStyle),
        leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<BloggerNotificationCubit, BloggerNotificationState>(
        builder: (context, state) {
          if (state is LoadedState) {
            final now = DateTime.now();
            final today = <_NotificationItem>[];
            final yesterday = <_NotificationItem>[];
            final other = <_NotificationItem>[];

            for (final n in state.notifications) {
              final date = DateTime.parse(n.created_at!);

              final isToday = date.year == now.year &&
                  date.month == now.month &&
                  date.day == now.day;

              final isYesterday = date.year == now.year &&
                  date.month == now.month &&
                  date.day == now.day - 1;

              if (isToday) {
                today.add(_NotificationItem(
                  icon: getIconByType(n.type!),
                  title: n.title!,
                  message: n.description!,
                  isRead: false,
                ));
              } else if (isYesterday) {
                yesterday.add(_NotificationItem(
                  icon: getIconByType(n.type!),
                  title: n.title!,
                  message: n.description!,
                  isRead: false,
                ));
              } else {
                other.add(_NotificationItem(
                  icon: getIconByType(n.type!),
                  title: n.title!,
                  message: n.description!,
                  isRead: false,
                ));
              }
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (today.isNotEmpty) ...[
                  const Text('Сегодня',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  NotificationGroup(
                    notifications: today
                        .map((n) => _NotificationItem(
                              icon: n.icon,
                              title: n.title,
                              message: n.message,
                              isRead: false,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                ],
                if (yesterday.isNotEmpty) ...[
                  const Text('Вчера',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  NotificationGroup(
                    notifications: yesterday
                        .map((n) => _NotificationItem(
                              icon: n.icon,
                              title: n.title,
                              message: n.message,
                              isRead: false,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                ],
                if (other.isNotEmpty) ...[
                  const Text('Ранее',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  NotificationGroup(
                    notifications: other
                        .map((n) => _NotificationItem(
                              icon: n.icon,
                              title: n.title,
                              message: n.message,
                              isRead: false,
                            ))
                        .toList(),
                  ),
                ],
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        listener: (context, state) {},
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
