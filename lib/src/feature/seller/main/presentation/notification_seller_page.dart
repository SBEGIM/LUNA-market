import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/seller/main/cubit/seller_notification_cubit.dart';
import 'package:haji_market/src/feature/seller/main/cubit/seller_notification_state.dart';
import 'package:haji_market/src/feature/seller/main/data/model/notification_seller_dto.dart';
import 'package:haji_market/src/feature/seller/main/data/model/notification_seller_model.dart';
import 'package:haji_market/src/feature/seller/main/presentation/widget/show_notifiction_seller_widget.dart';

class NotificationSellerPage extends StatefulWidget {
  const NotificationSellerPage({super.key});

  @override
  State<NotificationSellerPage> createState() => _NotificationSellerPageState();
}

class _NotificationSellerPageState extends State<NotificationSellerPage> {
  List<NotificationSellerModel> todayNotifications = [];
  List<NotificationSellerModel> otherNotifications = [];
  List<NotificationSellerModel> yesterdayNotifications = [];

  final now = DateTime.now();
  List<NotificationSellerModel> today = [];
  List<NotificationSellerModel> yesterday = [];
  List<NotificationSellerModel> other = [];

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
    BlocProvider.of<SellerNotificationCubit>(context).notifications();
    super.initState();
  }

  bool isYesterday = false;

  bool isToday = false;

  void groupNotifications(List<NotificationSellerModel> notifications) {
    final now = DateTime.now();
    todayNotifications.clear();
    yesterdayNotifications.clear();
    otherNotifications.clear();

    for (final n in notifications) {
      final date = DateTime.parse(n.created_at!);
      final isToday = date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;
      final isYesterday = date.year == now.year &&
          date.month == now.month &&
          date.day == now.day - 1;

      final notification = n.copyWith(
        icon: getIconByType(n.type!),
      );

      if (isToday) {
        todayNotifications.add(notification);
      } else if (isYesterday) {
        yesterdayNotifications.add(notification);
      } else {
        otherNotifications.add(notification);
      }
    }
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
      body: BlocConsumer<SellerNotificationCubit, SellerNotificationState>(
        listener: (context, state) {
          if (state is LoadedState) {
            today.clear();
            yesterday.clear();
            other.clear();

            for (final n in state.notifications) {
              final date = DateTime.parse(n.created_at!);

              isToday = date.year == now.year &&
                  date.month == now.month &&
                  date.day == now.day;

              isYesterday = date.year == now.year &&
                  date.month == now.month &&
                  date.day == now.day - 1;

              if (isToday) {
                today.add(NotificationSellerModel(
                  id: n.id!,
                  icon: getIconByType(n.type!),
                  title: n.title!,
                  description: n.description!,
                  isRead: n.isRead,
                ));
              } else if (isYesterday) {
                yesterday.add(NotificationSellerModel(
                  id: n.id!,
                  icon: getIconByType(n.type!),
                  title: n.title!,
                  description: n.description!,
                  isRead: n.isRead,
                ));
              } else {
                other.add(NotificationSellerModel(
                  id: n.id!,
                  icon: getIconByType(n.type!),
                  title: n.title!,
                  description: n.description!,
                  isRead: n.isRead,
                ));
              }
            }

            print('qqqq');
            setState(() {});
          }
        },
        builder: (context, state) {
          if (state is LoadedState) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (today.isNotEmpty) ...[
                  const Text('Сегодня',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  NotificationGroup(
                    notifications: today
                        .map((n) => NotificationSellerModel(
                              id: n.id,
                              icon: n.icon,
                              title: n.title,
                              description: n.description,
                              isRead: n.isRead,
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
                        .map((n) => NotificationSellerModel(
                              id: n.id,
                              icon: n.icon,
                              title: n.title,
                              description: n.description,
                              isRead: n.isRead,
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
                        .map((n) => NotificationSellerModel(
                              id: n.id,
                              icon: n.icon,
                              title: n.title,
                              description: n.description,
                              isRead: n.isRead,
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
      ),
    );
  }
}

class NotificationGroup extends StatelessWidget {
  final List<NotificationSellerModel> notifications;

  const NotificationGroup({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(notifications.length, (index) {
        final n = notifications[index];
        return GestureDetector(
          onTap: () {
            showNotificationSellerOptions(
                context,
                NotificationUiModel(
                    id: n.id!,
                    icon: n.icon!,
                    title: n.title!,
                    message: n.description!,
                    isRead: n.isRead));

            context.read<SellerNotificationCubit>().read(n.id!);
          },
          child: NotificationCard(
            icon: n.icon!,
            title: n.title!,
            description: n.description!,
            isRead: n.isRead,
            isFirst: index == 0,
            isLast: index == notifications.length - 1,
          ),
        );
      }),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isRead;
  final bool isFirst;
  final bool isLast;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
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
                  description,
                  maxLines: 2,
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
