import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Уведомления',
          style: TextStyle(
              color: AppColors.kGray900,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        // actions: const [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 16.0),
        //     child: Icon(
        //       Icons.notifications_active,
        //       color: AppColors.kPrimaryColor,
        //     ),
        //   )
        // ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:const [
                    Text(
                      'Транзакции',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.kPrimaryColor,
                    )
                  ],
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const[
                    Text(
                      'Бонусы',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.kPrimaryColor,
                    )
                  ],
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:const [
                    Text(
                      'Акции',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.kPrimaryColor,
                    )
                  ],
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                // SizedBox(height: 8,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
