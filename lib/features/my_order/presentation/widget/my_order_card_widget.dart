import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/my_order/presentation/widget/my_order_status_page.dart';

class MyOrderCardWidget extends StatelessWidget {
  const MyOrderCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Сегодня',
          style: TextStyle(
              color: AppColors.kGray300,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Доставка будет завтра',
                style:  TextStyle(
                    color: AppColors.kGray900,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              Image.asset(
                'assets/images/wireles.png',
                height: 80,
                width: 80,
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Заказ №12345678',
                style: TextStyle(
                    color: AppColors.kGray900,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              const Divider(
                color: AppColors.kGray300,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyOrderStatusPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Детали заказа',
                      style: TextStyle(color: AppColors.kPrimaryColor),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.kPrimaryColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
