import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';

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
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
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
            height: 8,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 12, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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
                        size: 14,
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 12, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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
                        size: 14,
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 12, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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
                        size: 14,
                      )
                    ],
                  ),
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
